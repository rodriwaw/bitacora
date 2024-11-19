
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/style_const.dart';
import '../../../../core/utils/injections.dart';
import '../../../../shared/presentation/appbar.dart';
import '../../domain/llaves_model.dart';
import '../../domain/llaves_usecase.dart';
import '../bloc/llaves_bloc.dart';
import 'llave_add_modal.dart';
import 'llave_edit_modal.dart';

class LlavesPage extends StatefulWidget {
  const LlavesPage({super.key});

  @override
  LlavesPageController createState() => LlavesPageController();
}

class LlavesPageController extends State<LlavesPage> {
  final LlavesBloc _llavesBloc = LlavesBloc(
    getLlavesUseCase: sl<GetLlavesUseCase>(),
    createLlaveUseCase: sl<CreateLlaveUseCase>(),
  );
  double get _height => MediaQuery.of(context).size.height - 84; // appbar y padding
  late double _width;
  bool _isLandScape = false;

  late double _cardSideSize;
  int _itemsPerRow = 8;

  @override
  void initState() {
    super.initState();
    _getLlaves();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
      _width = MediaQuery.of(context).size.width;
      _setSizes();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    _width = MediaQuery.of(context).size.width;
    _setSizes();
  }

  @override
  Widget build(BuildContext context) => _LlavesPageView(this);

  void _setSizes() {
    if (_isLandScape) {
      _cardSideSize = _width * (1 / 5);
      _itemsPerRow = 8;
    } else {
      _cardSideSize = _width * (1 / 4);
      _itemsPerRow = 5;
    }
  }

  void _addLlave() async {
    bool reload = await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const LlaveAddModal();
          },
        ) ??
        false;
    if (reload) {
      _getLlaves();
    }
  }

  void _editLlave(LlavesModel llave) async {
    bool reload = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return LlaveEditModal(llave: llave);
      },
    );
    if (reload) {
      _getLlaves();
    }
  }

  //llama al evento GetAsociadosEvent
  void _getLlaves() {
    _llavesBloc.add(const GetLlavesEvent(loading: true));
  }
}

class _LlavesPageView extends StatelessWidget {
  final LlavesPageController controller;
  const _LlavesPageView(this.controller);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          context: context,
          title: 'LLAVES',
        ),
        body: RefreshIndicator(
          onRefresh: () {
            controller._getLlaves();
            return Future.value();
          },
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              return Container(
                decoration: const BoxDecoration(
                  color: StyleConst.kcolorBg,
                ),
                height: controller._height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton.icon(
                            onPressed: controller._addLlave,
                            label: const Text(
                              'AGREGAR',
                              style: TextStyle(
                                color: StyleConst.kcolorBlanco,
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            icon: const Icon(
                              Icons.key_outlined,
                              size: 30,
                              color: StyleConst.kcolorBlanco,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: StyleConst.kcolorVerde,
                              iconColor: StyleConst.kcolorBlanco,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<LlavesBloc, LlavesState>(
                        bloc: controller._llavesBloc,
                        builder: (context, state) {
                          if (state is LlavesLoading) {
                            return const Expanded(
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: StyleConst.kcolorCafeOscuro,
                                ),
                              ),
                            );
                          } else if (state is LlavesError) {
                            return Flexible(
                              child: Center(
                                child: Text(state.message),
                              ),
                            );
                          } else if (state is LlavesLoaded) {
                            if (state.llaves.isEmpty) {
                              return const Flexible(
                                child: Center(
                                  child: Text(
                                    'No hay llaves',
                                    style: TextStyle(
                                      color: StyleConst.kcolorCafeOscuro,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Flexible(
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: controller._itemsPerRow,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                ),
                                itemBuilder: (context, index) {
                                  if (index >= state.llaves.length) {
                                    return null;
                                  }
                                  final llave = state.llaves[index];

                                  return Card(
                                    color: llave.idAsociado == null
                                        ? StyleConst.kcolorCard
                                        : llave.estatus == 2
                                            ? StyleConst.kcolorDisponible
                                            : StyleConst.kcolorNoDisponible,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: SizedBox(
                                      height: controller._cardSideSize,
                                      width: controller._cardSideSize,
                                      child: InkWell(
                                        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                                        onTap: () {
                                          controller._editLlave(llave);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.key_rounded,
                                                size: 72,
                                                color: llave.idAsociado == null
                                                    ? StyleConst.kcolorCafe
                                                    : StyleConst.kcolorCarbon,
                                              ),
                                              Text(
                                                'LLAVE ${llave.numLlave}',
                                                style: TextStyle(
                                                  color: llave.idAsociado == null
                                                      ? StyleConst.kcolorCafe
                                                      : StyleConst.kcolorCarbon,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w900,
                                                  height: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                maxLines: 2,
                                                softWrap: true,
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 4),
                                              // activa y sin asignar
                                              if (llave.idAsociado == null)
                                                const Text(
                                                  'Sin asignar',
                                                  style: TextStyle(
                                                    color: StyleConst.kcolorCafe,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1,
                                                  ),
                                                ),
                                              // activa, asignada y disponible
                                              if (llave.idAsociado != null && llave.estatus == 2)
                                                const Text(
                                                  'Disponible',
                                                  style: TextStyle(
                                                    color: StyleConst.kcolorCarbon,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1,
                                                  ),
                                                ),
                                              // activa, asignada y no disponible
                                              if (llave.idAsociado != null && llave.estatus == 3)
                                                const Text(
                                                  'En préstamo',
                                                  style: TextStyle(
                                                    color: StyleConst.kcolorCarbon,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

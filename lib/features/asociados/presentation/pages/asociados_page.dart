import 'package:bitacora/features/asociados/domain/asociados_usecase.dart';
import 'package:bitacora/shared/presentation/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/style_const.dart';
import '../../../../core/utils/injections.dart';
import '../../domain/asociados_model.dart';
import '../bloc/asociados_bloc.dart';
import 'asociado_add_modal.dart';
import 'asociado_edit_modal.dart';

class AsociadosPage extends StatefulWidget {
  const AsociadosPage({super.key});

  @override
  AsociadosPageController createState() => AsociadosPageController();
}

class AsociadosPageController extends State<AsociadosPage> {
  final AsociadosBloc _asociadosBloc = AsociadosBloc(
    getAsociadosUseCase: sl<GetAsociadosUseCase>(),
    createAsociadoUseCase: sl<CreateAsociadoUseCase>(),
    // getAsociadoUseCase: sl<GetAsociadoUseCase>(),
  );
  double get _height => MediaQuery.of(context).size.height - 84; // appbar y padding
  late double _width;
  bool _isLandScape = false;

  late double _cardSideSize;
  int _itemsPerRow = 8;

  @override
  void initState() {
    super.initState();
    _getAsociados();
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
  Widget build(BuildContext context) => _AsociadosPageView(this);

  void _setSizes() {
    if (_isLandScape) {
      _cardSideSize = _width * (1 / 5);
      _itemsPerRow = 8;
    } else {
      _cardSideSize = _width * (1 / 4);
      _itemsPerRow = 5;
    }
  }

  void _addAsociado() async {
    bool reload = await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const AsociadoAddModal();
          },
        ) ??
        false;
    if (reload) {
      _getAsociados();
    }
  }

  void _editAsociado(AsociadosModel asociado) async {
    bool reload = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AsociadoEditModal(
          asociado: asociado,
        );
      },
    );
    if (reload) {
      _getAsociados();
    }
  }

  //llama al evento GetAsociadosEvent
  void _getAsociados() {
    _asociadosBloc.add(const GetAsociadosEvent(loading: true));
  }
}

class _AsociadosPageView extends StatelessWidget {
  final AsociadosPageController controller;
  const _AsociadosPageView(this.controller);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          context: context,
          title: 'ASOCIADOS',
        ),
        body: RefreshIndicator(
          onRefresh: () {
            controller._getAsociados();
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
                            onPressed: controller._addAsociado,
                            label: const Text(
                              'AGREGAR',
                              style: TextStyle(
                                color: StyleConst.kcolorBlanco,
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            icon: const Icon(
                              Icons.person_add_alt_1_rounded,
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

                      //Cards de Asociados
                      //uso de bloc para cargar los asociados
                      BlocBuilder<AsociadosBloc, AsociadosState>(
                        bloc: controller._asociadosBloc,
                        // listener escucha los eventos y realiza acciones si hay cambios

                        builder: (context, state) {
                          if (state is AsociadosLoading) {
                            return const Expanded(
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: StyleConst.kcolorCafeOscuro,
                                ),
                              ),
                            );
                          } else if (state is AsociadosError) {
                            return Flexible(
                              child: Center(
                                child: Text(state.message),
                              ),
                            );
                          } else if (state is AsociadosLoaded) {
                            if (state.asociados.isEmpty) {
                              return const Flexible(
                                child: Center(
                                  child: Text(
                                    'No hay asociados',
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
                                  if (index >= state.asociados.length) {
                                    return null;
                                  }
                                  final asociado = state.asociados[index];

                                  return Card(
                                    color: StyleConst.kcolorCard,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: SizedBox(
                                      height: controller._cardSideSize,
                                      width: controller._cardSideSize,
                                      child: InkWell(
                                        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                                        onTap: () {
                                          controller._editAsociado(asociado);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                Icons.people_alt_rounded,
                                                size: 72,
                                                color: StyleConst.kcolorCafe,
                                              ),
                                              Text(
                                                '${asociado.nombre} ${asociado.apellidoPaterno} ',
                                                style: const TextStyle(
                                                  color: StyleConst.kcolorCafe,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w900,
                                                  height: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                maxLines: 2,
                                                softWrap: true,
                                                textAlign: TextAlign.center,
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
                          }
                          return const SizedBox();
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

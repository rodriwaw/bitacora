import 'package:bitacora/features/bitacora/domain/bitacora_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitacora/features/bitacora/domain/bitacora_usecase.dart';
import 'package:bitacora/features/bitacora/presentation/bloc/bitacora_bloc.dart';
import 'package:bitacora/shared/presentation/appbar.dart';
import '../../../../core/style_const.dart';
import '../../../../core/utils/injections.dart';
import '../../../../shared/presentation/dialogs.dart';
import '../../../../shared/presentation/loading_overlay.dart';
import 'bitacora_entrada_modal.dart';
import 'bitacora_salida_modal.dart';

class BitacoraPage extends StatefulWidget {
  const BitacoraPage({super.key});

  @override
  BitacoraPageController createState() => BitacoraPageController();
}

class BitacoraPageController extends State<BitacoraPage> {
  double get _height =>
      MediaQuery.of(context).size.height - 84; // appbar y padding
  final BitacoraBloc _bitacoraBloc = BitacoraBloc(
    getBitacoraUseCase: sl<GetBitacoraUseCase>(),
    deleteBitacoraUseCase: sl<DeleteBitacoraUseCase>(),
    createBitacoraUseCase: sl<CreateBitacoraUseCase>(),
  );
  @override
  Widget build(BuildContext context) => _BitacoraPageView(this);

  @override
  void initState() {
    super.initState();
    _getBitacora();
  }

  void _salidaBitacora() async {
    bool reload = await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const BitacoraSalidaModal();
          },
        ) ??
        false;
    if (reload) {
      _getBitacora();
    }
  }

  void _entradaBitacora() async {
    bool reload = await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const BitacoraEntradaModal();
          },
        ) ??
        false;
    if (reload) {
      _getBitacora();
    }
  }

  void _getBitacora() {
    _bitacoraBloc.add(const GetBitacoraEvent(loading: true));
  }

  void _deleteBitacora(BitacoraModel bitacora) async {
    bool? proceed = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return ConfirmActionDialog(
            title: '¿Borrar registro?',
            content: 'Esta acción no se puede deshacer',
            colorProceed: StyleConst.kcolorRojo,
            onAccept: () {
              Navigator.of(context).pop(true);
            },
            onCancel: () {
              Navigator.of(context).pop(false);
            },
          );
        });
    if (proceed == null) return;
    if (proceed) {
      _bitacoraBloc.add(
        DeleteBitacoraEvent(
          bitacora,
          loading: true,
        ),
      );
    }
  }
}

class _BitacoraPageView extends StatelessWidget {
  final BitacoraPageController controller;

  const _BitacoraPageView(this.controller);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            appBar: MyAppBar(
              context: context,
              title: 'BITÁCORA',
            ),
            body: RefreshIndicator(
              onRefresh: () {
                controller._getBitacora();
                return Future.value();
              },
              child: ListView.builder(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton.icon(
                                onPressed: controller._salidaBitacora,
                                label: const Text(
                                  'SALIDA',
                                  style: TextStyle(
                                    color: StyleConst.kcolorBlanco,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.key_rounded,
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
                              const SizedBox(width: 20),
                              ElevatedButton.icon(
                                onPressed: controller._entradaBitacora,
                                label: const Text(
                                  'ENTRADA',
                                  style: TextStyle(
                                    color: StyleConst.kcolorBlanco,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.key_rounded,
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
                          const SizedBox(height: 22),
                          const Text(
                            'Últimos registros',
                            style: TextStyle(
                              color: StyleConst.kcolorCafeOscuro,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          BlocBuilder<BitacoraBloc, BitacoraState>(
                            bloc: controller._bitacoraBloc,
                            builder: (context, state) {
                              if (state is BitacoraLoading) {
                                return const Expanded(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: StyleConst.kcolorCafeOscuro,
                                    ),
                                  ),
                                );
                              } else if (state is BitacoraError) {
                                return Flexible(
                                  child: Center(
                                    child: Text(state.message),
                                  ),
                                );
                              } else if (state is BitacoraLoaded) {
                                if (state.bitacoras.isEmpty) {
                                  return const Flexible(
                                    child: Center(
                                      child: Text(
                                        'No hay registros',
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
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state.bitacoras.length,
                                    itemBuilder: (context, index) {
                                      final bitacora = state.bitacoras[index];
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          color: StyleConst.kcolorCard,
                                        ),
                                        child: ListTile(
                                          leading: bitacora.movimiento
                                                      .toLowerCase() ==
                                                  'salida'
                                              ? const Icon(
                                                  Icons.arrow_forward,
                                                  color: StyleConst
                                                      .kcolorCafeOscuro,
                                                )
                                              : const Icon(
                                                  Icons.arrow_back,
                                                  color: StyleConst
                                                      .kcolorCafeOscuro,
                                                ),
                                          textColor:
                                              StyleConst.kcolorCafeOscuro,
                                          title: RichText(
                                            text: TextSpan(
                                              text: '${bitacora.asociado} - ',
                                              style: const TextStyle(
                                                color:
                                                    StyleConst.kcolorCafeOscuro,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: DateFormat(
                                                          "dd 'de' MMMM 'de' yyyy hh:mm:ss a",
                                                          'es')
                                                      .format(DateTime.parse(
                                                          bitacora.fecha)),
                                                  style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: StyleConst
                                                        .kcolorCafeOscuro,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          subtitle: RichText(
                                            text: TextSpan(
                                              text: bitacora.movimiento,
                                              style: const TextStyle(
                                                color:
                                                    StyleConst.kcolorCafeOscuro,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      ' - Llave núm. ${bitacora.numLlave!}',
                                                  style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: StyleConst
                                                        .kcolorCafeOscuro,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          trailing: IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () {
                                              controller
                                                  ._deleteBitacora(bitacora);
                                            },
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
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          BlocConsumer(
            bloc: controller._bitacoraBloc,
            listener: (context, state) {
              if (state is BitacoraError) {
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: StyleConst.kcolorRojo,
                      ),
                    );
                  }
                });
              } else if (state is BitacoraDeleted) {
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.response.message),
                        backgroundColor: StyleConst.kcolorVerde,
                      ),
                    );
                  }
                  controller._getBitacora();
                });
              }
            },
            builder: (context, state) {
              if (state is BitacoraLoading) {
                return const LoadingOverlay();
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}

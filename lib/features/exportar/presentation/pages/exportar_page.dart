import 'package:bitacora/features/exportar/domain/exportar_usecase.dart';
import 'package:bitacora/features/exportar/presentation/bloc/exportar_bloc.dart';
import 'package:bitacora/shared/presentation/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/style_const.dart';
import '../../../../core/utils/injections.dart';
import '../../../../shared/presentation/dialogs.dart';
import '../../../../shared/presentation/loading_overlay.dart';

class ExportarPage extends StatefulWidget {
  const ExportarPage({super.key});

  @override
  ExportarPageState createState() => ExportarPageState();
}

class ExportarPageState extends State<ExportarPage> {
  final ExportarBloc bloc = ExportarBloc(
    exportarUseCase: sl<ExportarUseCase>(),
    exportarYBorrarUseCase: sl<ExportarYBorrarUseCase>(),
  );
  @override
  Widget build(BuildContext context) => _ExportarPageView(this);

  void exportarDatos() {
    bloc.add(const ExportarDataEvent(loading: true));
  }

  void exportarYBorrarDatos() async {
    bool proceed = await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => ConfirmActionDialog(
            title: 'Borrar y exportar',
            content:
                'Se borrarán definitivamente los datos siguientes:\n- Asociados desactivados\n- Llaves desactivadas\n- TODOS los registros de la bitácora\n- TODOS los registros de cambios de llaves\n\n¿Desea continuar?',
            onAccept: () {
              Navigator.of(context).pop(true);
            },
            onCancel: () {
              Navigator.of(context).pop(false);
            },
            colorProceed: StyleConst.kcolorAmarillo,
          ),
        ) ??
        false;
    if (!proceed) return;
    bloc.add(const ExportarDataYBorrarEvent(loading: true));
  }
}

class _ExportarPageView extends StatelessWidget {
  final ExportarPageState controller;

  const _ExportarPageView(this.controller);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            appBar: MyAppBar(
              context: context,
              title: 'EXPORTAR DATOS',
            ),
            body: DecoratedBox(
              decoration: const BoxDecoration(
                color: StyleConst.kcolorBg,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: controller.exportarDatos,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: StyleConst.kcolorAzul,
                          iconColor: StyleConst.kcolorBlanco,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        child: const Text(
                          'EXPORTAR DATOS',
                          style: TextStyle(
                            color: StyleConst.kcolorBlanco,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      ElevatedButton(
                        onPressed: controller.exportarYBorrarDatos,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: StyleConst.kcolorAmarillo,
                          iconColor: StyleConst.kcolorBlanco,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        child: const Text(
                          'EXPORTAR Y BORRAR DATOS',
                          style: TextStyle(
                            color: StyleConst.kcolorBlanco,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          BlocConsumer(
            bloc: controller.bloc,
            listener: (context, state) {
              if (state is ExportarError) {
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
              }
              if (state is ExportarSuccess) {
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: StyleConst.kcolorVerde,
                      ),
                    );
                  }
                });
              }
            },
            builder: (context, state) {
              if (state is ExportarLoading) {
                return const LoadingOverlay();
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

import 'package:bitacora/core/style_const.dart';
import 'package:bitacora/features/asociados/domain/asociados_usecase.dart';
import 'package:bitacora/features/bitacora/domain/bitacora_model.dart';
import 'package:bitacora/shared/presentation/ifta_label_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/injections.dart';
import '../../../../core/utils/validators.dart';
import '../../../asociados/presentation/bloc/asociados_bloc.dart';
import '../../domain/bitacora_usecase.dart';
import '../bloc/bitacora_bloc.dart';

class BitacoraEntradaModal extends StatefulWidget {
  const BitacoraEntradaModal({super.key});
  @override
  BitacoraEntradaModalController createState() => BitacoraEntradaModalController();
}

class BitacoraEntradaModalController extends State<BitacoraEntradaModal> {
  final TextEditingController _numAsociadoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final BitacoraBloc _bitacoraBloc = BitacoraBloc(createBitacoraUseCase: sl<CreateBitacoraUseCase>());
  final AsociadosBloc _asociadosBloc = AsociadosBloc(getAsociadoByNumUseCase: sl<GetAsociadoByNumUseCase>());
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => _BitacoraEntradaModalView(this, constraints),
      );

  @override
  void initState() {
    super.initState();
  }

  void _closeDialog({bool? refresh = false}) {
    Navigator.of(context).pop(refresh);
  }

  void _guardar() {
    if (_formKey.currentState!.validate()) {
      _asociadosBloc.add(GetAsociadoByNumEvent(_numAsociadoController.text));
      _asociadosBloc.stream.listen((event) {
        if (event is AsociadoConLlaveLoaded) {
          _bitacoraBloc.add(
            AddBitacoraEvent(
              BitacoraModel(
                fecha: DateTime.now().toString(),
                movimiento: 'ENTRADA',
                idAsociado: event.asociado.id,
                idLlave: event.asociado.idLlave!,
                estatus: 1,
              ),
            ),
          );
        }
        if (event is AsociadosError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(event.message),
              backgroundColor: StyleConst.kcolorRojo,
            ),
          );
          //close stream
        }
      });
    }
  }
}

class _BitacoraEntradaModalView extends StatelessWidget {
  final BitacoraEntradaModalController controller;
  final BoxConstraints constraints;
  const _BitacoraEntradaModalView(this.controller, this.constraints);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          insetPadding: const EdgeInsets.all(12),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'BITÁCORA - ENTRADA DE LLAVE',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                    IconButton(
                      onPressed: controller._closeDialog,
                      icon: const Icon(Icons.close),
                      iconSize: 24,
                    )
                  ],
                ),
                const SizedBox(height: 18),
                //body
                Form(
                  key: controller._formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IftaLabelInput(
                                    label: 'Número de Asociado',
                                    controller: controller._numAsociadoController,
                                    validators: Validators.required,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 36,
                      child: FilledButton.tonal(
                        onPressed: controller._closeDialog,
                        child: const Text(
                          'Cerrar',
                          style: TextStyle(color: StyleConst.kcolorAzul),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 36,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: StyleConst.kcolorVerde,
                        ),
                        onPressed: controller._guardar,
                        child: const Text('Guardar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        BlocBuilder(
          bloc: controller._bitacoraBloc,
          builder: (context, state) {
            if (state is BitacoraError) {
              Future.delayed(
                const Duration(milliseconds: 500),
                () {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: StyleConst.kcolorRojo,
                      ),
                    );
                  }
                },
              );
            }
            if (state is BitacoraCreated) {
              Future.delayed(
                const Duration(milliseconds: 500),
                () {
                  controller._closeDialog(refresh: true);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.response.message),
                        backgroundColor: StyleConst.kcolorVerde,
                      ),
                    );
                  }
                },
              );
            }
            if (state is BitacoraLoading) {
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}

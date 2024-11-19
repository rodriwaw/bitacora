import 'package:bitacora/core/style_const.dart';
import 'package:bitacora/features/asociados/domain/asociados_usecase.dart';
import 'package:bitacora/features/bitacora/domain/bitacora_model.dart';
import 'package:bitacora/shared/presentation/ifta_label_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/injections.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/presentation/ifta_label_dropdown.dart';
import '../../../asociados/presentation/bloc/asociados_bloc.dart';
import '../../domain/bitacora_usecase.dart';
import '../bloc/bitacora_bloc.dart';

class BitacoraSalidaModal extends StatefulWidget {
  const BitacoraSalidaModal({super.key});
  @override
  BitacoraSalidaModalController createState() => BitacoraSalidaModalController();
}

class BitacoraSalidaModalController extends State<BitacoraSalidaModal> {
  final TextEditingController _llaveController = TextEditingController();
  final TextEditingController _departamentoController = TextEditingController();
  final TextEditingController _numAsociadoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final BitacoraBloc _bitacoraBloc = BitacoraBloc(createBitacoraUseCase: sl<CreateBitacoraUseCase>());
  final AsociadosBloc _asociadosBloc = AsociadosBloc(getAsociadosConLlaveDispUseCase: sl<GetAsociadosConLlaveDispUseCase>());

  String? _numAsociadoSelected;
  int? _idAsociadoSelected;
  int? _idLlaveSelected;
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => _BitacoraSalidaModalView(this, constraints),
      );

  @override
  void initState() {
    super.initState();
    _asociadosBloc.add(const GetAsociadosConLlaveDispEvent(loading: true));
  }

  void _closeDialog({bool? refresh = false}) {
    Navigator.of(context).pop(refresh);
  }

  void _guardar() {
    if (_formKey.currentState!.validate()) {
      if (_numAsociadoSelected != _numAsociadoController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('El número de asociado no coincide con el asociado seleccionado'),
            backgroundColor: StyleConst.kcolorRojo,
          ),
        );
        return;
      }
      _bitacoraBloc.add(
        AddBitacoraEvent(
          BitacoraModel(
            fecha: DateTime.now().toString(),
            movimiento: 'SALIDA',
            idAsociado: _idAsociadoSelected!,
            idLlave: _idLlaveSelected!,
            estatus: 1,
          ),
        ),
      );
    }
  }
}

class _BitacoraSalidaModalView extends StatelessWidget {
  final BitacoraSalidaModalController controller;
  final BoxConstraints constraints;
  const _BitacoraSalidaModalView(this.controller, this.constraints);

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
                      'BITÁCORA - SALIDA DE LLAVE',
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
                                  BlocConsumer(
                                    bloc: controller._asociadosBloc,
                                    builder: (context, AsociadosState state) {
                                      if (state is AsociadosConLlaveLoaded) {
                                        return IftaLabelDropdownButton(
                                          label: 'Asociado',
                                          items: state.asociados,
                                          onChanged: (value) {
                                            if (value == null) {
                                              controller._llaveController.text = '';
                                              controller._departamentoController.text = '';
                                              controller._numAsociadoSelected = null;
                                              controller._idAsociadoSelected = null;
                                              controller._idLlaveSelected = null;
                                              return;
                                            }
                                            controller._llaveController.text =
                                                state.asociados.firstWhere((element) => element.id == value).numLlave ??
                                                    '';
                                            controller._departamentoController.text = state.asociados
                                                    .firstWhere((element) => element.id == value)
                                                    .departamento ??
                                                '';

                                            controller._numAsociadoSelected = state.asociados
                                                .firstWhere((element) => element.id == value)
                                                .numAsociado;
                                            controller._idAsociadoSelected = value;
                                            controller._idLlaveSelected =
                                                state.asociados.firstWhere((element) => element.id == value).idLlave;
                                          },
                                          validator: Validators.requiredDropdown,
                                        );
                                      }
                                      if (state is AsociadosError) {
                                        return Text(state.message);
                                      }
                                      return const SizedBox();
                                    },
                                    listener: (context, state) {
                                      if (state is AsociadosError) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(state.message),
                                          ),
                                        );
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IftaLabelInput(
                                    label: 'Número de Llave',
                                    controller: controller._llaveController,
                                    readOnly: true,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IftaLabelInput(
                                    label: 'Departamento',
                                    readOnly: true,
                                    controller: controller._departamentoController,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IftaLabelInput(
                                    label: 'Ingresa tu número de asociado para confirmar el registro',
                                    controller: controller._numAsociadoController,
                                    validators: Validators.required,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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

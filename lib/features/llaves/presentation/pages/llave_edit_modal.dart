import 'package:bitacora/core/style_const.dart';
import 'package:bitacora/features/asociados/domain/asociados_model.dart';
import 'package:bitacora/features/asociados/presentation/bloc/asociados_bloc.dart';
import 'package:bitacora/shared/presentation/ifta_label_dropdown.dart';
import 'package:bitacora/shared/presentation/ifta_label_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/injections.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/presentation/confirm_alert.dart';
import '../../../asociados/domain/asociados_usecase.dart';
import '../../domain/llaves_model.dart';
import '../../domain/llaves_usecase.dart';
import '../bloc/llaves_bloc.dart';

class LlaveEditModal extends StatefulWidget {
  const LlaveEditModal({required this.llave, super.key});

  final LlavesModel llave;
  @override
  LlaveEditModalController createState() => LlaveEditModalController();
}

class LlaveEditModalController extends State<LlaveEditModal> {
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _numeroLlaveController = TextEditingController();
  final TextEditingController _asociadoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final LlavesBloc _llavesBloc = LlavesBloc(
    updateLlaveUseCase: sl<UpdateLlaveUseCase>(),
    deleteLlaveUseCase: sl<DeleteLlaveUseCase>(),
  );

  final AsociadosBloc _asociadosBloc = AsociadosBloc(
    getAsociadosUseCase: sl<GetAsociadosUseCase>(),
  );

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => _LlaveEditModalView(this, constraints),
      );

  @override
  void initState() {
    super.initState();
    _numeroLlaveController.text = widget.llave.numLlave;
    _descripcionController.text = widget.llave.descripcion;
    _asociadoController.text = widget.llave.idAsociado.toString();
    _asociadosBloc.add(const GetAsociadosEvent(loading: true));
  }

  void _closeDialog({bool? refresh = false}) {
    Navigator.of(context).pop(refresh);
  }

  void _guardar() {
    if (_formKey.currentState!.validate()) {
      _llavesBloc.add(
        UpdateLlaveEvent(
          LlavesModel(
            id: widget.llave.id,
            numLlave: _numeroLlaveController.text,
            descripcion: _descripcionController.text,
            // 1 = sin asignar, 2 = asignada y disponible
            // si el campo de asociado es un número, entonces está asignada
            estatus: int.tryParse(_asociadoController.text) != null ? 2 : 1,
            fechaAlta: widget.llave.fechaAlta,
            idAsociado: int.tryParse(_asociadoController.text),
          ),
        ),
      );
    }
  }

  void _eliminar() async {
    //modal para confirmar
    bool proceed = await showDialog<bool>(
          context: context,
          builder: (context) => ConfirmAlert(
            title: 'Eliminar Llave',
            content: '¿Estás seguro de eliminar esta llave?',
            onConfirm: () {
              Navigator.of(context).pop(true);
            },
            onCancel: () {
              Navigator.of(context).pop(false);
            },
            confirmText: 'Eliminar',
            confirmBgColor: StyleConst.kcolorRojo,
          ),
        ) ??
        false;
    if (!proceed) return;
    _llavesBloc.add(DeleteLlaveEvent(widget.llave));
  }
}

class _LlaveEditModalView extends StatelessWidget {
  final LlaveEditModalController controller;
  final BoxConstraints constraints;
  const _LlaveEditModalView(this.controller, this.constraints);

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
                      'ACTUALIZAR LLAVE',
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
                                    label: 'Número de Llave',
                                    controller: controller._numeroLlaveController,
                                    validators: Validators.required,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                                    label: 'Descripción de la Llave',
                                    controller: controller._descripcionController,
                                    validators: Validators.required,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  BlocConsumer(
                                    bloc: controller._asociadosBloc,
                                    builder: (context, state) {
                                      if (state is AsociadosLoaded) {
                                        List<AsociadosConLlaveModel> asociados = state.asociados
                                            .map(
                                              (e) => AsociadosConLlaveModel(
                                                id: e.id!,
                                                nombre: '${e.nombre} ${e.apellidoPaterno} ${e.apellidoMaterno}',
                                              ),
                                            )
                                            .toList();

                                        return IftaLabelDropdownButton(
                                          label: 'Asignada a',
                                          items: asociados,
                                          selected: int.tryParse(controller._asociadoController.text),
                                          onChanged: (value) {
                                            controller._asociadoController.text = value.toString();
                                          },
                                        );
                                      }
                                      if (state is AsociadosError) {
                                        return Text(state.message);
                                      }
                                      return const CircularProgressIndicator();
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 36,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: StyleConst.kcolorRojo,
                        ),
                        onPressed: controller._eliminar,
                        child: const Text('Eliminar'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Wrap(
                      spacing: 12,
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
                        SizedBox(
                          height: 36,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: StyleConst.kcolorAzul,
                            ),
                            onPressed: controller._guardar,
                            child: const Text('Actualizar'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        BlocConsumer(
          bloc: controller._llavesBloc,
          builder: (context, state) {
            return const SizedBox();
          },
          listener: (context, state) {
            if (state is LlavesError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: StyleConst.kcolorRojo,
                ),
              );
            }
            if (state is LlavesUpdated) {
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
            if (state is LlavesDeleted) {
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
            if (state is LlavesLoading) {
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

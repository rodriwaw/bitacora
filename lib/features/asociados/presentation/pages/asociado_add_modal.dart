import 'package:bitacora/core/style_const.dart';
import 'package:bitacora/features/asociados/domain/asociados_model.dart';
import 'package:bitacora/features/departamentos/domain/departamentos_usecase.dart';
import 'package:bitacora/shared/presentation/ifta_label_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/injections.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/presentation/ifta_label_dropdown.dart';
import '../../../../shared/presentation/loading_overlay.dart';
import '../../../departamentos/presentation/bloc/departamentos_bloc.dart';
import '../../domain/asociados_usecase.dart';
import '../bloc/asociados_bloc.dart';

class AsociadoAddModal extends StatefulWidget {
  const AsociadoAddModal({super.key});
  @override
  AsociadoAddModalController createState() => AsociadoAddModalController();
}

class AsociadoAddModalController extends State<AsociadoAddModal> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _departamentoController = TextEditingController();
  final TextEditingController _numeroAsociadoController =
      TextEditingController();
  final TextEditingController _apellidoPaternoController =
      TextEditingController();
  final TextEditingController _apellidoMaternoController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final AsociadosBloc _asociadosBloc =
      AsociadosBloc(createAsociadoUseCase: sl<CreateAsociadoUseCase>());
  final DepartamentosBloc _departamentosBloc =
      DepartamentosBloc(getDepartamentosUseCase: sl<GetDepartamentosUseCase>());
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) =>
            _AsociadoAddModalView(this, constraints),
      );

  @override
  void initState() {
    super.initState();
    _departamentosBloc.add(const GetDepartamentosEvent(loading: true));
  }

  void _closeDialog({bool? refresh = false}) {
    Navigator.of(context).pop(refresh);
  }

  void _guardar() {
    if (_formKey.currentState!.validate()) {
      _asociadosBloc.add(
        AddAsociadoEvent(
          AsociadosModel(
            numeroAsociado: _numeroAsociadoController.text,
            nombre: _nombreController.text,
            apellidoPaterno: _apellidoPaternoController.text,
            apellidoMaterno: _apellidoMaternoController.text,
            departamento: int.parse(_departamentoController.text),
            estatus: 1,
            fechaAlta: DateTime.now().toString(),
          ),
        ),
      );
    }
  }
}

class _AsociadoAddModalView extends StatelessWidget {
  final AsociadoAddModalController controller;
  final BoxConstraints constraints;
  const _AsociadoAddModalView(this.controller, this.constraints);

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
                      'DAR DE ALTA ASOCIADO',
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
                                    label: 'Nombre',
                                    controller: controller._nombreController,
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
                                  IftaLabelInput(
                                    label: 'Apellido Paterno',
                                    controller:
                                        controller._apellidoPaternoController,
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
                                  IftaLabelInput(
                                    label: 'Apellido Materno',
                                    controller:
                                        controller._apellidoMaternoController,
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
                                    label: 'Número de Asociado',
                                    controller:
                                        controller._numeroAsociadoController,
                                    validators: Validators.required,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
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
                                    bloc: controller._departamentosBloc,
                                    builder: (context, state) {
                                      if (state is DepartamentosLoaded) {
                                        return IftaLabelDropdownButton(
                                          label: 'Departamento',
                                          items: state.departamentos,
                                          onChanged: (value) {
                                            controller._departamentoController
                                                .text = value.toString();
                                          },
                                          validator:
                                              Validators.requiredDropdown,
                                        );
                                      }
                                      if (state is DepartamentosError) {
                                        return Text(state.message);
                                      }
                                      return const CircularProgressIndicator();
                                    },
                                    listener: (context, state) {
                                      if (state is DepartamentosError) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
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
                            /*   const SizedBox(width: 12),
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IftaLabelInput(
                                    label: 'Alias',
                                    controller: controller._aliasController,
                                  ),
                                ],
                              ),
                            ), */
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
        BlocConsumer(
          bloc: controller._asociadosBloc,
          listener: (context, state) {
            if (state is AsociadosError) {
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
            } else if (state is AsociadosCreated) {
              Future.delayed(const Duration(milliseconds: 500), () {
                controller._closeDialog(refresh: true);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.response.message),
                      backgroundColor: StyleConst.kcolorVerde,
                    ),
                  );
                }
              });
            }
          },
          builder: (context, state) {
            if (state is AsociadosLoading) {
              return const LoadingOverlay();
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}

import 'package:bitacora/shared/presentation/ifta_label_input.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/validators.dart';

class AsociadoModalPage extends StatefulWidget {
  @override
  _AsociadoModalPageController createState() => _AsociadoModalPageController();
}

class _AsociadoModalPageController extends State<AsociadoModalPage> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _departamentoController = TextEditingController();
  final TextEditingController _numeroAsociadoController = TextEditingController();
  final TextEditingController _apellidoPaternoController = TextEditingController();
  final TextEditingController _apellidoMaternoController = TextEditingController();
  final TextEditingController _aliasController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => _AsociadoModalPageView(this, constraints),
      );

  void _closeDialog() {
    Navigator.of(context).pop();
  }

  void _guardar() {
    if (_formKey.currentState!.validate()) {}
  }
}

class _AsociadoModalPageView extends StatelessWidget {
  final _AsociadoModalPageController controller;
  final BoxConstraints constraints;
  const _AsociadoModalPageView(this.controller, this.constraints);

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                                controller: controller._apellidoPaternoController,
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
                                controller: controller._apellidoMaternoController,
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
                                controller: controller._numeroAsociadoController,
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
                                label: 'Departamento',
                                controller: controller._departamentoController,
                                validators: Validators.required,
                              ),
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
                  child: TextButton(
                    onPressed: controller._closeDialog,
                    child: const Text('CANCELAR'),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 36,
                  child: FilledButton(
                    onPressed: controller._guardar,
                    child: const Text('Guardar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/style_const.dart';
import '../../../../core/utils/injections.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/presentation/ifta_label_input.dart';
import '../../domain/llaves_model.dart';
import '../../domain/llaves_usecase.dart';
import '../bloc/llaves_bloc.dart';

class LlaveAddModal extends StatefulWidget {
  const LlaveAddModal({super.key});
  @override
  LlaveAddModalController createState() => LlaveAddModalController();
}

class LlaveAddModalController extends State<LlaveAddModal> {
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _numeroLlaveController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final LlavesBloc _llavesBloc = LlavesBloc(createLlaveUseCase: sl<CreateLlaveUseCase>());
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => _LlaveAddModalView(this, constraints),
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
      _llavesBloc.add(
        AddLlaveEvent(
          LlavesModel(
            numLlave: _numeroLlaveController.text,
            descripcion: _descripcionController.text,
            estatus: 1,
            fechaAlta: DateTime.now().toString(),
          ),
        ),
      );
    }
  }
}

class _LlaveAddModalView extends StatelessWidget {
  final LlaveAddModalController controller;
  final BoxConstraints constraints;
  const _LlaveAddModalView(this.controller, this.constraints);

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
                      'DAR DE ALTA LLAVE',
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
            if (state is LlavesCreated) {
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

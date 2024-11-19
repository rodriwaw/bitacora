import 'package:flutter/material.dart';

import '../../core/style_const.dart';

class ConfirmAlert extends StatelessWidget {
  final String title;
  final String content;
  final Function onConfirm;
  final Function onCancel;
  final String confirmText;
  final Color confirmBgColor;

  const ConfirmAlert({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.onCancel,
    this.confirmText = 'Aceptar',
    this.confirmBgColor = StyleConst.kcolorAzul,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        FilledButton.tonal(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text(
            'Cancelar',
            style: TextStyle(color: StyleConst.kcolorAzul),
          ),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: confirmBgColor,
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(confirmText),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../core/style_const.dart';

class ConfirmActionDialog extends StatelessWidget {
  ConfirmActionDialog({
    required this.title,
    required this.content,
    required this.onAccept,
    required this.onCancel,
    this.colorProceed = Colors.green,
  });

  final String title;
  final String content;
  final Function onAccept;
  final Function onCancel;
  final Color colorProceed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      insetPadding: const EdgeInsets.all(12),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 10),
            //body
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 36,
                      child: FilledButton.tonal(
                        onPressed: () {
                          onCancel();
                        },
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(color: StyleConst.kcolorAzul),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 36,
                      child: FilledButton.tonal(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(colorProceed),
                        ),
                        onPressed: () {
                          onAccept();
                        },
                        child: const Text(
                          'Aceptar',
                          style: TextStyle(color: StyleConst.kcolorBlanco),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

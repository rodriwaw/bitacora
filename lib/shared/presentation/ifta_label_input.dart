import 'package:flutter/material.dart';

class IftaLabelInput extends StatelessWidget {
  const IftaLabelInput({
    super.key,
    required this.label,
    required this.controller,
    this.validators,
  });
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validators;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          TextFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
            ),
            controller: controller,
            validator: validators,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ],
      ),
    );
  }
}

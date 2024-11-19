import 'package:flutter/material.dart';

class IftaLabelDropdownButton extends StatelessWidget {
  const IftaLabelDropdownButton({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.selected,
    this.validator,
  });
  final String label;
  final List<dynamic> items;
  final Function(dynamic) onChanged;
  final dynamic selected;
  final String? Function(dynamic)? validator;
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
          DropdownButtonFormField(
            isExpanded: true,
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
            ),
           
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            onChanged: onChanged,
            value: selected,
            items: [
              const DropdownMenuItem(
                value: null,
                child: Text('Sin asignar'),
              ),
              for (var item in items)
                DropdownMenuItem(
                  value: item.id,
                  child: Text(item.nombre),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ConversorTextFiel extends StatelessWidget {
  const ConversorTextFiel({
    Key? key,
    required this.controller,
    required this.label,
    required this.prefix,
    required this.onChanged,
    required this.onTap,
  }) : super(key: key);
  final TextEditingController controller;
  final String label;
  final String prefix;
  final Function(String) onChanged;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.amber),
        border: const OutlineInputBorder(),
        prefixText: prefix,
      ),
      style: const TextStyle(color: Colors.amber, fontSize: 25.0),
      onChanged: onChanged,
      onTap: onTap,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }
}

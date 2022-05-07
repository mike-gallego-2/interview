import 'package:flutter/material.dart';

class BookTextField extends StatelessWidget {
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String label;
  final String hint;
  const BookTextField({Key? key, required this.label, required this.hint, this.onChanged, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          focusColor: Colors.blue,
          labelStyle: const TextStyle(fontSize: 12),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
        onChanged: onChanged,
      ),
    );
  }
}

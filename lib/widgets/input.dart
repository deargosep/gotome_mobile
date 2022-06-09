import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  Input({Key? key, String? this.label, TextEditingController? this.controller})
      : super(key: key);

  String? label;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: label ?? '',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFF6A7592)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Color(0xFFF8F8F8)),
    );
  }
}

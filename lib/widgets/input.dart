import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  Input(
      {Key? key,
      String? this.label,
      TextEditingController? this.controller,
      ValueChanged<String>? this.onChanged,
      bool? this.expanded})
      : super(key: key);

  String? label;
  TextEditingController? controller;
  ValueChanged<String>? onChanged;
  bool? expanded = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: expanded == true ? 3 : 1,
      maxLines: expanded == true ? 3 : 1,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
          alignLabelWithHint: true,
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

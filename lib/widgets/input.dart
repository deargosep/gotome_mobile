import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  Input({Key? key, this.label}) : super(key: key);
  var label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          labelText: label ?? '',
          labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
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

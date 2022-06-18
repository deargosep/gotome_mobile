import 'package:flutter/material.dart';
import 'package:gotome/widgets/images/brand_icon.dart';

class Input extends StatelessWidget {
  Input(
      {Key? key,
      String? this.label,
      this.defaultText = '',
      TextEditingController? this.controller,
      ValueChanged<String>? this.onChanged,
      bool? this.expanded,
      String? this.icon,
      this.borderRadius,
      this.width,
      this.height})
      : super(key: key);

  String? label;
  String? defaultText;
  TextEditingController? controller;
  ValueChanged<String>? onChanged;
  bool? expanded = false;
  String? icon;
  final borderRadius;
  final width;
  final height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        minLines: expanded == true ? 3 : 1,
        maxLines: expanded == true ? 3 : 1,
        controller: controller,
        onChanged: onChanged,
        initialValue: defaultText,
        decoration: InputDecoration(
            contentPadding: height != null
                ? EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0)
                : null,
            suffixIcon: icon != null
                ? Transform.scale(scale: 0.45, child: BrandIcon(icon: icon))
                : null,
            alignLabelWithHint: true,
            labelText: label ?? '',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(0xFF6A7592)),
            border: OutlineInputBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            fillColor: Color(0xFFF8F8F8)),
      ),
    );
  }
}

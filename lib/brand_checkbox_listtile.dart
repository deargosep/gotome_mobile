import 'package:flutter/material.dart';
import 'package:gotome/widgets/brand_checkbox.dart';

class BrandCheckboxListTile extends StatelessWidget {
  const BrandCheckboxListTile(
      {Key? key,
      required this.value,
      required this.title,
      required this.onChanged})
      : super(key: key);
  final value;
  final title;
  final onChanged;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Row(
        children: [
          BrandCheckbox(
            checked: value,
            onChanged: () {
              onChanged();
            },
          ),
          SizedBox(
            width: 13,
          ),
          Text(
            title,
            style: TextStyle(
                color: Color(0xFF6A7592), fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

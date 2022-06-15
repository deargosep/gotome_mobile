import 'package:flutter/material.dart';

import 'images/brand_icon.dart';

class Header extends StatelessWidget {
  Header({Key? key, this.text, this.withPadding = true}) : super(key: key);
  final text;
  bool withPadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          withPadding ? EdgeInsets.fromLTRB(20, 0, 20, 0) : EdgeInsets.all(0),
      child: Row(
        children: [
          BrandIcon(
            icon: 'back_arrow',
          ),
          SizedBox(
            width: 26,
          ),
          Text(
            text ?? '',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          )
        ],
      ),
    );
  }
}
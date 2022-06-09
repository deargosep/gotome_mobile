import 'package:flutter/material.dart';

class BrandButton extends StatelessWidget {
  final String text;
  final String type;
  var onPressed;

  BrandButton(
      {Key? key,
      required String this.text,
      required String this.type,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getColor() {
      switch (type) {
        case 'primary':
          return Theme.of(context).primaryColor;
        case 'secondary':
          return Theme.of(context).accentColor;
        default:
          return Theme.of(context).primaryColor;
      }
    }

    return Material(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: getColor(),
      child: InkWell(
          onTap: onPressed,
          child: Container(
            width: double.infinity,
            height: 50,
            child: Center(
                child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            )),
          )),
    );
  }
}

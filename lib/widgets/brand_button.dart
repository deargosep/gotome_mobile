import 'package:flutter/material.dart';

class BrandButton extends StatefulWidget {
  final String text;
  final String type;
  bool? disabled = false;
  var onPressed;

  BrandButton({
    Key? key,
    required String this.text,
    required String this.type,
    this.onPressed,
    bool? this.disabled,
  }) : super(key: key);

  @override
  State<BrandButton> createState() => _BrandButtonState();
}

class _BrandButtonState extends State<BrandButton> {
  bool pressing = false;
  @override
  Widget build(BuildContext context) {
    Color getColor() {
      switch (widget.type) {
        case 'primary':
          if (pressing) return Color(0xFF2D34CB);
          return Theme.of(context).primaryColor;
        case 'secondary':
          if (pressing) return Color(0xFF172548);
          return Theme.of(context).accentColor;
        default:
          return Theme.of(context).primaryColor;
      }
    }

    return GestureDetector(
      onTapUp: (details) {
        setState(() {
          pressing = false;
        });
      },
      onTapDown: (details) {
        setState(() {
          pressing = true;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: getColor(),
        ),
        width: double.infinity,
        height: 50,
        child: Center(
            child: Text(
          widget.text,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        )),
      ),
    );
  }
}

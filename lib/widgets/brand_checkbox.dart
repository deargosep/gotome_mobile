import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrandCheckbox extends StatefulWidget {
  BrandCheckbox(
      {Key? key,
      bool? this.valid,
      VoidCallback? this.setState,
      required bool this.checked})
      : super(key: key);

  bool? valid;
  VoidCallback? setState;
  bool checked;

  @override
  State<BrandCheckbox> createState() => _BrandCheckboxState();
}

class _BrandCheckboxState extends State<BrandCheckbox>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 600), vsync: this)
    ..repeat(reverse: false);
  bool pressing = false;
  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  Tween<double> _tween = Tween(begin: 1, end: 0.7);

  @override
  initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color getColor() {
      switch (widget.valid) {
        case false:
          return Color(0xFFEE3838);
        default:
          return Color(0xFF3840EE);
      }
    }

    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          pressing = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          pressing = false;
        });
      },
      onTap: () {
        widget.setState!();
      },
      child: Container(
          height: 22,
          width: 22,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: getColor(), width: 1.5)),
          child: Builder(builder: (context) {
            if (widget.checked == false) {
              if (pressing) {
                return ScaleTransition(
                    scale: _tween.animate(_animation),
                    child: Container(
                      margin: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                        color: getColor(),
                      ),
                    ));
              } else {
                return Container(
                  margin: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    color: getColor(),
                  ),
                );
              }
            }
            if (widget.checked == true) {
              if (pressing) {
                return ScaleTransition(
                  scale: _tween.animate(_animation),
                  child: SvgPicture.asset(
                    'assets/icons/check.svg',
                    color: getColor(),
                    fit: BoxFit.scaleDown,
                  ),
                );
              } else {
                return SvgPicture.asset(
                  'assets/icons/check.svg',
                  color: getColor(),
                  fit: BoxFit.scaleDown,
                );
              }
            }
            return Container();
            return SvgPicture.asset(
              'assets/icons/check.svg',
              color: getColor(),
              fit: BoxFit.scaleDown,
            );
          })),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrandIcon extends StatelessWidget {
  const BrandIcon({Key? key, required this.icon}) : super(key: key);
  final icon;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/icons/${icon}.svg');
  }
}

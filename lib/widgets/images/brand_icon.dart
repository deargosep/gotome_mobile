import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BrandIcon extends StatelessWidget {
  const BrandIcon({Key? key, required this.icon}) : super(key: key);
  final icon;
  @override
  Widget build(BuildContext context) {
    if (icon == 'back_arrow')
      return InkWell(
        onTap: () {
          Get.back();
        },
        child: SvgPicture.asset('assets/icons/${icon}.svg'),
      );
    return SvgPicture.asset('assets/icons/${icon}.svg');
  }
}

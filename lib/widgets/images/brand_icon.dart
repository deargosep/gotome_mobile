import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BrandIcon extends StatelessWidget {
  BrandIcon(
      {Key? key,
      required this.icon,
      Color? this.color,
      this.width,
      this.height,
      this.fit,
      this.onTapCalendar,
      this.onTap})
      : super(key: key);
  final icon;
  Color? color;
  double? width;
  double? height;
  final fit;
  final onTapCalendar;
  final onTap;
  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    if (icon == 'calendar')
      return InkWell(
        onTap: () async {
          if (onTap != null) onTap();
          final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(1950, 1),
              lastDate: DateTime(2045));
          if (picked != null && picked != selectedDate) {
            onTapCalendar("${picked.day}.${picked.month}.${picked.year}");
          }
        },
        child: SvgPicture.asset(
          'assets/icons/${icon}.svg',
          fit: fit ?? BoxFit.contain,
          color: color,
          height: height,
          width: width,
        ),
      );
    if (icon == 'back_arrow')
      return InkWell(
        onTap: () {
          if (onTap != null) onTap();
          Get.back();
        },
        child: SvgPicture.asset(
          'assets/icons/${icon}.svg',
          fit: fit ?? BoxFit.contain,
          color: color,
          height: height,
          width: width,
        ),
      );
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        'assets/icons/${icon}.svg',
        color: color,
        height: height,
        width: width,
      ),
    );
  }
}

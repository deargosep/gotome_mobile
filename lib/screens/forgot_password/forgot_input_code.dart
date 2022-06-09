import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/brand_button.dart';
import 'package:gotome/widgets/images/brand_icon.dart';
import 'package:gotome/widgets/images/logo.dart';
import 'package:gotome/widgets/input.dart';
import 'package:timer_builder/timer_builder.dart';

class InputCodeScreen extends StatelessWidget {
  InputCodeScreen({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        child: Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: BrandIcon(icon: 'back_arrow')),
        SizedBox(
          height: 7,
        ),
        Logo(),
        Spacer(),
        Text(
          'Введите код из отправленного письма',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        SizedBox(
          height: 24,
        ),
        Input(
          controller: controller,
          label: 'Код',
        ),
        SizedBox(
          height: 24,
        ),
        Timer(),
        Spacer(),
        BrandButton(
            onPressed: () {
              Get.toNamed('/auth/forgot/3');
            },
            text: 'Продолжить',
            type: 'primary',
            disabled: controller.text.length < 6),
      ],
    ));
  }
}

class Timer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int seconds = 61;
    void requestCode() {
      seconds = 61;
    }

    return TimerBuilder.periodic(Duration(seconds: 1), //updates every second
        builder: (context) {
      if (seconds > 0) {
        seconds--;
      }
      if (seconds == 0)
        return InkWell(
          onTap: requestCode,
          child: Text(
            'Запросить код повторно',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        );
      return Text(
        'Запросить код повторно через ${seconds} сек.',
        style: TextStyle(fontWeight: FontWeight.w500),
      );
    });
  }
}

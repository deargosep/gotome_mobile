import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/brand_button.dart';
import 'package:gotome/widgets/images/brand_icon.dart';
import 'package:gotome/widgets/images/logo.dart';
import 'package:gotome/widgets/input.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class InputCodeScreen extends StatefulWidget {
  InputCodeScreen({Key? key}) : super(key: key);

  @override
  State<InputCodeScreen> createState() => _InputCodeScreenState();
}

class _InputCodeScreenState extends State<InputCodeScreen> {
  TextEditingController controller = TextEditingController();
  String text = '';
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Column(
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
          onChanged: (value) {
            setState(() {
              text = value;
            });
          },
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
            disabled: text.length < 6),
      ],
    ));
  }
}

class Timer extends StatefulWidget {
  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  CountdownController controller = CountdownController(autoStart: true);

  @override
  Widget build(BuildContext context) {
    return Countdown(
      seconds: 60,
      controller: controller,
      build: (BuildContext context, double time) {
        if (time.seconds.inSeconds == 0)
          return InkWell(
            onTap: () {
              controller.restart();
              controller.start();
            },
            child: Text(
              'Запросить код повторно',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          );
        return Container(
          width: 229,
          child: Text(
            'Запросить код повторно через ${time.seconds.inSeconds} сек.',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        );
      },
      interval: Duration(milliseconds: 100),
    );
  }
}

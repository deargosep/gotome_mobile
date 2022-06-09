import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/brand_button.dart';
import 'package:gotome/widgets/images/brand_icon.dart';
import 'package:gotome/widgets/images/logo.dart';
import 'package:gotome/widgets/input.dart';

class InputNewPasswordsScreen extends StatelessWidget {
  const InputNewPasswordsScreen({Key? key}) : super(key: key);

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
          'Введите новый пароль',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        SizedBox(
          height: 24,
        ),
        Input(
          label: 'Новый пароль',
        ),
        SizedBox(
          height: 16,
        ),
        Input(
          label: 'Повторите пароль',
        ),
        Spacer(),
        BrandButton(
            onPressed: () {
              Get.offAllNamed('/');
            },
            text: 'Продолжить',
            type: 'primary'),
      ],
    ));
  }
}

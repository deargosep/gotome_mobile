import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/brand_button.dart';
import 'package:gotome/widgets/images/brand_icon.dart';
import 'package:gotome/widgets/images/logo.dart';
import 'package:gotome/widgets/input.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: BrandIcon(icon: 'back_arrow')),
        Spacer(),
        Logo(),
        Spacer(),
        Input(
          label: 'Никнейм',
        ),
        SizedBox(
          height: 16,
        ),
        Input(
          label: 'E-mail',
        ),
        SizedBox(
          height: 16,
        ),
        Input(
          obscureText: true,
          label: 'Пароль',
        ),
        SizedBox(
          height: 16,
        ),
        Spacer(),
        BrandButton(
          onPressed: () {
            Get.toNamed('/register/form');
          },
          text: 'Продолжить',
          type: 'primary',
        ),
      ],
    ));
  }
}

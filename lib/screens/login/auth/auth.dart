import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/brand_button.dart';
import 'package:gotome/widgets/images/logo.dart';
import 'package:gotome/widgets/input.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Column(
      children: [
        Spacer(),
        Logo(),
        Spacer(),
        Input(
          label: 'E-mail',
        ),
        SizedBox(
          height: 16,
        ),
        Input(
          label: 'Пароль',
        ),
        SizedBox(
          height: 16,
        ),
        Align(
            alignment: Alignment.centerRight,
            child: Material(
                child: InkWell(
                    onTap: () {
                      Get.toNamed('auth/forgot/1');
                    },
                    child: Text(
                      'Забыли пароль?',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500),
                    )))),
        Spacer(),
        BrandButton(
          onPressed: () {
            Get.offAllNamed('/');
          },
          text: 'Вход',
          type: 'primary',
        ),
      ],
    ));
  }
}

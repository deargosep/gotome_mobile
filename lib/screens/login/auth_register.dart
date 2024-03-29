import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/brand_button.dart';
import 'package:gotome/widgets/images/logo.dart';

class AuthRegisterScreen extends StatelessWidget {
  const AuthRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Platform.operatingSystem == 'ios'
            ? Brightness.dark
            : Brightness.light));
    return CustomScaffold(
        body: Column(
      children: [
        Spacer(),
        Logo(),
        Spacer(),
        BrandButton(
          text: 'auth'.tr,
          type: 'primary',
          onPressed: () {
            Get.toNamed('/auth');
          },
        ),
        SizedBox(
          height: 16,
        ),
        BrandButton(
            onPressed: () {
              Get.toNamed('/register');
            },
            text: 'register'.tr,
            type: 'secondary'),
      ],
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/screens/auth_register.dart';

import 'theme/theme.dart';

void main() {
  runApp(GetMaterialApp(
    getPages: [
      GetPage(name: '/', page: () => AuthRegister()),
    ],
    theme: ThemeClass.lightTheme,
    home: AuthRegister(),
  ));
}

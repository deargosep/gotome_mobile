import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/screens/auth.dart';
import 'package:gotome/screens/auth_register.dart';
import 'package:gotome/screens/forgot_password/forgot_input_email.dart';

import 'theme/theme.dart';

void main() {
  runApp(GetMaterialApp(
    getPages: [
      GetPage(name: '/', page: () => AuthRegisterScreen()),
      GetPage(name: '/auth', page: () => AuthScreen()),
      GetPage(name: '/auth/forgot/1', page: () => InputEmailScreen()),
    ],
    theme: ThemeClass.lightTheme,
    home: AuthRegisterScreen(),
  ));
}

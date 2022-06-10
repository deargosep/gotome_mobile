import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gotome/screens/auth_register.dart';
import 'package:gotome/screens/event/event_screen.dart';
import 'package:gotome/screens/event/members.dart';
import 'package:gotome/screens/forgot_password/forgot_input_code.dart';
import 'package:gotome/screens/forgot_password/forgot_input_email.dart';
import 'package:gotome/screens/forgot_password/forgot_input_new_passwords.dart';
import 'package:gotome/screens/login/auth/auth.dart';
import 'package:gotome/screens/login/register/form.dart';
import 'package:gotome/screens/login/register/register.dart';
import 'package:gotome/screens/tabs/main.dart';

import 'theme/theme.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark); // 1
  runApp(GetMaterialApp(
    getPages: [
      GetPage(name: '/main', page: () => MainScreen()),
      GetPage(name: '/auth_register', page: () => AuthRegisterScreen()),
      GetPage(name: '/auth', page: () => AuthScreen()),
      GetPage(name: '/auth/forgot/1', page: () => InputEmailScreen()),
      GetPage(name: '/auth/forgot/2', page: () => InputCodeScreen()),
      GetPage(name: '/auth/forgot/3', page: () => InputNewPasswordsScreen()),
      GetPage(name: '/register', page: () => RegisterScreen()),
      GetPage(name: '/register/form', page: () => RegisterFormScreen()),
      GetPage(name: '/event', page: () => EventScreen()),
      GetPage(name: '/event/members', page: () => EventMembersScreen()),
    ],
    theme: ThemeClass.lightTheme,
    home: AuthRegisterScreen(),
  ));
}

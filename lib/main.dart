import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/screens/event/event_screen.dart';
import 'package:gotome/screens/event_create/A.dart';
import 'package:gotome/screens/event_create/B.dart';
import 'package:gotome/screens/event_create/C.dart';
import 'package:gotome/screens/event_create/D.dart';
import 'package:gotome/screens/event_create/E.dart';
import 'package:gotome/screens/event_create/F.dart';
import 'package:gotome/screens/event_create/G.dart';
import 'package:gotome/screens/event_create/select_date.dart';
import 'package:gotome/screens/event_create/select_interval.dart';
import 'package:gotome/screens/forgot_password/forgot_input_code.dart';
import 'package:gotome/screens/forgot_password/forgot_input_email.dart';
import 'package:gotome/screens/forgot_password/forgot_input_new_passwords.dart';
import 'package:gotome/screens/login/auth/auth.dart';
import 'package:gotome/screens/login/auth_register.dart';
import 'package:gotome/screens/login/register/form.dart';
import 'package:gotome/screens/login/register/register.dart';
import 'package:gotome/screens/members.dart';
import 'package:gotome/screens/profile_other.dart';
import 'package:gotome/screens/tabs/chat/chat.dart';
import 'package:gotome/screens/tabs/home/change_city.dart';
import 'package:gotome/screens/tabs/profile/profile_edit.dart';
import 'package:gotome/screens/tabs/profile/profile_events.dart';
import 'package:gotome/screens/tabs/profile/profile_info.dart';
import 'package:gotome/screens/tabs/profile/profile_support.dart';
import 'package:gotome/screens/tabs/search/filters.dart';
import 'package:gotome/screens/tabs/search/map.dart';
import 'package:gotome/screens/tabs/tabs.dart';
import 'package:gotome/state/events.dart';
import 'package:gotome/state/filter.dart';
import 'package:gotome/state/user.dart';
import 'package:provider/provider.dart';

import 'languages.dart';
import 'theme/theme.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => FiltersModel()),
      ChangeNotifierProvider(create: (context) => Events()),
      ChangeNotifierProvider(create: (context) => User()),
    ],
    child: GetMaterialApp(
      getPages: [
        GetPage(name: '/', page: () => AuthRegisterScreen()),
        GetPage(
          name: '/bar',
          page: () => BarScreen(),
          transition: Transition.noTransition,
        ),
        GetPage(name: '/auth', page: () => AuthScreen()),
        GetPage(name: '/auth/forgot/1', page: () => InputEmailScreen()),
        GetPage(name: '/auth/forgot/2', page: () => InputCodeScreen()),
        GetPage(name: '/auth/forgot/3', page: () => InputNewPasswordsScreen()),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/register/form', page: () => RegisterFormScreen()),
        GetPage(name: '/event', page: () => EventScreen()),
        GetPage(name: '/members', page: () => MembersScreen()),
        GetPage(name: '/profile_others', page: () => ProfileOtherScreen()),
        GetPage(name: '/change_city', page: () => ChangeCityScreen()),
        GetPage(name: '/filters', page: () => FiltersScreen()),
        GetPage(name: '/search/map', page: () => MapScreen()),
        GetPage(name: '/profile/edit', page: () => ProfileEditScreen()),
        GetPage(name: '/profile/support', page: () => ProfileSupportScreen()),
        GetPage(name: '/chat', page: () => ChatScreen()),
        // Map
        // TODO: nested screens in 'tabs' main screens
        GetPage(name: '/profile/events', page: () => ProfileEventsScreen()),
        GetPage(name: '/profile/info', page: () => ProfileInfoScreen()),
        // EVENT CREATE series
        GetPage(name: '/event/create/1', page: () => ACEScreen()),
        GetPage(name: '/event/create/2', page: () => BCEScreen()),
        GetPage(name: '/event/create/3', page: () => CCEScreen()),
        GetPage(name: '/event/create/4', page: () => DCEScreen()),
        GetPage(name: '/event/create/5', page: () => ECEScreen()),
        GetPage(name: '/event/create/6', page: () => FCEScreen()),
        GetPage(name: '/event/create/7', page: () => GCEScreen()),
        GetPage(
            name: '/event/create/select_date', page: () => SelectDateScreen()),
        GetPage(
            name: '/event/create/select_interval',
            page: () => SelectIntervalScreen()),
      ],
      translations: Languages(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('ru', 'RU'),
      theme: ThemeClass.lightTheme,
    ),
  ));
}

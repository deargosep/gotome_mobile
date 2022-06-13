import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ru_RU': {
          'auth': 'Вход',
          'register': 'Регистрация',
        },
        'en_US': {
          'auth': 'Auth',
          'register': 'Register',
        },
      };
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/brand_button.dart';
import 'package:gotome/widgets/header.dart';

import '../../../widgets/brand_option.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Map user = {
      "username": "HotLine",
      "registration_date": "03.06.2022",
      "is_subscribed": true,
      "name": "Игорь",
      "age": 24,
      "country": "Россия",
      "city": "Москва",
      "description":
          "С другой стороны, экономическая повестка сегодняшнего дня предоставляет широкие возможности для существующих финансовых и административных условий.",
      "gender": "Мужской",
      "birthday": "12.06.1998",
      "author_name": "Игорь",
      "author_age": 24,
      "author_country": "Россия",
      "author_city": "Москва",
      "author_description":
          "С другой стороны, экономическая повестка сегодняшнего дня предоставляет широкие возможности для существующих финансовых и административных условий.",
    };
    return CustomScaffold(
      noPadding: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Column(
              children: [
                Header(
                  withPadding: false,
                  withBack: false,
                  text: "Мой профиль",
                ),
                SizedBox(
                  height: 33,
                ),
                Row(
                  children: [
                    Container(
                      height: 91,
                      width: 91,
                      child: CircleAvatar(),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user["username"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Дата регистрации: ${user["registration_date"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color(0xFF6A7592)),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                SizedBox(
                  height: 32,
                ),
                ListOfOptions(
                    //  TODO: this should be a global variable, not to being passed around widgets
                    user: user),
                SizedBox(
                  height: 32,
                ),
                InkWell(
                  onTap: () {
                    //  TODO: logout
                    Get.offAllNamed('/');
                  },
                  child: Text(
                    'Выйти из профиля',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ListOfOptions extends StatelessWidget {
  const ListOfOptions({Key? key, required this.user}) : super(key: key);
  final user;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Option(
          text: "Моя анкета",
          onTap: () {
            Get.toNamed('/profile/info', arguments: user);
          },
        ),
        SizedBox(
          height: 16,
        ),
        Option(
          text: "Мои события",
          onTap: () {
            Get.toNamed('/profile/events', arguments: user);
          },
        ),
        SizedBox(
          height: 16,
        ),
        Option(
          text: "Поддержка",
          onTap: () {
            Get.toNamed('/profile/support', arguments: user);
          },
        ),
        SizedBox(
          height: 32,
        ),
        BrandButton(
          text: 'Подписка',
          type: 'primary',
          textAlign: 'left',
          textStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gotome/widgets/event_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    const textStyle = TextStyle(
        fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white);
    const textStyleBold = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white);
    return Column(
      children: [
        // Header
        Container(
          height: 76 + MediaQuery.of(context).viewPadding.top,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(
              16, 16 + MediaQuery.of(context).viewPadding.top, 16, 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              color: Theme.of(context).primaryColor),
          child: GestureDetector(
            onTap: () {
              Get.toNamed('/change_city');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'События в городе',
                  style: textStyle,
                ),
                Text(
                  'Москва',
                  style: textStyleBold,
                )
              ],
            ),
          ),
        ),
        // List
        Expanded(
            child: Content(list: [
          {
            "id": "123adssdad",
            "author": "HotLine",
            "authorId": "12222",
            "author_role": "Организатор",
            "author_info": {
              "author_name": "Игорь",
              "author_username": "HotLine",
              "author_age": 24,
              "author_country": "Россия",
              "author_city": "Москва",
              "author_description":
                  "С другой стороны, экономическая повестка сегодняшнего дня предоставляет широкие возможности для существующих финансовых и административных условий.",
            },
            "name": "Катаемся на велосипедах",
            "timedate": "03.06.2022 в 15:00",
            "location": "Наб. Реки Фонтанки, 3",
            "description":
                "Приглашаем тебя покататься с нами по городу! Компания веселая! Обещаем, что будет весело, ждем тебя с нетерпением!!!",
            "price": "Бесплатно",
            "members": [
              {"username": "MajEstic21"},
              {"username": "Alice18"},
              {"username": "Pavkl"},
              {"username": "ForJik"},
            ],
            "opened_from_profile": false
          },
          {
            "id": "123132sddsad",
            "author": "HotLine",
            "authorId": "12222",
            "author_role": "Организатор",
            "author_info": {
              "author_username": "HotLine",
              "author_name": "Игорь",
              "author_age": 24,
              "author_country": "Россия",
              "author_city": "Москва",
              "author_description":
                  "С другой стороны, экономическая повестка сегодняшнего дня предоставляет широкие возможности для существующих финансовых и административных условий.",
            },
            "name": "Катаемся на велосипедах",
            "timedate": "03.06.2022 в 15:00",
            "location": "Наб. Реки Фонтанки, 3",
            "description":
                "Приглашаем тебя покататься с нами по городу! Компания веселая! Обещаем, что будет весело, ждем тебя с нетерпением!!!",
            "price": "Бесплатно",
            "members": [
              {"username": "MajEstic21"},
              {"username": "Alice18"},
              {"username": "Pavkl"},
              {"username": "ForJik"},
            ],
            "opened_from_profile": false
          }
        ]))
      ],
    );
  }
}

class Content extends StatelessWidget {
  Content({Key? key, required this.list}) : super(key: key);
  List<Map<String, dynamic>> list;
  @override
  Widget build(BuildContext context) {
    if (list.isNotEmpty) {
      return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: EventCard(item: list[index]),
            );
          });
    }
    return Center(child: Text('Пока что событий нет'));
  }
}

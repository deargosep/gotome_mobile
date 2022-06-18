import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/screens/profile_other.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/event_card.dart';
import 'package:gotome/widgets/header.dart';
import 'package:gotome/widgets/images/brand_icon.dart';
import 'package:gotome/widgets/input.dart';
import 'package:gotome/widgets/top_tab.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: CustomScaffold(
        padding: EdgeInsets.fromLTRB(
            20, 40 + MediaQuery.of(context).viewInsets.top, 20, 0),
        body: Column(
          children: [
            Header(
              withPadding: false,
              text: 'Поиск',
            ),
            SizedBox(
              height: 57,
            ),
            TabsSwitch(
              children: [
                TopTab(
                  text: 'Списком',
                ),
                TopTab(
                  text: 'На карте',
                ),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            Expanded(child: TabBarView(children: [Search(), OnMap()]))
          ],
        ),
      ),
    );
  }
}

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = {
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
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: 300,
          child: Row(
            children: [
              Expanded(
                child: Input(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  height: 40.0,
                  label: 'Поиск',
                  icon: 'search_input',
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                height: 40,
                width: 40,
                padding: EdgeInsets.symmetric(vertical: 13, horizontal: 11),
                decoration: BoxDecoration(
                    color: Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed('/filters');
                  },
                  child: BrandIcon(
                    icon: 'filters',
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Expanded(
          child: ListView.builder(itemBuilder: (context, index) {
            return Column(
              children: [
                EventCard(item: item),
                SizedBox(
                  height: 24,
                )
              ],
            );
          }),
        )
      ],
    );
  }
}

class OnMap extends StatelessWidget {
  const OnMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

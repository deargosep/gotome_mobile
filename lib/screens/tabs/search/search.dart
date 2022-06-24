import 'package:flutter/material.dart';
import 'package:gotome/widgets/event_card.dart';
import 'package:gotome/widgets/header.dart';
import 'package:gotome/widgets/search_input.dart';

import '../../../widgets/map.dart';
import '../../../widgets/top_tab.dart';
import '../../profile_other.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              0, 40 + MediaQuery.of(context).viewInsets.top, 0, 0),
          child: NestedScrollView(
              headerSliverBuilder: (context, value) {
                return [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
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
                            height: 24,
                          )
                        ],
                      ),
                    ),
                  )
                ];
              },
              body: TabBarView(children: [Search(), OnMap()])),
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
      "opened_from_profile": false
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SearchInput(),
          SizedBox(
            height: 24,
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                EventCard(item: item),
                SizedBox(
                  height: 24,
                ),
                EventCard(item: item),
                SizedBox(
                  height: 24,
                ),
                EventCard(item: item),
                SizedBox(
                  height: 24,
                ),
                EventCard(item: item),
                SizedBox(
                  height: 24,
                ),
                EventCard(item: item),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          )
          // ListView.builder(
          //     // shrinkWrap: true,
          //     physics: NeverScrollableScrollPhysics(),
          //     itemCount: 2,
          //     itemBuilder: (context, index) {
          //       return Column(
          //         children: [
          //           EventCard(item: item),
          //           SizedBox(
          //             height: 24,
          //           )
          //         ],
          //       );
          //     })
        ],
      ),
    );
  }
}

class OnMap extends StatelessWidget {
  const OnMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SearchInput(),
        ),
        SizedBox(
          height: 16,
        ),
        GeoMap()
      ],
    );
  }
}

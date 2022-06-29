import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/screens/tabs/search/map.dart';
import 'package:gotome/widgets/event_card.dart';
import 'package:gotome/widgets/header.dart';
import 'package:gotome/widgets/search_input.dart';
import 'package:gotome/widgets/tabbar_switch.dart';

import '../../../widgets/top_tab.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      vsync: this,
      length: 2,
    );
    controller.addListener(() {
      print(controller.index);
      if (controller.index == 1) {
        Get.to(() => MapScreen(),
            fullscreenDialog: false,
            popGesture: true,
            transition: Transition.noTransition);
        controller.index = 0;
        DefaultTabController.of(context)?.animateTo(0);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollView = ScrollController();
    final arguments = Get.arguments;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              0, 40 + MediaQuery.of(context).viewInsets.top, 0, 0),
          child: NestedScrollView(
              physics: NeverScrollableScrollPhysics(),
              controller: scrollView,
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
                            controller: controller,
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
              body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller,
                  children: [Search(), _FakeOnMap()])),
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
            // TODO: turn into builder, when there will be backend
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

class _FakeOnMap extends StatelessWidget {
  const _FakeOnMap({Key? key}) : super(key: key);

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
        Container()
      ],
    );
  }
}

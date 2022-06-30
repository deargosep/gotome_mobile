import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/event_card.dart';
import 'package:gotome/widgets/images/brand_icon.dart';
import 'package:gotome/widgets/top_tab.dart';
import 'package:latlong2/latlong.dart';

import '../widgets/tabbar_switch.dart';

class ProfileOtherScreen extends StatefulWidget {
  ProfileOtherScreen({Key? key}) : super(key: key);

  @override
  State<ProfileOtherScreen> createState() => _ProfileOtherScreenState();
}

class _ProfileOtherScreenState extends State<ProfileOtherScreen>
    with TickerProviderStateMixin {
  final author = Get.arguments;
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return CustomScaffold(
      padding: EdgeInsets.fromLTRB(
          20, 40 + MediaQuery.of(context).viewInsets.top, 20, 0),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: BrandIcon(icon: 'back_arrow')),
            Container(
              height: 114,
              width: 114,
              child: CircleAvatar(),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              author["author_username"]!,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary),
            ),
            SizedBox(
              height: 24,
            ),
            TabsSwitch(
              controller: controller,
              children: [
                TopTab(
                  text: 'Информация',
                ),
                TopTab(
                  text: 'История событий',
                )
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Expanded(
                child: TabBarView(children: [
              Info(
                author: author,
              ),
              History()
            ])),
          ],
        ),
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({Key? key, required this.author}) : super(key: key);
  final author;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Имя',
          style: TextStyle(color: Color(0xFF6A7592)),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          author["author_name"]!,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Theme.of(context).colorScheme.secondary),
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          'Возраст',
          style: TextStyle(color: Color(0xFF6A7592)),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          author["author_age"].toString(),
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Theme.of(context).colorScheme.secondary),
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          'Страна',
          style: TextStyle(color: Color(0xFF6A7592)),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          author["author_country"],
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Theme.of(context).colorScheme.secondary),
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          'Город',
          style: TextStyle(color: Color(0xFF6A7592)),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          author["author_city"],
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Theme.of(context).colorScheme.secondary),
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          'О себе',
          style: TextStyle(color: Color(0xFF6A7592)),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          author["author_description"]!,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Theme.of(context).colorScheme.secondary),
        ),
      ],
    );
  }
}

class History extends StatelessWidget {
  const History({Key? key, this.fromMyProfile}) : super(key: key);
  final fromMyProfile;
  @override
  Widget build(BuildContext context) {
    print(fromMyProfile);
    var item = {
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
      "location_coords": LatLng(59.9386443693454, 30.34124824247019),
      "description":
          "Приглашаем тебя покататься с нами по городу! Компания веселая! Обещаем, что будет весело, ждем тебя с нетерпением!!!",
      "price": "Бесплатно",
      "members": [
        {"username": "MajEstic21"},
        {"username": "Alice18"},
        {"username": "Pavkl"},
        {"username": "ForJik"},
      ],
      "opened_from_profile": true
    };
    //TODO
    return ListView(
      children: [
        Text(
          'Активные',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary),
        ),
        SizedBox(
          height: 16,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              return EventCard();
            }),
        SizedBox(
          height: 32,
        ),
        Text(
          'Завершенные',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary),
        ),
        SizedBox(
          height: 16,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              return Opacity(
                  opacity: 0.35,
                  child: EventCard(
                    item: fromMyProfile == true ? item : null,
                  ));
            }),
      ],
    );
  }
}

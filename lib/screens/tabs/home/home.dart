import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/state/events.dart';
import 'package:gotome/state/user.dart';
import 'package:gotome/utils/event.dart';
import 'package:gotome/widgets/event_card.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Column(
      children: [
        // Header
        _Header(),
        // List
        Expanded(
            child: Content(initList: [
          EventType(
              id: "123adssdad",
              author: Author(
                id: "12222",
                username: "HotLine",
                name: "Игорь",
                age: 24,
                country: "Россия",
                city: "Москва",
                description:
                    "С другой стороны, экономическая повестка сегодняшнего дня предоставляет широкие возможности для существующих финансовых и административных условий.",
              ),
              name: "Катаемся на барсуках",
              timedate: "03.06.2022 в 15:00",
              location: "Наб. Реки Фонтанки, 3",
              location_coords: LatLng(59.9386443693454, 30.34124824247019),
              description:
                  "Приглашаем тебя покататься с нами по городу! Компания веселая! Обещаем, что будет весело, ждем тебя с нетерпением!!!",
              price: "Бесплатно",
              members: [
                {"username": "MajEstic21"},
                {"username": "Alice18"},
                {"username": "Pavkl"},
                {"username": "ForJik"},
              ],
              dot: Dot(
                  latLng: LatLng(59.9386443693454, 30.34124824247019),
                  id: "123adssdad",
                  name: "Катаемся на барсуках",
                  country: "Россия",
                  city: "Москва",
                  locationString: "Наб. Реки Фонтанки, 3",
                  tags: ["Активный отдых"],
                  gender: 'female',
                  datetime: "03.06.2022 в 15:00",
                  date: '03.06.2022')),
          EventType(
              id: "123adssdad",
              author: Author(
                id: "12222",
                username: "HotLine",
                name: "Игорь",
                age: 24,
                country: "Россия",
                city: "Москва",
                description:
                    "С другой стороны, экономическая повестка сегодняшнего дня предоставляет широкие возможности для существующих финансовых и административных условий.",
              ),
              name: "Катаемся на велосипедах2",
              timedate: "03.06.2022 в 15:00",
              location: "Наб. Реки Фонтанки, 3",
              location_coords: LatLng(55.76196961326696, 37.627123975766146),
              description:
                  "Приглашаем тебя покататься с нами по городу! Компания веселая! Обещаем, что будет весело, ждем тебя с нетерпением!!!",
              price: "Бесплатно",
              members: [
                {"username": "MajEstic21"},
                {"username": "Alice18"},
                {"username": "Pavkl"},
                {"username": "ForJik"},
              ],
              dot: Dot(
                  latLng: LatLng(55.76196961326696, 37.627123975766146),
                  id: "123adssdad",
                  name: "Катаемся на велосипедах2",
                  country: "Россия",
                  city: "Москва",
                  gender: 'male',
                  locationString: "Наб. Реки Фонтанки, 3",
                  tags: ["Активный отдых", "Путешествия"],
                  datetime: "01.06.2022 в 15:00",
                  date: '01.06.2022'))
        ]))
      ],
    );
  }
}

class Content extends StatelessWidget {
  const Content({Key? key, required this.initList}) : super(key: key);
  final List<EventType> initList;

  @override
  Widget build(BuildContext context) {
    Provider.of<Events>(context, listen: false).setEvents(initList);
    var list = Provider.of<Events>(context, listen: true).events;
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

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white);
    const textStyleBold = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white);
    return Container(
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
              Provider.of<User>(context, listen: true).user.city,
              style: textStyleBold,
            )
          ],
        ),
      ),
    );
  }
}

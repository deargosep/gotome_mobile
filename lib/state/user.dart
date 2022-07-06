import 'package:flutter/material.dart';
import 'package:gotome/state/events.dart';
import 'package:gotome/utils/event.dart';
import 'package:latlong2/latlong.dart';

class User extends ChangeNotifier {
  UserType _user = UserType();
  Author _userMeta = Author(
    id: "12222",
    username: "HotLine",
    name: "Игорь",
    birthday: '03.06.2000',
    gender: 'Мужчина',
    age: 24,
    country: "Россия",
    city: "Москва",
    registration_date: '03.06.2022',
    description:
        "С другой стороны, экономическая повестка сегодняшнего дня предоставляет широкие возможности для существующих финансовых и административных условий.",
    events: [
      EventType(
          isComplete: true,
          id: "123adssdad",
          author: Author(
              id: "12222",
              gender: 'Мужчина',
              birthday: '03.06.2000',
              username: "HotLine",
              name: "Игорь",
              age: 24,
              country: "Россия",
              city: "Москва",
              description:
                  "С другой стороны, экономическая повестка сегодняшнего дня предоставляет широкие возможности для существующих финансовых и административных условий.",
              events: []),
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
              date: '01.06.2022')),
      EventType(
          isComplete: false,
          id: "123adssdad",
          author: Author(
              id: "12222",
              gender: 'Мужчина',
              birthday: '03.06.2000',
              username: "HotLine",
              name: "Игорь",
              age: 24,
              country: "Россия",
              city: "Москва",
              description:
                  "С другой стороны, экономическая повестка сегодняшнего дня предоставляет широкие возможности для существующих финансовых и административных условий.",
              events: []),
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
    ],
  );
  // List<Dot> _filteredDots = [];

  // void setUser(List<String> filters) {
  //   _categories = filters;
  //   notifyListeners();
  // }

  void setData(UserType user) {
    _user = user;
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  UserType get user => _user;
  Author get userMeta => _userMeta;
}

class UserType {
  String country;
  String city;

  UserType({this.city = 'Москва', this.country = 'Россия'});
}

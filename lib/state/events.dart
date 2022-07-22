import 'package:flutter/material.dart';
import 'package:gotome/utils/event.dart';
import 'package:latlong2/latlong.dart';

class Events extends ChangeNotifier {
  List<EventType> _events = [
    EventType(
        isComplete: true,
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
        isComplete: false,
        id: "123adssdad",
        author: Author(
          id: "12222",
          username: "fdfdfdfdfdfdfd",
          name: "Игорь",
          age: 24,
          country: "Россия",
          city: "Москва",
          description:
              "С другой стороны, экономическая повестка сегодняшнего дня предоставляет широкие возможности для существующих финансовых и административных условий.",
        ),
        name: "Катаемся на барсуках2",
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
  ];

  List<EventType> get events => _events;

  void setEvents(List<EventType> events) {
    _events = events;
  }

  /// Removes all items from the cart.
  void removeAll() {
    _events.clear();
    notifyListeners();
  }
}

class EventType {
  final id;
  final isComplete;
  final Author author;
  final name;
  final timedate;
  final location;
  final LatLng location_coords;
  final description;
  final price;
  final List members;
  final Dot dot;

  EventType({
    required this.id,
    this.isComplete,
    required this.author,
    required this.name,
    required this.timedate,
    required this.location,
    required this.location_coords,
    required this.description,
    required this.price,
    required this.members,
    required this.dot,
  });
}

class Author {
  final id;
  final username;
  final gender;
  final birthday;
  final age;
  final country;
  final city;
  final name;
  final description;
  final registration_date;
  final events;

  Author(
      {required this.id,
      required this.username,
      this.gender,
      this.birthday,
      required this.name,
      required this.age,
      required this.country,
      required this.city,
      required this.description,
      this.registration_date,
      this.events});
}

import 'package:flutter/material.dart';
import 'package:gotome/utils/event.dart';
import 'package:latlong2/latlong.dart';

class Events extends ChangeNotifier {
  List<EventType> _events = [];

  List<EventType> get events => _events;

  void setEvents(List<EventType> events) {
    _events = events;
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _events.clear();
    notifyListeners();
  }
}

class EventType {
  final id;
  final Author author;
  final name;
  final timedate;
  final location;
  final LatLng location_coords;
  final description;
  final price;
  final List members;
  final Dot dot;

  EventType(
      {required this.id,
      required this.author,
      required this.name,
      required this.timedate,
      required this.location,
      required this.location_coords,
      required this.description,
      required this.price,
      required this.members,
      required this.dot});
}

class Author {
  final id;
  final username;
  final age;
  final country;
  final city;
  final name;
  final description;

  Author({
    required this.id,
    required this.username,
    required this.name,
    required this.age,
    required this.country,
    required this.city,
    required this.description,
  });
}

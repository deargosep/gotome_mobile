import 'package:flutter/material.dart';
import 'package:gotome/state/events.dart';
import 'package:gotome/utils/event.dart';

class FiltersModel extends ChangeNotifier {
  Meta _meta = Meta(country: '', city: '', date: '', gender: 'none');
  List<String> _categories = [];
  List<Dot> _filteredDots = [];
  List<EventType> _filteredEvents = [];

  void setMeta(Meta meta) {
    _meta.country = meta.country;
    _meta.city = meta.city;
    _meta.gender = meta.gender;
    _meta.date = meta.date;
    notifyListeners();
  }

  void setFilters(List<String> filters) {
    _categories = filters;
    notifyListeners();
  }

  void filterDots(List<Dot> list, String text) {
    var oldList = [...list];
    var downText = text.toLowerCase();
    print(_meta.gender);
    var newList = oldList.where((Dot element) {
      print('s' + element.name.toLowerCase().contains(downText).toString());
      return ((downText == ''
                  ? true
                  : element.name.toLowerCase().contains(downText)) ||
              (downText == ''
                  ? true
                  : element.locationString.toLowerCase().contains(downText))) &&
          (_categories.isEmpty
              ? true
              : _categories
                  .any((element2) => element.tags.contains(element2))) &&
          (_meta.country == ''
              ? true
              : _meta.country.toLowerCase() == element.country.toLowerCase()) &&
          (_meta.gender == 'none' ? true : _meta.gender == element.gender) &&
          (_meta.city == ''
              ? true
              : _meta.city.toLowerCase() == element.city.toLowerCase());
      _meta.date == element.date;
    }).toList();
    _filteredDots = newList;
    print(newList);
  }

  void filterEvents(List<EventType> list, String text) {
    var oldList = [...list];
    var downText = text.toLowerCase();
    print(_meta.gender);
    var newList = oldList.where((EventType element) {
      print('s' + element.name.toLowerCase().contains(downText).toString());
      return ((downText == ''
                  ? true
                  : element.name.toLowerCase().contains(downText)) ||
              (downText == ''
                  ? true
                  : element.dot.locationString
                      .toLowerCase()
                      .contains(downText))) &&
          (_categories.isEmpty
              ? true
              : _categories
                  .any((element2) => element.dot.tags.contains(element2))) &&
          (_meta.country == ''
              ? true
              : _meta.country.toLowerCase() ==
                  element.dot.country.toLowerCase()) &&
          (_meta.gender == 'none'
              ? true
              : _meta.gender == element.dot.gender) &&
          (_meta.city == ''
              ? true
              : _meta.city.toLowerCase() == element.dot.city.toLowerCase());
      _meta.date == element.dot.date;
    }).toList();
    _filteredEvents = newList;
    print(newList);
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _meta = Meta(city: '', country: '', date: '', gender: '');
    _categories.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  List<String> get categories => _categories;
  get meta => _meta;
  List<Dot> get filteredDots => _filteredDots;
  List<EventType> get filteredEvents => _filteredEvents;
}

class Meta {
  String country;
  String city;
  String date;
  String gender;

  Meta(
      {this.city = '',
      this.date = '',
      this.gender = 'none',
      this.country = ''});
}

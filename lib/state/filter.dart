import 'package:flutter/material.dart';
import 'package:gotome/utils/event.dart';

class FiltersModel extends ChangeNotifier {
  Meta _meta = Meta(country: '', city: '', date: '', gender: 'none');
  List<String> _categories = [];
  List<Dot> _filteredDots = [];

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
    var newList = oldList.where((Dot element) {
      return element.name.contains(text) ||
          element.locationString.contains(text) ||
          categories.any((element2) => element.tags.contains(element2));
    }).toList();
    _filteredDots = newList;
    // notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _meta = Meta(city: '', country: '', date: '', gender: '');
    _categories.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  List get categories => _categories;
  get meta => _meta;
  List<Dot> get filteredDots => _filteredDots;
}

class Meta {
  String country;
  String city;
  String date;
  String gender;

  Meta(
      {required this.city,
      required this.date,
      required this.gender,
      required this.country});
}

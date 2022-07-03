import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  UserType _user = UserType();
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
}

class UserType {
  String country;
  String city;

  UserType({this.city = 'Москва', this.country = 'Россия'});
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gotome/screens/tabs/chat/chats.dart';
import 'package:gotome/screens/tabs/home/home.dart';
import 'package:gotome/screens/tabs/profile/profile.dart';
import 'package:gotome/screens/tabs/search/search.dart';
import 'package:gotome/widgets/bottom_bar.dart';

class BarScreen extends StatefulWidget {
  const BarScreen({Key? key}) : super(key: key);

  @override
  State<BarScreen> createState() => _BarScreenState();
}

class _BarScreenState extends State<BarScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    //Home
    HomeScreen(),
    //Search
    SearchScreen(),
    //Chat
    ChatsScreen(),
    //Profile
    MyProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Platform.operatingSystem == 'ios'
            ? Brightness.dark
            : Brightness.light));
    return Scaffold(
        // backgroundColor: Color(0xFFEAEAEA),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomBar(
            onTap: _onItemTapped,
            onCenterTap: () {
              Get.toNamed('/event/create/1');
            },
            currentIndex: _selectedIndex)
        // BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   iconSize: 20,
        //   selectedFontSize: 8.0,
        //   unselectedFontSize: 8.0,
        //   selectedItemColor: Theme.of(context).primaryColor,
        //   unselectedItemColor: Color(0xFF9FA6BA),
        //   enableFeedback: true,
        //   elevation: 0.0,
        //   currentIndex: _selectedIndex,
        //   items: items,
        //   onTap: _onItemTapped,
        // ),
        );
  }
}

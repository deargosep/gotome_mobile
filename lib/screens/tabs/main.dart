import 'package:flutter/material.dart';
import 'package:gotome/screens/tabs/home.dart';
import 'package:gotome/widgets/bottom_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    Text(
      '1',
    ),
    Text(
      '2',
    ),
    Text(
      '3',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color(0xFFEAEAEA),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomBar(
            onTap: _onItemTapped,
            onCenterTap: () {
              print('lol');
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

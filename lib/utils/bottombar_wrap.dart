import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/widgets/bottom_bar.dart';

class BottomBarWrap extends StatefulWidget {
  const BottomBarWrap({Key? key, required int this.currentTab})
      : super(key: key);
  final int currentTab;

  @override
  State<BottomBarWrap> createState() => _BottomBarWrapState();
}

class _BottomBarWrapState extends State<BottomBarWrap> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentTab;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Get.offAllNamed('/bar', arguments: index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomBar(
        onTap: _onItemTapped,
        onCenterTap: () {
          Get.toNamed('/event/create/1');
        },
        currentIndex: _selectedIndex);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:gotome/utils/bottombar_wrap.dart';
import 'package:gotome/widgets/header.dart';
import 'package:gotome/widgets/search_input.dart';
import 'package:gotome/widgets/tabbar_switch.dart';

import '../../../widgets/geomap.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this, initialIndex: 1);
    controller.addListener(() {
      if (controller.index == 0) Get.back();
    });
  }

  final coords = Get.arguments;

  @override
  Widget build(BuildContext context) {
    void filterDots(query) {
      print(query);
    }

    return Scaffold(
      bottomNavigationBar: BottomBarWrap(
        currentTab: 1,
      ),
      body: Column(
        children: [
          coords != null && coords != ''
              ? Container()
              : Padding(
                  padding: EdgeInsets.only(
                      top: 40 + MediaQuery.of(context).viewInsets.top),
                  child: Column(
                    children: [
                      Header(
                        withBack: false,
                        text: 'Поиск',
                      ),
                      SizedBox(
                        height: 57,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TabsSwitch(
                                mockupOnly: true, controller: controller),
                            SizedBox(
                              height: 24,
                            ),
                            SearchInput(onComplete: filterDots)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
          Expanded(
              child: coords != null && coords != ''
                  ? GeoMap(
                      selectedLocation: coords,
                    )
                  : GeoMap()
              // GeoMap(locations: locationList, withLocation: false)
              )
        ],
      ),
    );
  }
}

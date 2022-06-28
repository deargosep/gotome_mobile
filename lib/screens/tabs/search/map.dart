import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:gotome/widgets/geomap.dart';
import 'package:gotome/widgets/header.dart';
import 'package:gotome/widgets/search_input.dart';
import 'package:gotome/widgets/tabbar_switch.dart';

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

  final address = Get.arguments;

  @override
  Widget build(BuildContext context) {
    Future<List<Location>> getLocations() async {
      List<Location> location = await locationFromAddress(address);
      return location;
    }

    return Scaffold(
      body: Column(
        children: [
          address != null && address != ''
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
                            SearchInput()
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
              child: FutureBuilder<List<Location>>(
            future: getLocations(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return GeoMap();
              return GeoMap(locations: snapshot.data);
            },
          ))
        ],
      ),
    );
  }
}

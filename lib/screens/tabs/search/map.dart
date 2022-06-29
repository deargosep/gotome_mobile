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
    List locationList = [
      {
        "id": 111,
        "lat": 59.9386443693454,
        "lng": 30.34124824247019,
        "title": "Катаемся на велосипедах",
        "datetime": "03.06.2022 в 15:00"
      },
      {
        "id": 11,
        "lat": 55.68873830008359,
        "lng": 37.5838732576966,
        "title": "Катаемся на велосипедах",
        "datetime": "03.06.2022 в 15:00"
      }
    ];
    Future<Location> getLocations() async {
      List<Location> location = await locationFromAddress(address);
      return location[0];
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
              child: address != null && address != ''
                  ? FutureBuilder<dynamic>(
                      future: getLocations(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Container();
                        }
                        if (snapshot.data != null)
                          return GeoMap(
                            withLocation: true,
                            location: snapshot.data,
                            locations: locationList,
                          );
                        return Container();
                      },
                    )
                  : GeoMap(locations: locationList, withLocation: false))
        ],
      ),
    );
  }
}

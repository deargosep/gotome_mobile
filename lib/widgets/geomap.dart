import 'dart:async';
import 'dart:io';
import 'dart:math' show cos, sqrt, asin;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gotome/utils/bitmap.dart';
import 'package:gotome/widgets/images/brand_icon.dart';
import 'package:location/location.dart';

class GeoMap extends StatefulWidget {
  const GeoMap(
      {Key? key,
      this.location,
      required this.withLocation,
      required this.locations})
      : super(key: key);
  final location;
  final List locations;
  final bool withLocation;
  @override
  State<GeoMap> createState() => GeoMapState();
}

class GeoMapState extends State<GeoMap> {
  Completer<GoogleMapController> _controller = Completer();
  var currentLocation = {};
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  var distanceOverlay = false;
  var distance = 0;
  var distanceId = "0";

  Location _location = new Location();
  late StreamSubscription<LocationData> locationSubscription;
  @override
  void initState() {
    super.initState();
    locationSubscription = _location.onLocationChanged.listen((locationData) {
      setState(() {
        currentLocation = {
          "longitude": locationData.longitude,
          "latitude": locationData.latitude
        };
      });
      generateMarkers();
    });
  }

  @override
  void dispose() {
    if (!mounted) locationSubscription.cancel();
    super.dispose();
  }
  // __________________________________________

  late BitmapDescriptor customIcon;
  Future<BitmapDescriptor> createCustomMarkerBitmapWithNameAndImage(
      String imagePath, Size size, String name) async {
    ui.PictureRecorder recorder = new ui.PictureRecorder();
    Canvas canvas = new Canvas(recorder);

    final double shadowWidth = 15.0;
    final double borderWidth = 2.5;
    final double imageOffset = shadowWidth + borderWidth;

    final Radius radius = Radius.circular(size.width / 2);

    final Paint shadowCirclePaint = Paint()
      ..color = Theme.of(context).primaryColor.withAlpha(180);

    // Add shadow circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
              size.width / 8, size.width / 2, size.width, size.height),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowCirclePaint);
    //
    // // TEXT BOX BACKGROUND
    // Paint textBgBoxPaint = Paint()..color = Theme.of(context).primaryColor;
    //
    // Rect rect = Rect.fromLTWH(
    //   0,
    //   0,
    //   tp.width + 35,
    //   50,
    // );
    //
    // canvas.drawRRect(
    //   RRect.fromRectAndRadius(rect, Radius.circular(10.0)),
    //   textBgBoxPaint,
    // );

    //ADD TEXT WITH ALIGN TO CANVAS
    // tp.paint(canvas, new Offset(20.0, 5.0));

    /* Do your painting of the custom icon here, including drawing text, shapes, etc. */

    Rect oval = Rect.fromLTWH(35, 78, size.width - (imageOffset * 2),
        size.height - (imageOffset * 2));

    // ADD  PATH TO OVAL IMAGE
    canvas.clipPath(Path()..addOval(oval));

    ui.Image image = await getImageFromPath(imagePath);
    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);

    ui.Picture p = recorder.endRecording();
    ByteData? pngBytes = await (await p.toImage(300, 300))
        .toByteData(format: ui.ImageByteFormat.png);

    Uint8List data = Uint8List.view(pngBytes!.buffer);

    return BitmapDescriptor.fromBytes(data);
  }

  Future<ui.Image> getImageFromPath(String imagePath) async {
    File imageFile = File(imagePath);

    Uint8List imageBytes = imageFile.readAsBytesSync();

    final Completer<ui.Image> completer = new Completer();

    ui.decodeImageFromList(imageBytes, (ui.Image img) {
      return completer.complete(img);
    });

    return completer.future;
  }

  Future<BitmapDescriptor> getMarkerIcon(String image, String name) async {
    if (image != null) {
      final File markerImageFile =
          await DefaultCacheManager().getSingleFile(image);
      Size s = Size(120, 120);

      var icon = await createCustomMarkerBitmapWithNameAndImage(
          markerImageFile.path, s, name);
      return icon;
    } else {
      return BitmapDescriptor.defaultMarker;
    }
  }
  //________________________________________________________

  late final CameraPosition _moscow = CameraPosition(
    target: LatLng(55.7558, 37.6173),
    zoom: 14.4746,
  );

  late final CameraPosition locationPos = CameraPosition(
      target: LatLng(
          widget.withLocation
              ? widget.location.latitude
              : _moscow.target.latitude,
          widget.withLocation
              ? widget.location.longitude
              : _moscow.target.longitude),
      zoom: 14.4746);

  late final CameraPosition userLocation = CameraPosition(
      target: LatLng(currentLocation["latitude"] ?? _moscow.target.latitude,
          currentLocation["longitude"] ?? _moscow.target.longitude),
      zoom: 14.4746);

  Set<Marker>? _markers = <Marker>{};

  void generateMarkers() async {
    var localMarkers = <Marker>{};

    var locationsList = [
      ...widget.locations,
      {
        "id": 124.2,
        "lat": _moscow.target.latitude,
        "lng": _moscow.target.longitude,
        "title": "moscow",
      },
      !currentLocation.isEmpty
          ? {
              "id": "user",
              "lat": currentLocation["latitude"],
              "lng": currentLocation["longitude"]
            }
          : null
    ];

    double calculateDistance(lat1, lon1, lat2, lon2) {
      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 -
          c((lat2 - lat1) * p) / 2 +
          c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
      return 12742 * asin(sqrt(a));
    }

    if (distanceId != "0") {
      var myLoc = locationsList
          .firstWhere((element) => element["id"].toString() == distanceId);
      var calculatedDistance = calculateDistance(currentLocation["latitude"],
          currentLocation["longitude"], myLoc["lat"], myLoc["lng"]);
      setState(() {
        distance = num.parse(calculatedDistance.toStringAsFixed(2)).toInt();
      });
    }

    for (var location in locationsList) {
      if (location != null) {
        localMarkers.add(Marker(
            markerId: MarkerId(location["id"].toString()),
            position: LatLng(double.parse(location["lat"].toString()),
                double.parse(location["lng"]!.toString())),
            icon: location["id"] != "user"
                ? await bitmapDescriptorFromSvgAsset(
                    context, 'assets/icons/geo_user.svg')
                : await getMarkerIcon(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuIavvjuQFB38Se2ZNa0GkZ1Gol3C5OwioHA&usqp=CAU",
                    "JASSABELLE"),
            onTap: () {
              if (location["id"] != "user") {
                _customInfoWindowController.addInfoWindow!(
                    Container(
                        width: 171,
                        height: 60,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              location["title"],
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                BrandIcon(icon: 'clock'),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  location["datetime"],
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                    LatLng(location["lat"], location["lng"]));
                var calculatedDistance = calculateDistance(
                    currentLocation["latitude"],
                    currentLocation["longitude"],
                    location["lat"],
                    location["lng"]);
                setState(() {
                  distanceOverlay = true;
                  distanceId = location["id"].toString();
                  distance =
                      num.parse(calculatedDistance.toStringAsFixed(2)).toInt();
                });
              }
            }));
      }
    }

    if (mounted) {
      locationSubscription.resume();
      setState(() {
        _markers = localMarkers;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Location().hasPermission(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return Stack(children: [
            GoogleMap(
              initialCameraPosition: !widget.withLocation
                  ? userLocation
                  : CameraPosition(
                      target: LatLng(locationPos.target.latitude,
                          locationPos.target.longitude),
                      zoom: 14.4746),
              onMapCreated: (GoogleMapController controller) {
                _customInfoWindowController.googleMapController = controller;
                _controller.complete(controller);
                generateMarkers();
              },
              markers: _markers!,
              onTap: (l) {
                setState(() {
                  distanceOverlay = false;
                  distanceId = "0";
                  distance = 0;
                });
                _customInfoWindowController.hideInfoWindow!();
              },
              onCameraMove: (position) {
                _customInfoWindowController.onCameraMove!();
              },
              // ),
              // floatingActionButton: FloatingActionButton.extended(
              //   onPressed: _goToTheLake,
              //   label: Text('To the lake!'),
              //   icon: Icon(Icons.directions_boat),
              // ),
            ),
            CustomInfoWindow(
              controller: _customInfoWindowController,
              height: 75,
              width: 150,
              offset: 50,
            ),
            distanceOverlay != true
                ? Container()
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 40,
                      width: 181,
                      margin: EdgeInsets.only(bottom: 16),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Center(
                          child: Text(
                        'От вас: ${distance} км.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 18),
                      )),
                    ))
          ]);
        });
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}

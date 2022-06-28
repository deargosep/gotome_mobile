import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gotome/utils/bitmap.dart';
import 'package:location/location.dart';

class GeoMap extends StatefulWidget {
  const GeoMap({
    Key? key,
    this.locations,
  }) : super(key: key);
  final List<geo.Location>? locations;
  @override
  State<GeoMap> createState() => GeoMapState();
}

class GeoMapState extends State<GeoMap> {
  Completer<GoogleMapController> _controller = Completer();
  var currentLocation = {};
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  @override
  void initState() {
    super.initState();
    setLocation();
  }

  void setLocation() async {
    Location _location = new Location();
    if (mounted)
      _location.onLocationChanged.listen((locationData) {
        setState(() {
          currentLocation = {
            "longitude": locationData.longitude,
            "latitude": locationData.latitude
          };
        });
        generateMarkers();
      });
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

  late final CameraPosition location = CameraPosition(
      target: LatLng(widget.locations?[0].latitude ?? _moscow.target.latitude,
          widget.locations?[0].longitude ?? _moscow.target.longitude),
      zoom: 14.4746);

  late final CameraPosition userLocation = CameraPosition(
      target: LatLng(currentLocation["latitude"] ?? _moscow.target.latitude,
          currentLocation["longitude"] ?? _moscow.target.longitude),
      zoom: 14.4746);

  Set<Marker>? _markers = <Marker>{};
  BitmapDescriptor? eventMarker;
  BitmapDescriptor? userMarker;

  void generateMarkers() async {
    var localMarkers = <Marker>{};

    var locationsList = [
      {
        "id": 123.2,
        "lat": location.target.latitude,
        "lng": location.target.longitude
      },
      {
        "id": "user",
        "lat": currentLocation["latitude"] ?? _moscow.target.latitude,
        "lng": currentLocation["longitude"] ?? _moscow.target.longitude
      }
    ];
    print(eventMarker != null ? 'YEssss' : 'Nooooo');

    for (var location in locationsList) {
      localMarkers.add(Marker(
          markerId: MarkerId(location["id"].toString()),
          position: LatLng(double.parse(location["lat"].toString()),
              double.parse(location["lng"]!.toString())),
          icon: location["id"] != "user"
              ? await bitmapDescriptorFromSvgAsset(
                  context, 'assets/icons/geo_user.svg')
              : await getMarkerIcon(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuIavvjuQFB38Se2ZNa0GkZ1Gol3C5OwioHA&usqp=CAU",
                  "JASSABELLE")));
    }

    if (mounted) {
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
          return GoogleMap(
            initialCameraPosition: widget.locations == null
                ? _moscow
                : CameraPosition(
                    target: LatLng(
                        currentLocation["latitude"] ?? _moscow.target.latitude,
                        currentLocation["longitude"] ??
                            _moscow.target.longitude),
                    zoom: 14.4746),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              generateMarkers();
            },
            markers: _markers!,
            // ),
            // floatingActionButton: FloatingActionButton.extended(
            //   onPressed: _goToTheLake,
            //   label: Text('To the lake!'),
            //   icon: Icon(Icons.directions_boat),
            // ),
          );
        });
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}

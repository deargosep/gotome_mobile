import 'dart:async';
import 'dart:ui';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gotome/state/filter.dart';
import 'package:gotome/utils/bitmap.dart';
import 'package:gotome/utils/calculate_distance.dart';
import 'package:gotome/utils/event.dart';
import 'package:gotome/widgets/images/brand_icon.dart';
import 'package:latlong2/latlong.dart' as l;
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class GeoMap extends StatefulWidget {
  const GeoMap({Key? key, this.selectedLocation, required this.dots})
      : super(key: key);
  final selectedLocation;
  final List<Dot> dots;
  @override
  State<GeoMap> createState() => GeoMapState();
}

class GeoMapState extends State<GeoMap> {
  late ClusterManager _manager;
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  var distanceOverlay = false;
  var distance = 0;
  var distanceId = "0";

  var currentGeo;

  late List<Dot> locations;

  Completer<GoogleMapController> _controller = Completer();
  Location location = new Location();
  late StreamSubscription<LocationData> locationSubscription;

  Set<Marker> markers = Set();

  late final CameraPosition _moscow = CameraPosition(
    target: LatLng(55.7558, 37.6173),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    locations = [
      ...widget.dots,
    ];
    _manager = _initClusterManager();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      locations =
          Provider.of<FiltersModel>(context, listen: false).filteredDots;
      print(locations);
      _manager.setItems(locations);
    });
    locationSubscription = location.onLocationChanged.listen((event) {
      if (currentGeo == LatLng(event.latitude!, event.longitude!)) return;
      // locations =
      //     Provider.of<FiltersModel>(context, listen: false).filteredDots;
      if (mounted) {
        setState(() {
          currentGeo = LatLng(event.latitude!, event.longitude!);
        });
        var newLocations =
            Provider.of<FiltersModel>(context, listen: false).filteredDots;
        _manager.setItems(newLocations);
        _updateUserMarker(l.LatLng(event.latitude!, event.longitude!));
      }
    });
  }

  @override
  void dispose() {
    if (!mounted) locationSubscription.cancel();
    _customInfoWindowController.dispose();
    super.dispose();
  }

  ClusterManager _initClusterManager() {
    return ClusterManager<Dot>(
      locations,
      _updateMarkers,
      markerBuilder: _markerBuilder,
    );
  }

  void _updateUserMarker(l.LatLng myGeo) {
    var localLocations =
        Provider.of<FiltersModel>(context, listen: false).filteredDots;
    var userEvent =
        Dot(isUser: true, id: "user", latLng: myGeo, locationString: "HotLine");
    var element =
        localLocations.firstWhereOrNull((element) => element.id == "user");
    if (element == null) {
      localLocations.add(userEvent);
    }
    if (element != null) {
      var index = localLocations.indexOf(element);
      localLocations[index] = userEvent;
    }
    _manager.setItems(localLocations);
    if (distanceId != "0") {
      var myLoc =
          localLocations.firstWhere((element) => element.id == distanceId);
      var calculatedDistance = calculateDistance(
          currentGeo.latitude,
          currentGeo.longitude,
          myLoc.location.latitude,
          myLoc.location.longitude);
      if (mounted)
        setState(() {
          distance = num.parse(calculatedDistance.toStringAsFixed(2)).toInt();
        });
    }
  }

  void _updateMarkers(
    Set<Marker> markers,
  ) async {
    print('Updated ${markers.length} markers');
    if (mounted) {
      // _customInfoWindowController.hideInfoWindow!();
      setState(() {
        this.markers = markers;
        // distanceOverlay = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PermissionStatus>(
        future: location.requestPermission(),
        builder: (context, snapshot) {
          return Stack(
            children: [
              FutureBuilder<LocationData>(
                future: location.getLocation(),
                builder: (context, secSnapshot) {
                  print(secSnapshot.data);
                  if (!secSnapshot.hasData &&
                      (snapshot.data == PermissionStatus.granted ||
                          snapshot.data == PermissionStatus.grantedLimited))
                    return Container();
                  return GoogleMap(
                      mapType: MapType.normal,
                      myLocationButtonEnabled: false,
                      initialCameraPosition: widget.selectedLocation != null
                          ? CameraPosition(
                              target: LatLng(widget.selectedLocation.latitude,
                                  widget.selectedLocation.longitude),
                              zoom: 10)
                          : snapshot.data == PermissionStatus.granted ||
                                  snapshot.data ==
                                      PermissionStatus.grantedLimited
                              ? CameraPosition(
                                  target: LatLng(
                                    secSnapshot.data!.latitude!,
                                    secSnapshot.data!.longitude!,
                                  ),
                                  zoom: 10)
                              : _moscow,
                      markers: markers,
                      onMapCreated: (GoogleMapController controller) {
                        _customInfoWindowController.googleMapController =
                            controller;
                        if (!_controller.isCompleted) {
                          _controller.complete(controller);
                        } else {}
                        _manager.setMapId(controller.mapId);
                        controller.animateCamera(CameraUpdate.newCameraPosition(
                            CameraPosition(
                                target: LatLng(secSnapshot.data!.latitude!,
                                    secSnapshot.data!.longitude!),
                                zoom: 10)));
                      },
                      onTap: (LatLng loc) {
                        setState(() {
                          distanceOverlay = false;
                        });
                        _customInfoWindowController.hideInfoWindow!();
                      },
                      onCameraMove: (position) {
                        _manager.onCameraMove(position);
                        _customInfoWindowController.onCameraMove!();
                      },
                      onCameraIdle: _manager.updateMap);
                },
              ),
              CustomInfoWindow(
                controller: _customInfoWindowController,
                height: 60,
                width: 171,
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
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Center(
                            child: Text(
                          'От вас: ${distance} км.',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 18),
                        )),
                      ))
            ],
          );
        });
    // floatingActionButton: FloatingActionButton(
    //   onPressed: () {
    //     _manager.setItems(<Event>[
    //       for (int i = 0; i < 30; i++)
    //         Event(
    //             id: "$i",
    //             name: 'New Place ${DateTime.now()} $i',
    //             latLng: LatLng(48.858265 + i * 0.01, 2.350107),
    //             datetime: DateTime.now().toString())
    //     ]);
    //   },
    //   child: Icon(Icons.update),
    // ),
  }

  Future<Marker> Function(Cluster<Dot>) get _markerBuilder => (cluster) async {
        List<dynamic> localList = [...cluster.items];
        Dot currentElement = localList.first;
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () {
            _customInfoWindowController.hideInfoWindow!();
            setState(() {
              distanceOverlay = false;
            });
            if (!cluster.isMultiple &&
                localList.firstWhere((element) => element.isUser,
                        orElse: () => null) ==
                    null &&
                localList.firstWhere(
                        (element) => element.location == cluster.location,
                        orElse: () => null) !=
                    null) {
              _customInfoWindowController.addInfoWindow!(
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 151,
                            child: Text(
                              cluster.items.first.name,
                              maxLines: 1,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              BrandIcon(
                                icon: 'clock',
                                height: 11,
                                width: 11,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                currentElement.datetime,
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
                  currentElement.location);
              if (currentGeo != null) {
                var calculatedDistance = calculateDistance(
                    currentGeo.latitude,
                    currentGeo.longitude,
                    currentElement.location.latitude,
                    currentElement.location.longitude);
                if (mounted)
                  setState(() {
                    distanceOverlay = true;
                    distanceId = currentElement.id.toString();
                    distance = num.parse(calculatedDistance.toStringAsFixed(2))
                        .toInt();
                  });
              }
            }
          },
          icon: !cluster.isMultiple &&
                  localList.firstWhere((el) => el.isUser, orElse: () => null) !=
                      null
              ? await getMarkerIcon(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuIavvjuQFB38Se2ZNa0GkZ1Gol3C5OwioHA&usqp=CAU",
                  context)
              : await _getMarkerBitmap(
                  cluster.isMultiple ? 125 : 75, cluster.isMultiple,
                  text: cluster.isMultiple ? cluster.count.toString() : null),
        );
      };

  Future<BitmapDescriptor> _getMarkerBitmap(int size, bool isMultiple,
      {String? text}) async {
    if (kIsWeb) size = (size / 2).floor();

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()
      ..color =
          Theme.of(context).primaryColor.withOpacity(isMultiple ? 0.65 : 0.25);
    final Paint paint2 = Paint()..color = Theme.of(context).primaryColor;

    final paint2Size = isMultiple ? 2.5 : 3.2;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / paint2Size, paint2);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 2,
            color: Colors.white,
            fontWeight: FontWeight.bold),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }
}

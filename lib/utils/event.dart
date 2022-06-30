import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Event with ClusterItem {
  final String id;
  final bool isUser;
  final String name;
  final String datetime;
  final LatLng latLng;

  Event(
      {this.id = '',
      this.isUser = false,
      this.name = '',
      this.datetime = '',
      required this.latLng});

  @override
  String toString() {
    return 'Place $name';
  }

  Future<LatLng> getLocation() async {
    Location location = new Location();
    LatLng coords = LatLng(0, 0);
    var locationData = await location.getLocation();
    coords = LatLng(locationData.latitude!, locationData.longitude!);
    return coords;
  }

  @override
  LatLng get location => latLng;
  Future<LatLng> get myLocation => getLocation();
}

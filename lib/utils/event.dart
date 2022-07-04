import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as l;

class Dot with ClusterItem {
  final String id;
  final bool isUser;
  final String name;
  final String country;
  final String city;
  final String datetime;
  final date;
  List<String> tags;
  final String locationString;
  final l.LatLng latLng;
  final gender;

  Dot(
      {this.id = '',
      this.isUser = false,
      this.name = '',
      this.country = '',
      this.city = '',
      this.datetime = '',
      this.date = '',
      List<String>? tags,
      required this.latLng,
      required this.locationString,
      this.gender = 'none'})
      : tags = tags ?? [];

  @override
  String toString() {
    return 'Place $name';
  }

  @override
  LatLng get location => LatLng(latLng.latitude, latLng.longitude);
}

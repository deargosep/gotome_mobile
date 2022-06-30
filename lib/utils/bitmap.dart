import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui'
    as ui; // imported as ui to prevent conflict between ui.Image and the Image widget

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> bitmapDescriptorFromSvgAsset(
    BuildContext context, String assetName) async {
  // Read SVG file as String
  String svgString = await DefaultAssetBundle.of(context).loadString(assetName);
  // Create DrawableRoot from SVG String
  DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, 'key');

  // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
  MediaQueryData queryData = MediaQuery.of(context);
  double devicePixelRatio = queryData.devicePixelRatio;
  double width = 32 * devicePixelRatio; // where 32 is your SVG's original width
  double height = 32 * devicePixelRatio; // same thing

  // Convert to ui.Picture
  ui.Picture picture = svgDrawableRoot.toPicture(size: Size(width, height));

  // Convert to ui.Image. toImage() takes width and height as parameters
  // you need to find the best size to suit your needs and take into account the
  // screen DPI
  ui.Image image = await picture.toImage(width.toInt(), height.toInt());
  ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
}

late BitmapDescriptor customIcon;
Future<BitmapDescriptor> createCustomMarkerBitmapWithNameAndImage(
    String imagePath, Size size, context) async {
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
        Rect.fromLTWH(size.width / 8, size.width / 2, size.width, size.height),
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
      shadowCirclePaint);

  Rect oval = Rect.fromLTWH(
      35, 78, size.width - (imageOffset * 2), size.height - (imageOffset * 2));

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

Future<BitmapDescriptor> getMarkerIcon(String image, context) async {
  if (image != null) {
    final File markerImageFile =
        await DefaultCacheManager().getSingleFile(image);
    Size s = Size(120, 120);

    var icon = await createCustomMarkerBitmapWithNameAndImage(
        markerImageFile.path, s, context);
    return icon;
  } else {
    return BitmapDescriptor.defaultMarker;
  }
}

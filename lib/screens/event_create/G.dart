import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/bottom_panel.dart';
import 'package:gotome/widgets/brand_button.dart';
import 'package:gotome/widgets/header.dart';
import 'package:gotome/widgets/images/brand_icon.dart';

class GCEScreen extends StatefulWidget {
  const GCEScreen({Key? key}) : super(key: key);

  @override
  State<GCEScreen> createState() => _GCEScreenState();
}

class _GCEScreenState extends State<GCEScreen> {
  final prevData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        onlyTopPadding: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
              text: 'Создать событие',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    'Добавьте фото события',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    height: 132,
                    width: double.maxFinite,
                    padding:
                        EdgeInsets.symmetric(horizontal: 133, vertical: 28),
                    decoration: BoxDecoration(
                        color: Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: BrandIcon(icon: 'upload'),
                  )
                ],
              ),
            ),
            Spacer(),
            BottomPanel(
                child: BrandButton(
              text: 'Опубликовать',
              onPressed: () {
                //TODO: upload event
                //
                // ----
                Get.offAllNamed(
                  '/bar',
                  //     arguments: {
                  //   "image": '', ...prevData
                  // }
                );
              },
            ))
          ],
        ));
  }
}

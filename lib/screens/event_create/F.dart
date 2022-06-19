import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/bottom_panel.dart';
import 'package:gotome/widgets/brand_button.dart';
import 'package:gotome/widgets/header.dart';
import 'package:gotome/widgets/input.dart';

class FCEScreen extends StatefulWidget {
  const FCEScreen({Key? key}) : super(key: key);

  @override
  State<FCEScreen> createState() => _FCEScreenState();
}

class _FCEScreenState extends State<FCEScreen> {
  final prevData = Get.arguments;
  var description = '';
  TextEditingController controller = TextEditingController();

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
                    'Укажите описание',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Theme.of(context).accentColor),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Input(
                    label: 'Описание',
                    onChanged: (text) {
                      setState(() {
                        description = text;
                      });
                    },
                  ),
                ],
              ),
            ),
            Spacer(),
            BottomPanel(
                child: BrandButton(
              text: 'Далее',
              onPressed: () {
                Get.toNamed('/event/create/7',
                    arguments: {"description": description, ...prevData});
              },
            ))
          ],
        ));
  }
}

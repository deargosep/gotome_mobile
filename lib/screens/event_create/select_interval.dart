import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/bottom_panel.dart';
import 'package:gotome/widgets/brand_button.dart';
import 'package:gotome/widgets/header.dart';
import 'package:gotome/widgets/input.dart';

class SelectIntervalScreen extends StatefulWidget {
  const SelectIntervalScreen({Key? key}) : super(key: key);

  @override
  State<SelectIntervalScreen> createState() => _SelectIntervalScreenState();
}

class _SelectIntervalScreenState extends State<SelectIntervalScreen> {
  final prevData = Get.arguments;
  final TextEditingController intervalStart = TextEditingController();
  final TextEditingController intervalEnd = TextEditingController();

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
                    'Укажите дату проведения',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Input(
                    icon: 'calendar',
                    label: 'Начало проведения',
                    controller: intervalStart,
                    onTapCalendar: (text) {
                      intervalStart.text = text;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Input(
                    icon: 'calendar',
                    label: 'Окончание проведения',
                    controller: intervalEnd,
                    onTapCalendar: (text) {
                      intervalEnd.text = text;
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
                Get.toNamed('/event/create/5', arguments: {
                  "selectedDateInterval": {
                    "intervalStart": intervalStart.text,
                    "intervalEnd": intervalEnd.text
                  },
                  ...prevData
                });
              },
            ))
          ],
        ));
  }
}

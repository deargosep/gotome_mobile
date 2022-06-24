import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/bottom_panel.dart';
import 'package:gotome/widgets/brand_button.dart';
import 'package:gotome/widgets/header.dart';
import 'package:gotome/widgets/input.dart';

class SelectDateScreen extends StatefulWidget {
  const SelectDateScreen({Key? key}) : super(key: key);

  @override
  State<SelectDateScreen> createState() => _SelectDateScreenState();
}

class _SelectDateScreenState extends State<SelectDateScreen> {
  final prevData = Get.arguments;
  TextEditingController date = TextEditingController();

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
                    label: 'Дата',
                    controller: date,
                    onTapCalendar: (text) {
                      date.text = text;
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
                Get.toNamed('/event/create/5',
                    arguments: {"selectedDatePrecise": date.text, ...prevData});
              },
            ))
          ],
        ));
  }
}

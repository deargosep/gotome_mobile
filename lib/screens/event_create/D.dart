import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/bottom_panel.dart';
import 'package:gotome/widgets/brand_button.dart';
import 'package:gotome/widgets/header.dart';
import 'package:gotome/widgets/select_list.dart';

class DCEScreen extends StatefulWidget {
  const DCEScreen({Key? key}) : super(key: key);

  @override
  State<DCEScreen> createState() => _DCEScreenState();
}

class _DCEScreenState extends State<DCEScreen> {
  var selectedDate = 'none';

  void changeGender(newState) {
    setState(() {
      selectedDate = newState;
    });
  }

  var items = {
    "Бессрочное": 'none',
    "Интервал": 'interval',
    "Конкретная дата": 'date',
  };

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
                    'Укажите дату проведения',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Theme.of(context).accentColor),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SelectList(
                    onChange: changeGender,
                    value: selectedDate,
                    items: items,
                  ),
                ],
              ),
            ),
            Spacer(),
            BottomPanel(
                child: BrandButton(
              text: 'Далее',
              onPressed: () {
                Get.toNamed(
                    selectedDate == 'date'
                        ? '/event/create/select_date'
                        : selectedDate == 'interval'
                            ? '/event/create/select_interval'
                            : '/event/create/5',
                    arguments: {"selectedDate": selectedDate, ...prevData});
              },
            ))
          ],
        ));
  }
}

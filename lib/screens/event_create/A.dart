import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/bottom_panel.dart';
import 'package:gotome/widgets/brand_button.dart';
import 'package:gotome/widgets/checkboxes_list.dart';
import 'package:gotome/widgets/header.dart';

class ACEScreen extends StatefulWidget {
  const ACEScreen({Key? key}) : super(key: key);

  @override
  State<ACEScreen> createState() => _ACEScreenState();
}

class _ACEScreenState extends State<ACEScreen> {
  Map<String, bool> checkboxes = {
    'Активный отдых': true,
    'Спорт': false,
    'Кино': false,
    'Концерт': false,
    'Культура': false,
    'Образование': true,
    'Прогулка': false,
    'Клуб/бар/тусовка': false,
    'Игра/квест': false,
    'Путешествия': false,
    'Аренда': false,
    'Экскурсия': false,
  };

  void changeCheckboxesState(newState) {
    setState(() {
      checkboxes = newState;
    });
  }

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
                    'Укажите категорию',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  CheckboxesList(
                      checkboxes: checkboxes,
                      changeCheckbox: changeCheckboxesState),
                ],
              ),
            ),
            Spacer(),
            BottomPanel(
                child: BrandButton(
              text: 'Далее',
              onPressed: () {
                Get.toNamed('/event/create/2', arguments: checkboxes);
              },
            ))
          ],
        ));
  }
}

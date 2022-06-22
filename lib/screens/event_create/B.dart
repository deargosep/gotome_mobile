import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/bottom_panel.dart';
import 'package:gotome/widgets/brand_button.dart';
import 'package:gotome/widgets/header.dart';
import 'package:gotome/widgets/select_list.dart';

class BCEScreen extends StatefulWidget {
  const BCEScreen({Key? key}) : super(key: key);

  @override
  State<BCEScreen> createState() => _BCEScreenState();
}

class _BCEScreenState extends State<BCEScreen> {
  var selectedGender = 'none';

  void changeGender(newState) {
    setState(() {
      selectedGender = newState;
    });
  }

  var items = {
    "Мужской": 'male',
    "Женский": 'female',
    "Не имеет значения": 'none',
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
                    'Укажите пол соискателей',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SelectList(
                      onChange: changeGender,
                      value: selectedGender,
                      items: items),
                ],
              ),
            ),
            Spacer(),
            BottomPanel(
                child: BrandButton(
              text: 'Далее',
              onPressed: () {
                Get.toNamed('/event/create/3',
                    arguments: {"selectedGender": selectedGender, ...prevData});
              },
            ))
          ],
        ));
  }
}

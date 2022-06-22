import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/bottom_panel.dart';
import 'package:gotome/widgets/brand_button.dart';
import 'package:gotome/widgets/checkboxes_list.dart';
import 'package:gotome/widgets/header.dart';
import 'package:gotome/widgets/input.dart';
import 'package:gotome/widgets/select_list.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var checkedGender = 'none';
  void selectGender(gender) {
    setState(() {
      checkedGender = gender;
    });
  }

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
    var items = {
      "Мужской": 'male',
      "Женский": 'female',
      "Не имеет значения": 'none',
    };
    return CustomScaffold(
        noPadding: true,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                children: [
                  Header(
                    withPadding: false,
                    text: 'Фильтр',
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Input(
                    label: 'Страна',
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Input(
                    label: 'Город',
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Input(
                    label: 'Дата проведения',
                    icon: 'calendar',
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    'Пол соискателей',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SelectList(
                      value: checkedGender,
                      onChange: selectGender,
                      items: items),
                  SizedBox(
                    height: 32,
                  ),
                  CheckboxesList(
                    checkboxes: checkboxes,
                    changeCheckbox: changeCheckboxesState,
                  ),
                  SizedBox(
                    height: 23,
                  ),
                ],
              ),
            ),
            BottomPanel(
              child: BrandButton(
                text: 'Применить',
                onPressed: () {
                  Get.back();
                },
              ),
            )
          ],
        ));
  }
}

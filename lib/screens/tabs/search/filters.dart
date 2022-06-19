import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/brand_checkbox_listtile.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/bottom_panel.dart';
import 'package:gotome/widgets/brand_button.dart';
import 'package:gotome/widgets/brand_select.dart';
import 'package:gotome/widgets/header.dart';
import 'package:gotome/widgets/input.dart';

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
                  _Genders(
                    checkedGender: checkedGender,
                    changeGender: selectGender,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  _Categories(
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
              child: BrandButton(text: 'Применить', onPressed: (){Get.back();},),
            )
          ],
        ));
  }
}

class _Genders extends StatelessWidget {
  const _Genders(
      {Key? key, required this.changeGender, required this.checkedGender})
      : super(key: key);
  final changeGender;
  final checkedGender;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Пол соискателей',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Theme.of(context).accentColor),
        ),
        SizedBox(
          height: 24,
        ),
        GestureDetector(
          onTap: () {
            changeGender('male');
          },
          child: Row(
            children: [
              BrandSelect(
                  setState: () {
                    changeGender('male');
                  },
                  checked: checkedGender == 'male'),
              SizedBox(
                width: 10,
              ),
              Text(
                'Мужской',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6A7592),
                    fontSize: 14),
              )
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),
        GestureDetector(
          onTap: () {
            changeGender('female');
          },
          child: Row(
            children: [
              BrandSelect(
                  setState: () {
                    changeGender('female');
                  },
                  checked: checkedGender == 'female'),
              SizedBox(
                width: 10,
              ),
              Text(
                'Женский',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6A7592),
                    fontSize: 14),
              )
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),
        GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              BrandSelect(
                  setState: () {
                    changeGender('female');
                  },
                  checked: checkedGender == 'none'),
              SizedBox(
                width: 10,
              ),
              Text(
                'Не имеет значения',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6A7592),
                    fontSize: 14),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _Categories extends StatelessWidget {
  const _Categories(
      {Key? key, required this.checkboxes, required this.changeCheckbox})
      : super(key: key);
  final Map<String, bool> checkboxes;
  final changeCheckbox;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Категории',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Theme.of(context).accentColor),
        ),
        SizedBox(
          height: 24,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: checkboxes.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  BrandCheckboxListTile(
                      title: checkboxes.keys.elementAt(index),
                      value: checkboxes.values.elementAt(index),
                      onChanged: (val) {
                        var localCheckboxes = {...checkboxes};
                        localCheckboxes.update(
                            checkboxes.keys.elementAt(index), (value) => val);
                        changeCheckbox(localCheckboxes);
                      }),
                  SizedBox(
                    height: 16,
                  )
                ],
              );
            })
      ],
    );
  }
}

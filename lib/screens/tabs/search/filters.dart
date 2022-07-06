import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/brand_checkbox_listtile.dart';
import 'package:gotome/state/filter.dart';
import 'package:gotome/state/user.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/bottom_panel.dart';
import 'package:gotome/widgets/brand_button.dart';
import 'package:gotome/widgets/header.dart';
import 'package:gotome/widgets/input.dart';
import 'package:gotome/widgets/select_list.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  TextEditingController countryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  var checkedGender = 'none';
  @override
  void initState() {
    super.initState();
    checkedGender =
        Provider.of<FiltersModel>(context, listen: false).meta.gender;
    countryController.text =
        Provider.of<User>(context, listen: false).user.country;
    cityController.text = Provider.of<User>(context, listen: false).user.city;
    // dateController.text =
    //     '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}';
  }

  List<String> checkboxes = [
    'Активный отдых',
    'Спорт',
    'Кино',
    'Концерт',
    'Культура',
    'Образование',
    'Прогулка',
    'Клуб/бар/тусовка',
    'Игра/квест',
    'Путешествия',
    'Аренда',
    'Экскурсия'
  ];

  List<String> checkboxesList = [];

  void selectGender(gender) {
    setState(() {
      checkedGender = gender;
    });
  }

  void changeCheckboxesState(List<String> newCheckboxesState) {
    List<String> newCheckboxesList = [];
    newCheckboxesState.forEach((value) {
      checkboxesList.add(value);
    });
    setState(() {
      checkboxes = newCheckboxesState;
      checkboxesList = newCheckboxesList;
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
        appBar: AppHeader(
          text: 'Фильтр',
          onTap: () {
            Provider.of<FiltersModel>(context, listen: false).setFilters([]);
            Provider.of<FiltersModel>(context, listen: false).setMeta(Meta());
          },
        ),
        bottomNavigationBar: BottomPanel(
          child: BrandButton(
            text: 'Применить',
            onPressed: () {
              Meta meta = Meta(
                  city: cityController.text,
                  date: dateController.text,
                  gender: checkedGender,
                  country: countryController.text);
              // DIsabled because setting is done already
              // Provider.of<FiltersModel>(context, listen: false)
              //     .setFilters(checkboxesList);
              Provider.of<FiltersModel>(context, listen: false).setMeta(meta);
              Get.arguments();
              Get.back();
            },
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 32,
                  ),
                  Input(
                    label: 'Страна',
                    controller: countryController,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Input(
                    label: 'Город',
                    controller: cityController,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Input(
                    label: 'Дата проведения',
                    icon: 'calendar',
                    controller: dateController,
                    onTapCalendar: (text) {
                      dateController.text = text;
                    },
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
                  Text(
                    'Категории',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  _CheckboxesList(
                    checkboxes: checkboxes,
                    changeCheckbox: changeCheckboxesState,
                  ),
                  SizedBox(
                    height: 23,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class _CheckboxesList extends StatelessWidget {
  const _CheckboxesList(
      {Key? key, required this.checkboxes, required this.changeCheckbox})
      : super(key: key);
  final List<String> checkboxes;
  final changeCheckbox;
  @override
  Widget build(BuildContext context) {
    var enabledCheckboxes = Provider.of<FiltersModel>(context).categories;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: checkboxes.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  BrandCheckboxListTile(
                      title: checkboxes.elementAt(index),
                      value: enabledCheckboxes
                          .contains(checkboxes.elementAt(index)),
                      onChanged: (title, val) {
                        var localCheckboxes = [...enabledCheckboxes];
                        if (val != false)
                          localCheckboxes.add(title);
                        else
                          localCheckboxes.remove(title);
                        Provider.of<FiltersModel>(context, listen: false)
                            .setFilters(localCheckboxes);
                        // localCheckboxes.update(
                        //     checkboxes.keys.elementAt(index), (value) => val);
                        // changeCheckbox(localCheckboxes);
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

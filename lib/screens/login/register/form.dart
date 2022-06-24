import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/brand_button.dart';
import 'package:gotome/widgets/brand_checkbox.dart';
import 'package:gotome/widgets/images/brand_icon.dart';
import 'package:gotome/widgets/input.dart';

class RegisterFormScreen extends StatefulWidget {
  const RegisterFormScreen({Key? key}) : super(key: key);

  @override
  State<RegisterFormScreen> createState() => _RegisterFormScreenState();
}

class _RegisterFormScreenState extends State<RegisterFormScreen> {
  bool checked = false;
  TextEditingController birthday = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void check() {
      setState(() {
        checked = !checked;
      });
    }

    return CustomScaffold(
        scrollable: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: BrandIcon(icon: 'back_arrow')),
                    Spacer(),
                    Container(
                      width: 154,
                      child: Text(
                        'Пожалуйста, заполните анкету',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Spacer()
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                Input(
                  label: 'Имя',
                ),
                SizedBox(
                  height: 16,
                ),
                Input(
                  label: 'Пол',
                ),
                SizedBox(
                  height: 16,
                ),
                Input(
                  icon: 'calendar',
                  label: 'Дата рождения',
                  controller: birthday,
                  onTapCalendar: (text) {
                    birthday.text = text;
                  },
                ),
                SizedBox(
                  height: 16,
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
                  expanded: true,
                  label: 'Немного о себе',
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    BrandCheckbox(
                      checked: checked,
                      onChanged: check,
                    ),
                    SizedBox(
                      width: 13,
                    ),
                    Container(
                      width: 294,
                      child: Text(
                        'Я даю согласие на обработку своих персональных данных',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ],
            ),
            BrandButton(
              onPressed: () {
                if (checked) Get.offAllNamed('/');
              },
              text: 'Продолжить',
              type: 'primary',
            ),
          ],
        ));
  }
}

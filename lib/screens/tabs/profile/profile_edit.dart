import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/bottom_panel.dart';
import 'package:gotome/widgets/brand_button.dart';
import 'package:gotome/widgets/header.dart';
import 'package:gotome/widgets/input.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Get.arguments;
    return CustomScaffold(
      noPadding: true,
      scrollable: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Column(
              children: [
                Header(
                  withPadding: false,
                  text: "Редактирование анкеты",
                ),
                SizedBox(
                  height: 33,
                ),
                Row(
                  children: [
                    Container(
                      height: 91,
                      width: 91,
                      child: CircleAvatar(),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user["username"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Theme.of(context).accentColor),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Дата регистрации: ${user["registration_date"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color(0xFF6A7592)),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                SizedBox(
                  height: 32,
                ),
                Input(
                  defaultText: user["name"],
                ),
                SizedBox(
                  height: 16,
                ),
                Input(
                  defaultText: user["gender"],
                ),
                SizedBox(
                  height: 16,
                ),
                Input(
                  icon: 'calendar',
                  defaultText: user["birthday"],
                ),
                SizedBox(
                  height: 16,
                ),
                Input(
                  defaultText: user["country"],
                ),
                SizedBox(
                  height: 16,
                ),
                Input(
                  defaultText: user["city"],
                ),
                SizedBox(
                  height: 16,
                ),
                Input(
                  expanded: true,
                  defaultText: user["description"],
                ),
              ],
            ),
          ),
          BottomPanel(
            child: BrandButton(
              onPressed: (){Get.back();},
                text: 'Применить'),
          )
        ],
      ),
    );
  }
}

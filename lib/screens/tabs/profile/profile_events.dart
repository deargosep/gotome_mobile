import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/screens/profile_other.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/header.dart';

class ProfileEventsScreen extends StatelessWidget {
  const ProfileEventsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var user = Get.arguments;
    return CustomScaffold(
      noPadding: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Column(
              children: [
                Header(
                  withPadding: false,
                  text: "Мои мероприятия",
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
                              color: Theme.of(context).colorScheme.secondary),
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
          SizedBox(
            height: 32,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: History(fromMyProfile: true),
            ),
          )
        ],
      ),
    );
  }
}

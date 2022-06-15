import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/brand_button.dart';
import 'package:gotome/widgets/header.dart';
import 'package:gotome/widgets/images/brand_icon.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Map user = {
      "username": "HotLine",
      "registration_date": "03.06.2022",
      "is_subscribed": true,
      "name": "Игорь",
      "age": 24,
      "country": "Россия",
      "city": "Москва",
      "description":
          "С другой стороны, экономическая повестка сегодняшнего дня предоставляет широкие возможности для существующих финансовых и административных условий.",
    };
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
                  withBack: false,
                  text: "Мой профиль",
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
                ListOfOptions(),
                SizedBox(
                  height: 32,
                ),
                InkWell(
                  onTap: () {
                    //  TODO: logout
                  },
                  child: Text(
                    'Выйти из профиля',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ListOfOptions extends StatelessWidget {
  const ListOfOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Option(
          text: "Моя анкета",
          onTap: () {
            Get.toNamed('/profile/info');
          },
        ),
        SizedBox(
          height: 16,
        ),
        Option(
          text: "Мои события",
          onTap: () {},
        ),
        SizedBox(
          height: 16,
        ),
        Option(
          text: "Поддержка",
          onTap: () {},
        ),
        SizedBox(
          height: 32,
        ),
        BrandButton(
          text: 'Подписка',
          type: 'primary',
          textAlign: 'left',
          textStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
        )
      ],
    );
  }
}

class Option extends StatefulWidget {
  const Option({Key? key, required this.text, this.onTap}) : super(key: key);
  final text;
  final onTap;

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  var pressing = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (dt) {
        setState(() {
          pressing = false;
        });
      },
      onTapDown: (dt) {
        setState(() {
          pressing = true;
        });
      },
      onTapCancel: () {
        setState(() {
          pressing = false;
        });
      },
      onTap: widget.onTap,
      child: Container(
        height: 50,
        padding: EdgeInsets.fromLTRB(20, 16.5, 20, 16.5),
        decoration: BoxDecoration(
          color: pressing ? Color(0xFFE4E6EB) : Color(0xFFF8F8F8),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.text ?? '',
              style: TextStyle(
                  color: Color(0xFF6A7592),
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            BrandIcon(
              icon: 'right_arrow',
              color: Color(0xFF6A7592),
              height: 14,
              width: 8,
            )
          ],
        ),
      ),
    );
  }
}

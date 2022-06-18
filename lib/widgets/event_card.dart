import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/widgets/images/brand_icon.dart';

class EventCard extends StatelessWidget {
  const EventCard({Key? key, this.item}) : super(key: key);
  final item;
  @override
  Widget build(BuildContext context) {
    const defaultItem = {
      "id": "123adssdad",
      "author": "HotLine",
      "authorId": "12222",
      "author_role": "Организатор",
      "author_info": {
        "author_name": "Игорь",
        "author_username": "HotLine",
        "author_age": 24,
        "author_country": "Россия",
        "author_city": "Москва",
        "author_description":
            "С другой стороны, экономическая повестка сегодняшнего дня предоставляет широкие возможности для существующих финансовых и административных условий.",
      },
      "name": "Катаемся на велосипедах",
      "timedate": "03.06.2022 в 15:00",
      "location": "Наб. Реки Фонтанки, 3",
      "description":
          "Приглашаем тебя покататься с нами по городу! Компания веселая! Обещаем, что будет весело, ждем тебя с нетерпением!!!",
      "price": "Бесплатно",
      "members": [
        {"username": "MajEstic21"},
        {"username": "Alice18"},
        {"username": "Pavkl"},
        {"username": "ForJik"},
      ],
    };
    // Map getItem() {
    // if (item == null) {
    //   return defaultItem;
    // } else {
    //   return item;
    // }
    // }

    final Map usedItem = defaultItem;
    return Material(
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        onTap: () {
          Get.toNamed('/event', arguments: usedItem);
        },
        child: Container(
          height: 335,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 10),
              )
            ],
          ),
          child: Column(
            children: [
              // Header
              GestureDetector(
                onTap: () {
                  Get.toNamed('/profile_others',
                      arguments: usedItem["authorId"]);
                },
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed('/profile_others',
                        arguments: usedItem["author_info"]);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Container(
                        height: 41,
                        width: 41,
                        child: CircleAvatar(
                            //  IMAGE URL FROM $item
                            ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            usedItem["author"],
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            usedItem["author_role"],
                            style: TextStyle(
                                color: Color(0xFF9FA6BA),
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              // Image cover
              Container(
                height: 132,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ), // TODO: should be an Image (backend)
              // meta info
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        usedItem['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Theme.of(context).accentColor),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        BrandIcon(icon: 'clock'),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          usedItem["timedate"],
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).accentColor),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        BrandIcon(icon: 'geo'),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          usedItem["location"],
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).accentColor),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              // description
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Text(
                  "${usedItem["description"].toString().substring(0, 108)}...",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6A7592)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/widgets/bottom_panel.dart';
import 'package:gotome/widgets/brand_button.dart';
import 'package:gotome/widgets/images/brand_icon.dart';

class EventScreen extends StatelessWidget {
  EventScreen({Key? key}) : super(key: key);
  final Map item = Get.arguments;
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      bottomNavigationBar: BottomPanel(
        height: item["author"] == 'HotLine' ? 146.0 : 83.0,
        child: item["author"] == 'HotLine'
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BrandButton(
                    text: 'Список желающих',
                    type: 'primary',
                    onPressed: () {
                      var localItem = {...item};
                      localItem["isOwner"] = true;
                      Get.toNamed('/members', arguments: localItem);
                    },
                  ),
                  BrandButton(
                    text: 'Редактировать событие',
                    type: 'secondary',
                  )
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BrandButton(
                    text: 'Откликнуться',
                    type: 'primary',
                    width: 161.0,
                  ),
                  BrandButton(
                    text: 'Поделиться',
                    type: 'secondary',
                    width: 161.0,
                  )
                ],
              ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 197,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    20, 38 + MediaQuery.of(context).viewInsets.top, 0, 0),
                child: BrandIcon(
                  icon: 'back_arrow',
                  color: Colors.white,
                ),
              ),
            ],
          ),
          // meta info
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item['name'] ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          BrandIcon(
                            icon: 'clock',
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            item["timedate"] ?? "",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.secondary),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BrandIcon(
                            icon: 'geo',
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["location"] ?? "",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed('/search/map',
                                      arguments: item["location"]);
                                },
                                child: Text(
                                  'Смотреть на карте',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Theme.of(context).primaryColor),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          BrandIcon(
                            icon: 'payment',
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            item["price"] ?? "",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.secondary),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                // Description
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 32, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Описание',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        item['description'],
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFF6A7592)),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 32, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Участники',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      // TODO: should be an image
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/profile_others',
                              arguments: item["author_info"]);
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              child: CircleAvatar(),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["author"]!,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  item["author_role"]!,
                                  style: TextStyle(
                                      color: Color(0xFF9FA6BA), fontSize: 14),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 70,
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.black,
                                    ),
                                    Positioned(
                                      left: 20,
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.blue,
                                      ),
                                    ),
                                    Positioned(
                                      left: 40,
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '+1',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColor),
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed('/members', arguments: item);
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Все участники',
                                  style: TextStyle(
                                      color: Color(0xFF9FA6BA),
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                BrandIcon(icon: 'right_arrow')
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

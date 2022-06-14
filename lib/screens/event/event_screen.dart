import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/widgets/brand_button.dart';
import 'package:gotome/widgets/images/brand_icon.dart';

class EventScreen extends StatelessWidget {
  EventScreen({Key? key}) : super(key: key);
  final item = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomPanel(),
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
                              color: Theme.of(context).accentColor),
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
                                color: Theme.of(context).accentColor),
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
                                    color: Theme.of(context).accentColor),
                              ),
                              InkWell(
                                onTap: () {},
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
                                color: Theme.of(context).accentColor),
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
                                      color: Theme.of(context).accentColor,
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
                              Get.toNamed('/event/members', arguments: item);
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

class BottomPanel extends StatelessWidget {
  const BottomPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.07),
            spreadRadius: 8,
            blurRadius: 15,
            offset: Offset(0, 8),
          )
        ]),
        width: MediaQuery.of(context).size.width,
        height: 83,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BrandButton(
                text: 'Откликнуться',
                type: 'primary',
                width: 161,
              ),
              BrandButton(
                text: 'Поделиться',
                type: 'secondary',
                width: 161,
              )
            ],
          ),
        ));
  }
}

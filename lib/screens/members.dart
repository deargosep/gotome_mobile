import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gotome/widgets/header.dart';
import 'package:gotome/widgets/images/brand_icon.dart';

class MembersScreen extends StatelessWidget {
  MembersScreen({Key? key}) : super(key: key);
  final item = Get.arguments;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    if (item == null) return Scaffold();
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.fromLTRB(
          0, 38 + MediaQuery.of(context).viewInsets.top, 0, 0),
      child: Column(
        children: [
          Header(
            text: item["isChat"] == true
                ? 'Участники чата'
                : 'Список ${item["isOwner"] ? "желающих" : "участников"}',
          ),
          Expanded(
            child: ListView.builder(
              itemCount: item["members"].length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // TODO: image (backend)
                          Row(
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                child: CircleAvatar(),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                item["members"][index]["username"],
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ],
                          ),
                          Builder(builder: (context) {
                            if (!item["isOwner"]) return Container();
                            return Row(
                              children: [
                                BrandIcon(icon: 'accept'),
                                SizedBox(
                                  width: 20,
                                ),
                                BrandIcon(icon: 'decline')
                              ],
                            );
                          })
                        ],
                      ),
                    ),
                    Divider()
                  ],
                );
              },
            ),
          )
        ],
      ),
    ));
  }
}

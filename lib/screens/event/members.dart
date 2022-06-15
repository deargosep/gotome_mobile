import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gotome/widgets/header_title.dart';

class EventMembersScreen extends StatelessWidget {
  EventMembersScreen({Key? key}) : super(key: key);
  final item = Get.arguments;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.fromLTRB(
          0, 38 + MediaQuery.of(context).viewInsets.top, 0, 0),
      child: Column(
        children: [
          Header(
            text: 'Список участников',
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
                        children: [
                          // TODO: image (backend)
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
                          )
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

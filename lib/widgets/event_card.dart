import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/widgets/images/brand_icon.dart';

class EventCard extends StatelessWidget {
  const EventCard({Key? key, required this.item}) : super(key: key);
  final Map<String, dynamic> item;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        onTap: () {
          Get.toNamed('/event', arguments: item);
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
              Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  CircleAvatar(
                      //  IMAGE URL FROM $item
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
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        item["author_role"]!,
                        style: TextStyle(
                            color: Color(0xFF9FA6BA),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  )
                ],
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
                        item['name'] ?? "",
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
                      children: [
                        BrandIcon(icon: 'geo'),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          item["location"] ?? "",
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
                  "${item["description"].toString().substring(0, 108)}...",
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/state/events.dart';
import 'package:gotome/widgets/images/brand_icon.dart';

class EventCard extends StatelessWidget {
  const EventCard({Key? key, required this.item}) : super(key: key);
  final EventType item;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/event', arguments: item);
      },
      child: Container(
        height: 335,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
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
                Get.toNamed('/profile_others', arguments: item.author);
              },
              child: GestureDetector(
                onTap: () {
                  Get.toNamed('/profile_others', arguments: item.author);
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
                          item.author.username,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Организатор",
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
                      item.name,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.secondary),
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
                        item.timedate,
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
                    children: [
                      BrandIcon(icon: 'geo'),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        item.location,
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
            // description
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Text(
                "${item.description.toString().substring(0, 108)}...",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6A7592)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

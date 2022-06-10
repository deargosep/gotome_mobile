import 'package:flutter/material.dart';
import 'package:gotome/widgets/images/brand_icon.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white);
    const textStyleBold = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white);
    return Column(
      children: [
        // Header
        Container(
          height: 76 +  MediaQuery.of(context).viewPadding.top,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(16, 16 +  MediaQuery.of(context).viewPadding.top, 16, 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              color: Theme.of(context).primaryColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'События в городе',
                style: textStyle,
              ),
              Text(
                'Москва',
                style: textStyleBold,
              )
            ],
          ),
        ),
        // List
        Expanded(
            child: Content(list: [
          {
            "item": 1,
            "author": "HotLine",
            "author_role": "Организатор",
            "name": "Катаемся на велосипедах",
            "timedate": "03.06.2022 в 15:00",
            "location": "Наб. Реки Фонтанки, 3",
            "description":
                "Приглашаем тебя покататься с нами по городу! Компания веселая! Обещаем, что будет весело, ждем тебя с нетерпением!!!"
          },
          {
            "item": 1,
            "author": "HotLine",
            "author_role": "Организатор",
            "name": "Катаемся на велосипедах",
            "timedate": "03.06.2022 в 15:00",
            "location": "Наб. Реки Фонтанки, 3",
            "description":
                "Приглашаем тебя покататься с нами по городу! Компания веселая! Обещаем, что будет весело, ждем тебя с нетерпением!!!"
          }
        ]))
      ],
    );
  }
}

class Content extends StatelessWidget {
  Content({Key? key, required List<Map> this.list}) : super(key: key);
  List list;
  @override
  Widget build(BuildContext context) {
    if (list.isNotEmpty) {
      return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: EventCard(item: list[index]),
            );
          });
    }
    return Center(child: Text('Пока что событий нет'));
  }
}

class EventCard extends StatelessWidget {
  const EventCard({Key? key, required this.item}) : super(key: key);
  final Map item;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 335,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(18)),
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
                    item["author"],
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    item["author_role"],
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
                color: Colors.amber,
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
                    item['name'],
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
                      item["timedate"],
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
                      item["location"],
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
    );
  }
}

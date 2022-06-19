import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/event_card.dart';
import 'package:gotome/widgets/images/brand_icon.dart';
import 'package:gotome/widgets/top_tab.dart';

class ProfileOtherScreen extends StatelessWidget {
  ProfileOtherScreen({Key? key}) : super(key: key);
  final author = Get.arguments;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return CustomScaffold(
      padding: EdgeInsets.fromLTRB(
          20, 40 + MediaQuery.of(context).viewInsets.top, 20, 0),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: BrandIcon(icon: 'back_arrow')),
            Container(
              height: 114,
              width: 114,
              child: CircleAvatar(),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              author["author_username"]!,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor),
            ),
            SizedBox(
              height: 24,
            ),
            TabsSwitch(
              children: [
                TopTab(
                  text: 'Информация',
                ),
                TopTab(
                  text: 'История событий',
                )
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Expanded(
                child: TabBarView(children: [
              Info(
                author: author,
              ),
              History()
            ])),
          ],
        ),
      ),
    );
  }
}

class TabsSwitch extends StatefulWidget {
  const TabsSwitch({Key? key, this.labels, this.children}) : super(key: key);
  final labels;
  final children;
  @override
  State<TabsSwitch> createState() => _TabsSwitchState();
}

class _TabsSwitchState extends State<TabsSwitch> {
  var currentIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 0,
          indicator: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          splashBorderRadius: BorderRadius.all(Radius.circular(20)),
          unselectedLabelColor: Color(0xFF6A7592),
          labelColor: Colors.white,
          tabs: widget.children),
    );
  }
}

class Info extends StatelessWidget {
  const Info({Key? key, required this.author}) : super(key: key);
  final author;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Имя',
          style: TextStyle(color: Color(0xFF6A7592)),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          author["author_name"]!,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Theme.of(context).accentColor),
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          'Возраст',
          style: TextStyle(color: Color(0xFF6A7592)),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          author["author_age"].toString(),
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Theme.of(context).accentColor),
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          'Страна',
          style: TextStyle(color: Color(0xFF6A7592)),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          author["author_country"],
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Theme.of(context).accentColor),
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          'Город',
          style: TextStyle(color: Color(0xFF6A7592)),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          author["author_city"],
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Theme.of(context).accentColor),
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          'О себе',
          style: TextStyle(color: Color(0xFF6A7592)),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          author["author_description"]!,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Theme.of(context).accentColor),
        ),
      ],
    );
  }
}

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO
    return ListView(
      children: [
        Text(
          'Активные',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor),
        ),
        SizedBox(
          height: 16,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              return EventCard();
            }),
        SizedBox(
          height: 32,
        ),
        Text(
          'Завершенные',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor),
        ),
        SizedBox(
          height: 16,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              return Opacity(opacity: 0.35, child: EventCard());
            }),
      ],
    );
  }
}

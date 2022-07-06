import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/state/events.dart';
import 'package:gotome/state/user.dart';
import 'package:gotome/widgets/event_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Column(
      children: [
        // Header
        _Header(),
        // List
        Expanded(child: Content())
      ],
    );
  }
}

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = Provider.of<Events>(context, listen: true).events;
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

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white);
    const textStyleBold = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white);
    return Container(
      height: 76 + MediaQuery.of(context).viewPadding.top,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(
          16, 16 + MediaQuery.of(context).viewPadding.top, 16, 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          color: Theme.of(context).primaryColor),
      child: GestureDetector(
        onTap: () {
          Get.toNamed('/change_city');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'События в городе',
              style: textStyle,
            ),
            Text(
              Provider.of<User>(context, listen: true).user.city,
              style: textStyleBold,
            )
          ],
        ),
      ),
    );
  }
}

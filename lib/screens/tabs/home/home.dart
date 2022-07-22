import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:gotome/state/events.dart';
import 'package:gotome/state/stories.dart';
import 'package:gotome/state/user.dart';
import 'package:gotome/widgets/event_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      body: Column(
        children: [
          // Header
          _Header(),
          Expanded(
            child: ListView(children: [
              StoriesList(),
              Divider(
                color: Color(0xFFF8F8F8),
                thickness: 2,
              ),
              // List
              Content()
            ]),
          ),
        ],
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = Provider.of<Events>(context, listen: true).events;
    if (list.isNotEmpty) {
      return Column(
          children: list.map((e) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: EventCard(item: e),
        );
      }).toList());
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

class StoriesList extends StatelessWidget {
  const StoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = [...Provider.of<StoriesState>(context).stories];
    if (list.firstWhereOrNull((element) =>
            element.author.username ==
            Provider.of<User>(context).userMeta.username) !=
        null) {
      var element = list.firstWhere((element) =>
          element.author.username ==
          Provider.of<User>(context).userMeta.username);
      list.remove(element);
      list.insert(0, element);
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 24),
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            ...list.map((e) {
              return StoryItem(event: e);
            }).toList(),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class StoryItem extends StatelessWidget {
  const StoryItem({Key? key, required this.event}) : super(key: key);
  final StoryType event;
  @override
  Widget build(BuildContext context) {
    String truncateWithEllipsis(int cutoff, String myString) {
      return (myString.length <= cutoff)
          ? myString
          : '${myString.substring(0, cutoff)}...';
    }

    var list = Provider.of<StoriesState>(context).stories;
    if (list.firstWhereOrNull((element) =>
            element.author.username ==
            Provider.of<User>(context).userMeta.username) !=
        null) {
      var element = list.firstWhere((element) =>
          element.author.username ==
          Provider.of<User>(context).userMeta.username);
      list.remove(element);
      list.insert(0, element);
    }
    var index = list.indexOf(event);
    return GestureDetector(
      onTap: () {
        Get.toNamed('/story', arguments: index);
      },
      child: Container(
        height: 85,
        // width: 66,
        padding: EdgeInsets.only(right: 10),
        child: Column(
          children: [
            Container(
              height: 62,
              width: 62,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  border: Border.all(
                      width: 2, color: Theme.of(context).primaryColor)),
              child: Padding(
                padding: EdgeInsets.all(3),
                child: CircleAvatar(
                  radius: 58 / 2,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 66,
              child: Text(
                truncateWithEllipsis(
                    12,
                    event.author.username ==
                            Provider.of<User>(context).userMeta.username
                        ? 'Ваша история'
                        : event.author.username),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 10),
              ),
            )
          ],
        ),
      ),
    );
  }
}

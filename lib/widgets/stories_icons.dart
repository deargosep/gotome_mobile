import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/state/stories.dart';
import 'package:gotome/state/user.dart';
import 'package:gotome/widgets/images/brand_icon.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
            list.first.author.username !=
                    Provider.of<User>(context).userMeta.username
                ? AddStoryItem()
                : Container(),
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

class AddStoryItem extends StatelessWidget {
  AddStoryItem({Key? key}) : super(key: key);
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final XFile? image =
            await _picker.pickVideo(source: ImageSource.gallery);
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
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 58 / 2,
                  ),
                  Positioned(
                      left: 35,
                      bottom: 3,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                        child: BrandIcon(icon: 'add_small'),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 66,
              child: Text(
                'Ваша история',
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/state/stories.dart';
import 'package:gotome/state/user.dart';
import 'package:gotome/widgets/bottom_panel.dart';
import 'package:gotome/widgets/brand_button.dart';
import 'package:provider/provider.dart';
import 'package:story_time/story_time.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({Key? key}) : super(key: key);

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  @override
  Widget build(BuildContext context) {
    var list = [...Provider.of<StoriesState>(context).stories];
    void setList() {
      StoryType event = Get.arguments;
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
    }

    return Scaffold(
      body: StoryPageView(
        itemBuilder: (context, pageIndex, storyIndex) {
          final event = list[pageIndex];
          final story = event;
          // if (mounted)
          // setState(() {
          var isAuthor = Provider.of<User>(context).userMeta.username ==
              event.author.username;
          // });

          return ClipRRect(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15)),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(color: Colors.black),
                ),
                Positioned.fill(
                  child: Image.network(
                    story.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 44, left: 10, right: 10),
                  child: Row(
                    children: [
                      Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(event.imageUrl),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        event.author.username,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '20 мин.',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFFFFFFF).withOpacity(0.75)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        gestureItemBuilder: (context, pageIndex, storyIndex) {
          final event = list[pageIndex];
          final story = event;
          var isAuthor = Provider.of<User>(context).userMeta.username ==
              event.author.username;
          return Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onVerticalDragEnd: (s) {
                Get.back();
              },
              child: BottomPanel(
                  child: BrandButton(
                text: isAuthor != true ? 'Присоединиться' : 'Список желающих',
                type: isAuthor == true ? 'primary' : 'secondary',
                onPressed: () {
                  if (isAuthor) {
                    Get.toNamed('/members',
                        arguments: {"members": event.members, "isChat": false});
                  }
                },
              )),
            ),
          );
          return Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 32),
              child: IconButton(
                padding: EdgeInsets.zero,
                color: Colors.white,
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
        },
        storyLength: (int) => 1,
        onPageLimitReached: () {
          Get.back();
        },
        pageLength: list.length,
      ),
    );
  }
}

class _Progress extends StatelessWidget {
  const _Progress(
      {Key? key,
      required this.list,
      this.index,
      this.currentIndex,
      this.progress,
      this.gap})
      : super(key: key);
  final List<StoryType> list;
  final index;
  final currentIndex;
  final progress;
  final gap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: Container(
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Color(0xFFF8F8F8).withOpacity(0.6),
                color: Color(0xFFF8F8F8),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 35 / 2,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      list[index].author.username ?? '',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                    ),
                    Text(
                      '20 мин.',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.75),
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

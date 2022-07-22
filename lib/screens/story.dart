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

class _StoryScreenState extends State<StoryScreen>
    with SingleTickerProviderStateMixin {
  var isJoined = false;
  late Animation _animationFadeInOut;
  late AnimationController _animationController;
  late Animation _animationText;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _animationFadeInOut = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _animationText = StepTween(begin: 1, end: 3).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
  }

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

    return Scaffold(
      body: StoryPageView(
        // indicatorDuration: Duration(seconds: 70),
        initialPage: Get.arguments,
        indicatorPadding: EdgeInsets.only(left: 20, right: 20, top: 40),
        // backgroundColor: Color(0xFFF8F8F8).withOpacity(0.6),
        itemBuilder: (context, index, storyIndex) {
          return Container();
        },
        gestureItemBuilder: (context, pageIndex, storyIndex) {
          final event = list[pageIndex];
          final story = event;

          var isAuthor = Provider.of<User>(context).userMeta.username ==
              event.author.username;

          return Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    // Positioned.fill(
                    //   child: Container(color: Colors.white),
                    // ),
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15)),
                        child: Image.network(
                          story.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 52, left: 20, right: 20),
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
                    Positioned(
                      left: 180,
                      bottom: 45,
                      child: AnimatedBuilder(
                        builder: (context, child) {
                          return Opacity(
                            opacity: _animationFadeInOut.value,
                            child: CustomPaint(
                              painter: customStyleArrow(),
                              child: Container(
                                width: 197,
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 16, top: 16),
                                child: Column(
                                  children: [
                                    Text("Заявка успешно отправлена!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("Ожидайте ответ от организатора",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        animation: _animationController,
                      ),
                    )
                  ],
                ),
              ),
              BottomPanel(
                  child: BrandButton(
                text: isAuthor != true ? 'Присоединиться' : 'Список желающих',
                type: isAuthor == true ? 'secondary' : 'primary',
                onPressed: () {
                  if (isAuthor) {
                    Get.toNamed('/members',
                        arguments: {"members": event.members, "isChat": false});
                  } else {
                    _animationController.forward().then((value) {
                      if (mounted) {
                        setState(() {
                          isJoined = true;
                        });
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          //wait a little for text can be read
                          if (mounted) {
                            setState(() {
                              isJoined = false;
                            });
                          }
                        }).then((value) {
                          if (mounted) {
                            _animationController.reverse();
                          }
                        });
                      }
                    });
                    // setState(() {
                    //   isJoined = true;
                    // });
                  }
                },
              )),
            ],
          );
        },
        // gestureItemBuilder: (context, pageIndex, storyIndex) {
        //   final event = list[pageIndex];
        //   final story = event;
        //   var isAuthor = Provider
        //       .of<User>(context)
        //       .userMeta
        //       .username ==
        //       event.author.username;
        //   return Align(
        //     alignment: Alignment.bottomCenter,
        //     child: Stack(
        //       children: [
        //         BottomPanel(child: BrandButton(text: 'Присоединиться')),
        //         Positioned(
        //             bottom: 50,
        //             child: CustomPaint(
        //               painter: customStyleArrow(),
        //               child: Container(
        //                 padding: EdgeInsets.only(
        //                     left: 15, right: 15, bottom: 20, top: 20),
        //                 child: Text(
        //                     "This is the custom painter for arrow down curve",
        //                     style: TextStyle(
        //                       color: Colors.black,
        //                     )),
        //               ),
        //             )),
        //       ],
        //     ),
        //   );
        // },
        storyLength: (int) => 1,
        onPageLimitReached: () {
          Get.back();
        },
        pageLength: list.length,
      ),
    );
  }
}

class customStyleArrow extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;
    final double triangleH = 26;
    final double triangleW = 31.0;
    final double width = 197;
    final double height = 89;

    final Path trianglePath = Path()
      ..moveTo(width / 1.2 - triangleW / 2, height)
      ..lineTo(width / 1.2, triangleH + height)
      ..lineTo(width / 1.2 + triangleW / 2, height)
      ..lineTo(width / 1 - triangleW / 1.2, height);
    canvas.drawPath(trianglePath, paint);
    final BorderRadius borderRadius = BorderRadius.circular(15);
    final Rect rect = Rect.fromLTRB(0, 0, width, height);
    final RRect outer = borderRadius.toRRect(rect);
    canvas.drawRRect(outer, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

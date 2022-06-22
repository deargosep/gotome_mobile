import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/header.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        padding: EdgeInsets.fromLTRB(
            0, 40 + MediaQuery.of(context).viewInsets.top, 0, 0),
        body: Column(
          children: [
            Header(
              text: 'Чаты',
            ),
            SizedBox(
              height: 24,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ChatTile(index),
                        SizedBox(
                          height: 8,
                        ),
                        Divider(
                          thickness: 2,
                          color: Color(0xFFF8F8F8),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    );
                  }),
            )
          ],
        ));
  }
}

class ChatTile extends StatelessWidget {
  const ChatTile(this.index, {Key? key}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: pass data to screen
        Get.toNamed('/chat');
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(height: 56, width: 56, child: CircleAvatar()),
                SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Катаемся на велосипедах',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Игорь: Всем привет!',
                      style: TextStyle(color: Color(0xFF6A7592)),
                    )
                  ],
                ),
              ],
            ),
            index.isOdd
                ? Container()
                : Container(
                    height: 30,
                    width: 38,
                    decoration: BoxDecoration(
                      color: Color(0xFFE5DCFF),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Text(
                        '22',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

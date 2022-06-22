import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/widgets/bottom_panel.dart';
import 'package:gotome/widgets/images/brand_icon.dart';

import '../../../widgets/input.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        _Header(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              reverse: true,
              children: [
                Message(
                  isMine: true,
                ),
                SizedBox(
                  height: 16,
                ),
                Message(
                  isMine: false,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        BottomPanel(height: 83.0, child: SendMessage())
      ],
    ));
  }
}

class Message extends StatelessWidget {
  const Message({Key? key, this.isMine = false}) : super(key: key);
  final isMine;
  @override
  Widget build(BuildContext context) {
    final text = isMine ? 'Все гуд, спасибо!' : 'Как у всех дела?';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        !isMine ? Container() : Spacer(),
        isMine
            ? Container()
            : Container(
                height: 38,
                width: 38,
                child: CircleAvatar(),
              ),
        isMine
            ? Container()
            : SizedBox(
                width: 12,
              ),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: isMine ? Color(0xFFE5DCFF) : Color(0xFFEFEFEF),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Column(
            crossAxisAlignment:
                isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              isMine
                  ? Container()
                  : Text(
                      'HotLine',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
              isMine
                  ? Container()
                  : SizedBox(
                      height: 8,
                    ),
              Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '10:03',
                style: TextStyle(fontSize: 12, color: Color(0xFF9FA6BA)),
              )
            ],
          ),
        ),
        !isMine
            ? Container()
            : SizedBox(
                width: 12,
              ),
        !isMine
            ? Container()
            : Container(
                height: 38,
                width: 38,
                child: CircleAvatar(),
              ),
      ],
    );
  }
}

class SendMessage extends StatelessWidget {
  const SendMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BrandIcon(icon: 'add', height: 25, width: 25, color: Color(0xFF9FA6BA)),
        SizedBox(
          width: 10.5,
        ),
        Expanded(
          child: Input(
            height: 40.0,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            label: 'Введите сообщение',
          ),
        )
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/members', arguments: {
          "isChat": true,
        });
      },
      child: Container(
          height: 76 + MediaQuery.of(context).viewPadding.top,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(
              16, 10 + MediaQuery.of(context).viewPadding.top, 16, 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              color: Theme.of(context).primaryColor),
          child: Row(
            children: [
              BrandIcon(
                icon: 'back_arrow',
                color: Colors.white,
              ),
              SizedBox(
                width: 26,
              ),
              Container(height: 38, width: 38, child: CircleAvatar()),
              SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Катаемся на велосипедах',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '03.06.2022 в 15:00',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Участники: 8',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  )
                ],
              ),
            ],
          )),
    );
  }
}

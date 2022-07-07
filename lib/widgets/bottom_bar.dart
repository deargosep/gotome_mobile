import 'package:flutter/material.dart';
import 'package:gotome/widgets/images/brand_icon.dart';

class BottomBar extends StatelessWidget {
  BottomBar(
      {Key? key,
      required this.onTap,
      required this.onCenterTap,
      required this.currentIndex})
      : super(key: key);
  Function(int) onTap;
  VoidCallback onCenterTap;
  int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 8,
          blurRadius: 15,
          offset: Offset(0, 8),
        )
      ]),
      width: MediaQuery.of(context).size.width,
      height: 92,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  onTap(0);
                },
                child: BottomBarItem(
                    label: 'Главная', icon: 'home', active: currentIndex == 0)),
            GestureDetector(
                onTap: () {
                  onTap(1);
                },
                child: BottomBarItem(
                    label: 'Поиск', icon: 'search', active: currentIndex == 1)),
            NewEvent(
              onTap: onCenterTap,
            ),
            GestureDetector(
                onTap: () {
                  onTap(2);
                },
                child: BottomBarItem(
                    label: 'Чаты', icon: 'chat', active: currentIndex == 2)),
            GestureDetector(
                onTap: () {
                  onTap(3);
                },
                child: BottomBarItem(
                    label: 'Профиль',
                    icon: 'profile',
                    active: currentIndex == 3)),
          ],
        ),
      ),
    );
  }
}

class BottomBarItem extends StatelessWidget {
  BottomBarItem(
      {Key? key, required this.label, required this.icon, required this.active})
      : super(key: key);
  String label;
  String icon;
  bool active;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BrandIcon(
          icon: icon,
          color: active ? Theme.of(context).primaryColor : Color(0xFF9FA6BA),
          width: 20,
          height: 20,
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          label,
          style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w500,
              color:
                  active ? Theme.of(context).primaryColor : Color(0xFF9FA6BA)),
        )
      ],
    );
  }
}

class NewEvent extends StatefulWidget {
  NewEvent({Key? key, required this.onTap}) : super(key: key);
  VoidCallback onTap;

  @override
  State<NewEvent> createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {
  bool pressing = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (dt) {
        setState(() {
          pressing = true;
        });
      },
      onTapUp: (dt) {
        setState(() {
          pressing = false;
        });
      },
      onTapCancel: () {
        setState(() {
          pressing = false;
        });
      },
      onTap: widget.onTap,
      child: Container(
        height: 50,
        width: 75,
        decoration: BoxDecoration(
            color:
                pressing ? Color(0xFF2D34CB) : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BrandIcon(icon: 'add'),
            SizedBox(
              height: 6,
            ),
            Text(
              'Новое событие',
              style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gotome/widgets/top_tab.dart';

class TabsSwitch extends StatefulWidget {
  const TabsSwitch(
      {Key? key,
      this.labels,
      this.children,
      this.initialIndex,
      required this.controller,
      this.mockupOnly})
      : super(key: key);
  final labels;
  final children;
  final initialIndex;
  final TabController controller;
  final mockupOnly;
  @override
  State<TabsSwitch> createState() => _TabsSwitchState();
}

class _TabsSwitchState extends State<TabsSwitch> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  // @override
  // void dispose() {
  //   widget.controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: TabBar(
          controller: widget.controller,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 0,
          indicator: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          splashBorderRadius: BorderRadius.all(Radius.circular(20)),
          unselectedLabelColor: Color(0xFF6A7592),
          labelColor: Colors.white,
          tabs: widget.mockupOnly == true
              ? [
                  TopTab(
                    text: 'Списком',
                  ),
                  TopTab(
                    text: 'На карте',
                  ),
                ]
              : widget.children),
    );
  }
}

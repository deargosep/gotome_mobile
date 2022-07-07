import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/screens/tabs/search/map.dart';
import 'package:gotome/state/filter.dart';
import 'package:gotome/widgets/event_card.dart';
import 'package:gotome/widgets/header.dart';
import 'package:gotome/widgets/search_input.dart';
import 'package:gotome/widgets/tabbar_switch.dart';
import 'package:provider/provider.dart';

import '../../../state/events.dart';
import '../../../widgets/top_tab.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      vsync: this,
      length: 2,
    );
    controller.addListener(() {
      print(controller.index);
      if (controller.index == 1) {
        Get.to(() => MapScreen(),
            fullscreenDialog: false,
            popGesture: true,
            transition: Transition.noTransition);
        controller.index = 0;
        DefaultTabController.of(context)?.animateTo(0);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollView = ScrollController();
    final arguments = Get.arguments;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              0, 40 + MediaQuery.of(context).viewInsets.top, 0, 0),
          child: NestedScrollView(
              physics: NeverScrollableScrollPhysics(),
              controller: scrollView,
              headerSliverBuilder: (context, value) {
                return [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Header(
                            withPadding: false,
                            text: 'Поиск',
                          ),
                        ),
                        SizedBox(
                          height: 57,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TabsSwitch(
                            controller: controller,
                            children: [
                              TopTab(
                                text: 'Списком',
                              ),
                              TopTab(
                                text: 'На карте',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        )
                      ],
                    ),
                  )
                ];
              },
              body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller,
                  children: [Search(), _FakeOnMap()])),
        ),
      ),
    );
  }
}

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void filterEvents() {
      Provider.of<FiltersModel>(context, listen: false).filterEvents(
          Provider.of<Events>(context, listen: false).events,
          textController.text);
    }

    filterEvents();

    // List<Widget> generateList() {
    //   return Provider.of<Events>(context).events.map((e) {
    //     return Column(
    //       children: [
    //         EventCard(item: e),
    //         SizedBox(
    //           height: 24,
    //         )
    //       ],
    //     );
    //   }).toList();
    // }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SearchInput(
            controller: textController,
            onTap: () {
              filterEvents();
            },
            onComplete: () {
              Provider.of<FiltersModel>(context, listen: false).filterEvents(
                  Provider.of<Events>(context, listen: false).events,
                  textController.text);
            },
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Expanded(child: Consumer<FiltersModel>(
          builder: (context, eventsm, child) {
            if (eventsm.filteredEvents.isEmpty)
              return Center(
                child: Container(
                  width: 236,
                  child: Text(
                    'По заданным критериям события не найдены',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
              );
            return ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: eventsm.filteredEvents.map((e) {
                return Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: EventCard(item: e)),
                    SizedBox(
                      height: 24,
                    )
                  ],
                );
              }).toList(),
            );
          },
        ))
      ],
    );
  }
}

class _FakeOnMap extends StatelessWidget {
  const _FakeOnMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SearchInput(),
        ),
        SizedBox(
          height: 16,
        ),
        Container()
      ],
    );
  }
}

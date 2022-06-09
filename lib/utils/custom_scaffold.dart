import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  CustomScaffold(
      {Key? key,
      required Widget this.child,
      bool? this.scrollable,
      bool? this.noPadding,
      EdgeInsets? this.padding})
      : super(key: key);
  final child;
  bool? scrollable = false;
  bool? noPadding = false;
  EdgeInsets? padding = EdgeInsets.zero;
  @override
  Widget build(BuildContext context) {
    if (scrollable == true) {
      return Scaffold(
        body: LayoutBuilder(builder: (context, constraint) {
          return Center(
            child: noPadding == true
                ? SingleChildScrollView(
                    child: child,
                  )
                : Padding(
                    padding: padding ?? EdgeInsets.fromLTRB(20, 40, 20, 20),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height - 60,
                          child: child,
                        ),
                      ),
                    )),
          );
        }),
      );
    }
    return Scaffold(
      body: Center(
          child: noPadding == true
              ? child
              : Padding(
                  padding: padding ?? EdgeInsets.fromLTRB(20, 40, 20, 20),
                  child: child)),
    );
  }
}

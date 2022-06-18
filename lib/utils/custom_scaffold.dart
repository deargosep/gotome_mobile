import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  CustomScaffold(
      {Key? key,
      required Widget this.body,
      bool? this.scrollable,
      bool? this.noPadding,
      this.noHorPadding,
      this.noVerPadding,
      EdgeInsets? this.padding})
      : super(key: key);
  final body;
  bool? scrollable = false;
  bool? noPadding = false;
  bool? noHorPadding = false;
  bool? noVerPadding = false;
  EdgeInsets? padding = EdgeInsets.zero;
  @override
  Widget build(BuildContext context) {
    if (scrollable == true) {
      return Scaffold(
        body: LayoutBuilder(builder: (context, constraint) {
          return Center(
            child: noPadding == true
                ? SingleChildScrollView(
                    child: body,
                  )
                : Padding(
                    padding: padding ??
                        EdgeInsets.fromLTRB(
                            noHorPadding == true ? 0 : 20,
                            noVerPadding == true ? 0 : 40,
                            20,
                            noVerPadding == true ? 0 : 20),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height - 60,
                          child: body,
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
              ? body
              : Padding(
                  padding: padding ??
                      EdgeInsets.fromLTRB(
                          noHorPadding == true ? 0 : 20,
                          noVerPadding == true
                              ? 0
                              : 40 + MediaQuery.of(context).viewInsets.top,
                          20,
                          noVerPadding == true ? 0 : 20),
                  child: body)),
    );
  }
}

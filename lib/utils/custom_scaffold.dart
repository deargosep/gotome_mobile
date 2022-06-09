import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({Key? key, required Widget this.child})
      : super(key: key);
  final child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20), child: child),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'images/brand_icon.dart';

class Header extends StatelessWidget {
  Header(
      {Key? key,
      this.text,
      this.withPadding = true,
      this.withBack = true,
      this.onTap})
      : super(key: key);
  final text;
  bool withPadding;
  bool withBack;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          withPadding ? EdgeInsets.fromLTRB(20, 0, 20, 0) : EdgeInsets.all(0),
      child: Row(
        children: [
          !withBack
              ? Container()
              : Row(children: [
                  BrandIcon(
                    icon: 'back_arrow',
                    onTap: onTap,
                  ),
                  SizedBox(
                    width: 26,
                  ),
                ]),
          Text(
            text ?? '',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Theme.of(context).colorScheme.secondary),
          )
        ],
      ),
    );
  }
}

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  AppHeader(
      {Key? key,
      this.text,
      this.withPadding = true,
      this.withBack = true,
      this.onTap})
      : super(key: key);
  final text;
  bool withPadding;
  bool withBack;
  final VoidCallback? onTap;

  @override
  final Size preferredSize = Size(64, 64); // default is 56.0

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: withPadding
          ? EdgeInsets.fromLTRB(
              20, 40 + MediaQuery.of(context).viewInsets.top, 20, 20)
          : EdgeInsets.all(0),
      child: Row(
        children: [
          !withBack
              ? Container()
              : Row(children: [
                  BrandIcon(
                    icon: 'back_arrow',
                    onTap: onTap,
                  ),
                  SizedBox(
                    width: 26,
                  ),
                ]),
          Text(
            text ?? '',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Theme.of(context).colorScheme.secondary),
          )
        ],
      ),
    );
  }
}

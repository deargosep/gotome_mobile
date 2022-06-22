import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'images/brand_icon.dart';
import 'input.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Row(
        children: [
          Expanded(
            child: Input(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              height: 40.0,
              label: 'Поиск',
              icon: 'search_input',
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            height: 40,
            width: 40,
            padding: EdgeInsets.symmetric(vertical: 13, horizontal: 11),
            decoration: BoxDecoration(
                color: Color(0xFFF8F8F8),
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: GestureDetector(
              onTap: () {
                Get.toNamed('/filters');
              },
              child: BrandIcon(
                icon: 'filters',
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gotome/widgets/brand_checkbox_listtile.dart';

class CheckboxesList extends StatelessWidget {
  const CheckboxesList(
      {Key? key, required this.checkboxes, required this.changeCheckbox})
      : super(key: key);
  final Map<String, bool> checkboxes;
  final changeCheckbox;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: checkboxes.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  BrandCheckboxListTile(
                      title: checkboxes.keys.elementAt(index),
                      value: checkboxes.values.elementAt(index),
                      onChanged: (val) {
                        var localCheckboxes = {...checkboxes};
                        print(checkboxes.keys.elementAt(index));
                        print(checkboxes.values.elementAt(index));
                        localCheckboxes.update(
                            checkboxes.keys.elementAt(index), (value) => val);
                        changeCheckbox(localCheckboxes);
                      }),
                  SizedBox(
                    height: 16,
                  )
                ],
              );
            })
      ],
    );
  }
}

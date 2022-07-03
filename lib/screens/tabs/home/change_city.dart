import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotome/state/user.dart';
import 'package:gotome/utils/custom_scaffold.dart';
import 'package:gotome/widgets/bottom_panel.dart';
import 'package:gotome/widgets/brand_button.dart';
import 'package:gotome/widgets/header.dart';
import 'package:gotome/widgets/input.dart';
import 'package:provider/provider.dart';

class ChangeCityScreen extends StatefulWidget {
  const ChangeCityScreen({Key? key}) : super(key: key);

  @override
  State<ChangeCityScreen> createState() => _ChangeCityScreenState();
}

class _ChangeCityScreenState extends State<ChangeCityScreen> {
  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        noPadding: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(
                    withPadding: false,
                    text: 'Изменить локацию',
                  ),
                  SizedBox(
                    height: 31,
                  ),
                  Text(
                    'Укажите страну',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Input(
                    label: 'Страна',
                    controller: country,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Укажите город',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Input(
                    label: 'Город',
                    controller: city,
                  ),
                ],
              ),
            ),
            BottomPanel(
              child: BrandButton(
                text: 'Далее',
                type: 'primary',
                onPressed: () {
                  var user = UserType(city: city.text, country: country.text);
                  Provider.of<User>(context, listen: false).setData(user);
                  Get.offAllNamed('/bar');
                },
              ),
            )
          ],
        ));
  }
}

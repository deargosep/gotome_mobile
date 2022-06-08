import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gotome/widgets/brand_button.dart';

class AuthRegister extends StatelessWidget {
  const AuthRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Spacer(),
            SvgPicture.asset('assets/images/LOGO.svg'),
            Spacer(),
            BrandButton(text: 'Вход', type: 'primary'),
            SizedBox(
              height: 16,
            ),
            BrandButton(text: 'Регистрация', type: 'secondary'),
          ],
        ),
      ),
    ));
  }
}

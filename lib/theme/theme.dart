import 'package:flutter/material.dart';

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'TTNormsPro',
    primaryColor: Color(0xFF3840EE),
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme:
        const InputDecorationTheme(filled: true, fillColor: Color(0xFFF8F8F8)),
    // appBarTheme: AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF2C3C65)),
    // cardColor: Color(0xFFE4F3F7),
    // textTheme: TextTheme(caption: TextStyle(color: Colors.white)),
    // primaryIconTheme: IconThemeData(color: Colors.black, size: 24),
    // primaryColorDark: Colors.white,
    // colorScheme: ColorScheme.light(),
    // shadowColor: Color(0xFF54B2CF),
    // buttonColor: Color(0xFF323232),
    // appBarTheme: AppBarTheme(
    //     backgroundColor: Colors.white,
    //     systemOverlayStyle: SystemUiOverlayStyle.light)
  );

  static ThemeData darkTheme = ThemeData(
      // fontFamily: 'Readex',
      // scaffoldBackgroundColor: Color(0xFF1F1D2B),
      // cardColor: Color(0xFF262836),
      // colorScheme: ColorScheme.dark(),
      // shadowColor: Color(0xFF4795AD),
      // buttonColor: Color(0xFF4795AD),
      // textTheme: TextTheme(caption: TextStyle(color: Colors.black)),
      // primaryIconTheme: IconThemeData(color: Colors.white),
      // primaryColorDark: Color(0xFF1F1D2B),
      // appBarTheme: AppBarTheme(
      //     backgroundColor: Colors.black,
      //     systemOverlayStyle: SystemUiOverlayStyle.dark)
      );
}

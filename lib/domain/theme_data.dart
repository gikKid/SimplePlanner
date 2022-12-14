import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
    splashColor: Colors.transparent,
      scaffoldBackgroundColor: isDarkTheme ?  Colors.black : Colors.white,
      primaryColor: Colors.orange,
      colorScheme:ThemeData().colorScheme.copyWith(
        secondary: isDarkTheme ? Colors.black : Colors.white,
        brightness: isDarkTheme ? Brightness.dark : Brightness.light
      ),
      cardColor: isDarkTheme ? Colors.grey : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.white,
      // buttonTheme:  Theme.of(context).buttonTheme.copyWith(
      //   colorScheme: isDarkTheme ? const ColorScheme.dark() : const ColorScheme.light(),),
      // textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(
      //     foregroundColor: isDarkTheme ? Colors.black : Colors.white,
      //   ),)
    );
  }
}

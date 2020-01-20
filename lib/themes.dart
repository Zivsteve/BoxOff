import './constants.dart';
import './utils/native_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Map themes = {
  'light': ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(PRIMARY_COLOR),
    accentColor: Color(0xff666666),
    backgroundColor: Color(0xffffffff),
    scaffoldBackgroundColor: Color(0xffeeeeee),
    cursorColor: Color(0xffff0000),
    textSelectionColor: Color(0x30ff0000),
    textSelectionHandleColor: Color(0xffff0000),
    splashFactory: InkRipple.splashFactory,
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
  ),
  'dark': ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(PRIMARY_COLOR),
    accentColor: Color(0xffeeeeee),
    backgroundColor: Color(0xff222222),
    canvasColor: Color(0xff222222),
    cursorColor: Color(0xffff0000),
    textSelectionColor: Color(0x30ff0000),
    textSelectionHandleColor: Color(0xffff0000),
    textTheme: TextTheme(display1: TextStyle(color: Color(0xffeeeeee))),
    splashFactory: InkRipple.splashFactory,
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
  ),
  'amoled': ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(PRIMARY_COLOR),
    accentColor: Color(0xffffffff),
    appBarTheme: AppBarTheme(color: Color(0xff000000)),
    backgroundColor: Color(0xff000000),
    canvasColor: Color(0xff111111),
    scaffoldBackgroundColor: Color(0xff000000),
    cursorColor: Color(0xffff0000),
    textSelectionColor: Color(0x30ff0000),
    textSelectionHandleColor: Color(0xffff0000),
    splashFactory: InkRipple.splashFactory,
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
  ),
};

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  getTheme() => _themeData;

  void setTheme(String newTheme) async {
    if (!themes.containsKey(newTheme)) {
      return;
    }
    _themeData = themes[newTheme];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', newTheme);
    Future.delayed(Duration(milliseconds: 300), () {
      setStatusBarColor(Color.fromARGB(20, 0, 0, 0), false);
      setNavigationBarColor(Color.fromARGB(10, 0, 0, 0), _themeData.brightness == Brightness.dark);
    });
    notifyListeners();
  }

  void toggleDark() {
    setTheme(_themeData.brightness == Brightness.dark ? 'light' : 'dark');
  }
}

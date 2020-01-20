import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color statusColor = Color.fromARGB(20, 0, 0, 0);
Color navigationColor = Color.fromARGB(10, 0, 0, 0);
bool statusLight = false;
bool navigationLight = false;

void updateSystemBars() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: statusColor,
      statusBarIconBrightness: statusLight ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: navigationColor,
      systemNavigationBarIconBrightness: navigationLight ? Brightness.light : Brightness.dark,
    ),
  );
}

void setAppDescription(String label, int color) {
  SystemChrome.setApplicationSwitcherDescription(
    ApplicationSwitcherDescription(
      label: label,
      primaryColor: color,
    ),
  );
}

void setStatusBarColor(Color color, [bool light = false]) {
  statusColor = color;
  statusLight = light;
  updateSystemBars();
}

void setNavigationBarColor(Color color, [bool light = false]) {
  navigationColor = color;
  navigationLight = light;
  updateSystemBars();
}

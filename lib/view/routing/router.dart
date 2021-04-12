import 'package:flutter/material.dart';
import 'package:learn4kids/view/main/mainpage.dart';
import 'package:learn4kids/view/settings/settingspage.dart';

const String MainPageRoute = "/";
const String SettingsRoute = "/settings";

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SettingsRoute:
      return MaterialPageRoute(builder: (context) => SettingsPage());
    case MainPageRoute:
    default:
      return MaterialPageRoute(builder: (context) => MainPage());
  }
}

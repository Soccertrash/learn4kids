import 'package:flutter/material.dart';
import 'package:learn4kids/persist/model/category.dart';
import 'package:learn4kids/view/main/mainpage.dart';
import 'package:learn4kids/view/settings/settingsCategory.dart';
import 'package:learn4kids/view/settings/settingspage.dart';

const String MainPageRoute = "/";
const String SettingsRoute = "/settings";
const String SettingsCategoryRoute = "/settings/category";

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SettingsRoute:
      return MaterialPageRoute(builder: (context) => SettingsPage());
    case SettingsCategoryRoute:
      Category category = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => SettingsCategoryPage(category: category));
    case MainPageRoute:
    default:
      return MaterialPageRoute(builder: (context) => MainPage());
  }
}

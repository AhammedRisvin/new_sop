import 'package:flutter/material.dart';
import 'package:sophwe_newmodule/app/utils/prefferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    isDarkModeOn = AppPref.isDrkModeOn;
  }
  bool isDarkModeOn = false;
  void updateTheme() {
    isDarkModeOn = !isDarkModeOn;
    AppPref.isDrkModeOn = !AppPref.isDrkModeOn;
    notifyListeners();
  }
}

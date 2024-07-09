import 'package:flutter/material.dart';
import 'package:sophwe_newmodule/app/modules/home/settings/main/view/settings_screen.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/home%20screen/view/home_screen.dart';
import 'package:sophwe_newmodule/app/modules/pharma/product/Search/view/search_screen.dart';

import '../../home/home/view/home_screen.dart';
import '../../loyalty/view/loyalty_home_screen.dart';

class MainBottomNavigationProvider extends ChangeNotifier {
  int bottomNavIndex = 0;

  void updateBottomNavIndex(int index) {
    bottomNavIndex = index;
    notifyListeners();
  }

  List<Widget> tabs = [
    const HomeScreen(),
    // const FoodHomeScreen(),
    const SearchScreen(
      catagoryId: '',
      subCatagoryId: '',
      isFromHome: true,
    ),
    const LoyaltyHomeScreen(),
    const PharmaHomeScreen(),
    const SettingsScreen()
  ];
}

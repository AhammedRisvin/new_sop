import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sophwe_newmodule/app/modules/food/cart/view_model/cart_provider.dart';

import '../env.dart';
import '../modules/Home/location/view_model/location_provider.dart';
import '../modules/auth/view model/auth_provider.dart';
import '../modules/bottom_navigation_bar/view model/main_bottom_navigation_provider.dart';
import '../modules/food/add review/view_model/review_add_provider.dart';
import '../modules/food/address/view_model/address_provider.dart';
import '../modules/food/favourites/view_model/favourite_provider.dart';
import '../modules/food/home/view_model/food_home.dart';
import '../modules/food/productdetail/view_model/prdocut_detail_provider.dart';
import '../modules/food/search/view_model/food_search_provider.dart';
import '../modules/food/subcategory/view_model/sub_category_provider.dart';
import '../modules/home/home/view model/home_screen_provider.dart';
import '../modules/home/settings/change_password/view_model/change_password_provider.dart';
import '../modules/home/settings/main/view_model/settings_provider.dart';
import '../modules/home/settings/profile_edit/view_model/profile_edit_provider.dart';
import '../modules/home/settings/reminder/view model/reminder_provider.dart';
import '../modules/home/settings/wallet/view model/wallet_provider.dart';
import '../modules/loyalty/view model/loyalty_provider.dart';
import '../modules/pharma/address/view_model/address_provider.dart';
import '../modules/pharma/home/catagory screen/view model/catagory_provider.dart';
import '../modules/pharma/home/home screen/view model/home_provider.dart';
import '../modules/pharma/home/home screen/view model/theme_provider.dart';
import '../modules/pharma/product/cart/view_model/pharma_cart_provider.dart';
import '../modules/pharma/product/favourites/view_model/favourites_provider.dart';
import '../modules/pharma/product/order history/view_model/order_history_provider.dart';
import '../modules/pharma/product/product details/view model/detailed_product_view_provider.dart';
import '../modules/pharma/product/return_payment/view_model/pharma_order_cancel_provider.dart';
import '../modules/pharma/product/review/view model/raing_provider.dart';

class AppConstants {
  static const String appName = Environments.appName;
  static const String fontFamily = "Helvetica";

/* App Colors */
  static const white = Color(0xFFFFFFFF);
  static const black = Colors.black;
  static const black40 = Color(0xff999999);
  static const black60 = Color(0xff666666);
  static const black10 = Color(0xffE5E5E5);
  static const transparent = Colors.transparent;
  static const stepperGreen = Color(0xff28A745);

  static const bgDarkContainer = Color(0xff161618);
  static const darkBlue = Color(0xFF10274A);
  static const commonGold = Color(0xffC1AE97);
// Input Background
  static const inputDark = Color(0xff232323);
  static const inputLight = Color(0xffE9EEF0);
  static const tInactive = Color(0xff75808a);
  static const yellow = Color(0xffFFD600);
  static const red = Color.fromARGB(255, 192, 3, 3);

  //food
  static const lightPrimaryColor = Color(0xFF10274A);
  static const darkPrimaryColor = Color(0xffC1AE97);

  static const darkGrey = Color(0xff343434);
  static const darkYellow = Color(0xffFFDD11);
  static const categoryGrey = Color(0x99000000);
  static const categoryBlue = Color(0xff1B3865);
  static const lightGrey = Color(0xffEAEAEA);
  static const subtextColor = Color(0xff75808a);
  static const uselctedStarGrey = Color(0xffE5E5E5);

  // loyalty

  static const onTapColor = Color(0xffC1AE97);
  static const loyaltyBronze = Color(0xffE09854);
  static const loyaltyGold = Color(0xffFFB335);
  static const loyaltyPlatinum = Color(0xffC0C0C0);
  static const loyaltyDiamond = Color(0xff92C9E2);
  static const bronzeProgressIndicator = Color(0xffA53B1B);
  static const loyaltyGold40 = Color(0xffFFE1AE);
  static final loyaltyPlatinum40 = const Color(0xffC0C0C0).withOpacity(0.4);
  static final loyaltyDiamond40 = const Color(0xff92c9e2).withOpacity(0.4);
  static const loyaltyBronze40 = Color(0xffF6E0CB);
  static const unTapColor = Color(0xff6D7D95);

  static const reviewStarColor = Color(0xffFFC120);

  final List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (context) {
        return AuthProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return ThemeProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return PharmaHomeProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return CatagoryProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return RatingProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return SubcategoryProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return MainBottomNavigationProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return Foodsearchprovider();
      },
    ),

    ChangeNotifierProvider(
      create: (context) {
        return FoodAddressProvider();
      },
    ),

    ChangeNotifierProvider(
      create: (context) {
        return HomeProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return ProductDetailProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return ProfileEditProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return SettingsProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return ChangePasswordProvider();
      },
    ),
    //   ChangeNotifierProvider(
    //   create: (context) {
    //     return ThemeProvider();
    //   },
    // ),
    ChangeNotifierProvider(
      create: (context) {
        return ReminderProvider();
      },
    ),

    ChangeNotifierProvider(
      create: (context) {
        return LoyaltyProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return FoodHomeProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return FavouriteProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return ReviewAddProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return LocationProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return FoodCartProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return WalletProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return DetailedProductViewProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return PharmaFavouritesProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return PharmaCartProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return PharmaAddressProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return OrderHistoryProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return PharmaOrderCancelProvider();
      },
    ),
  ];
}

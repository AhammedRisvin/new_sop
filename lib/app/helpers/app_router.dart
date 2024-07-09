import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sophwe_newmodule/app/modules/food/cart/view/food_cart.dart';
import 'package:sophwe_newmodule/app/modules/food/order/view/order_history.dart';
import 'package:sophwe_newmodule/app/modules/home/settings/wallet/view/wallet_screen.dart';
import 'package:sophwe_newmodule/app/modules/onboarding/splash_screen.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/home%20screen/view/home_screen.dart';
import 'package:sophwe_newmodule/app/modules/pharma/product/order%20history/model/pharma_order_history_dtails_model.dart';

import '../modules/auth/view/otp_screen.dart';
import '../modules/auth/view/sign_up_screen.dart';
import '../modules/bottom_navigation_bar/view/main_botom_nav_tab.dart';
import '../modules/food/add review/view/add_review_screen.dart';
import '../modules/food/address/view/food_add_address.dart';
import '../modules/food/address/view/food_address.dart';
import '../modules/food/all dishes/view/all_dishes_page.dart';
import '../modules/food/cart/view/food_order_success_screen.dart';
import '../modules/food/categories/view/category.dart';
import '../modules/food/favourites/view/favourites.dart';
import '../modules/food/home/view/home_screen.dart';
import '../modules/food/order/view/orderdetail/order_details.dart';
import '../modules/food/productdetail/view/detail_page.dart';
import '../modules/food/restaurants/view/restaurants_detail.dart';
import '../modules/food/reviews/view/review_page.dart';
import '../modules/food/search/view/search_page.dart';
import '../modules/food/subcategory/view/subcategory_page.dart';
import '../modules/home/location/view/select_location_screen.dart';
import '../modules/home/settings/change_password/view/change_password_screen.dart';
import '../modules/home/settings/main/view/settings_screen.dart';
import '../modules/home/settings/profile_edit/view/profile_edit_screen.dart';
import '../modules/home/settings/reminder/view/add_reminder_screen.dart';
import '../modules/home/settings/reminder/view/reminder_listing_screen.dart';
import '../modules/pharma/address/view/add_address_screen.dart';
import '../modules/pharma/address/view/address_listing_screen.dart';
import '../modules/pharma/home/catagory screen/view/catagory_screen.dart';
import '../modules/pharma/product/Search/view/search_screen.dart';
import '../modules/pharma/product/cart/view/cart_screen.dart';
import '../modules/pharma/product/favourites/view/favourites_screen.dart';
import '../modules/pharma/product/order history/view/order_history_details_screen.dart';
import '../modules/pharma/product/order history/view/order_history_screen.dart';
import '../modules/pharma/product/product details/view/product_details_screen.dart';
import '../modules/pharma/product/return_payment/view/cancel_product_screen.dart';
import '../modules/pharma/product/return_payment/view/return_payment_selecting_Screen.dart';
import '../modules/pharma/product/review/view/add_rating_screen.dart';
import '../modules/pharma/product/review/view/view_reviews_screen.dart';
import '../modules/pharma/widget/order_success_screen.dart';
import '../modules/widgets/no_route_found_screen.dart';

class AppRouter {
  static const String initial = '/';
  static const String login = '/login';
  static const String mainBottomNav = '/mainBottomNav';
  static const String noInternet = '/noInternet';
  static const String homeScreen = '/homeScreen';
  static const String catagoryScreen = '/catagoryScreen';
  static const String productDetailsScreen = '/productDetailsScreen';
  static const String viewReviewScreen = '/viewReviewScreen';
  static const String favouritesScreen = '/favouritesScreen';
  static const String cartScreen = '/cartScreen';
  static const String addressScreen = '/addressScreen';
  static const String addAddressScreen = '/addAddressScreen';
  static const String orderHistoryScreen = '/orderHistoryScreen';
  static const String orderHistoryDetailsScreen = '/orderHistoryDetailsScreen';
  static const String addRatingScreen = '/addRatingScreen';
  static const String otpScreen = '/otpScreen';
  static const String returnPaymentSelectingScreen =
      '/returnPaymentSelectingScreen';
  static const String cancelProductScreen = '/cancelProductScreen';
  static const String addReminderScreen = '/addReminderScreen';

  static const String foodHomeScreen = '/foodHomeScreen';
  static const String restaurantsDetailsScreen = '/restaurantsDetailsScreen';
  static const String allDishesScreen = '/allDishesScreen';
  static const String foodCategoryScreen = '/foodCategoryScreen';
  static const String foodSubCategoryScreen = '/foodSubCategoryScreen';
  static const String foodSearchScreen = '/foodSearchScreen';
  static const String foodproductDetailScreen = '/foodproductDetailScreen';
  static const String foodReviewScreen = '/foodReviewScreen';
  static const String foodCartScreen = '/foodCartScreen';
  static const String foodaddresscreen = '/foodaddresscreen';
  static const String foodAddaddresscreen = '/foodAddaddresscreen';
  static const String foodOrderSuccessScreen = '/foodOrderSuccessScreen';
  static const String foodOrderHistoryScreen = '/foodOrderHistoryScreen';
  static const String foodOrderHistoryDetailsScreen =
      '/foodOrderHistoryDetailsScreen';
  static const String foodFavouritesScreen = '/foodFavouritesScreen';
  static const String foodAddReviewScreen = '/foodAddReviewScreen';
  static const String selectLocationScreen = '/selectLocationScreen';
  static const String settingsScreen = '/settingsScreen';
  static const String profileEditScreen = '/profileEditScreen';
  static const String reminderScreen = '/reminderScreen';
  static const String changePasswordScreen = '/changePasswordScreen';
  static const String walletScreen = '/walletScreen';
  static const String searchScreen = '/searchScreen';
  static const String orderSuccessScreen = '/orderSuccessScreen';

  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const NotFoundPage();

  static final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: initial,
        path: initial,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: otpScreen,
        path: otpScreen,
        builder: (context, state) => const OtpScreen(),
      ),
      GoRoute(
        name: homeScreen,
        path: homeScreen,
        builder: (context, state) => const PharmaHomeScreen(),
      ),
      GoRoute(
        name: catagoryScreen,
        path: catagoryScreen,
        builder: (context, state) => CatagoryScreen(
          catagoryName: state.uri.queryParameters['catagoryName'] ?? '',
          catagoryId: state.uri.queryParameters['catagoryId'] ?? '',
        ),
      ),
      GoRoute(
        name: productDetailsScreen,
        path: productDetailsScreen,
        builder: (context, state) => ProductDetailsScreen(
          productLink: state.uri.queryParameters['productLink'] ?? '',
        ),
      ),
      GoRoute(
        name: viewReviewScreen,
        path: viewReviewScreen,
        builder: (context, state) => ViewReviewScreen(
          productId: state.uri.queryParameters['productId'] ?? '',
          imageUrl: state.uri.queryParameters['imageUrl'] ?? '',
        ),
      ),
      GoRoute(
        name: favouritesScreen,
        path: favouritesScreen,
        builder: (context, state) => const FavouritesScreen(),
      ),
      GoRoute(
        name: cartScreen,
        path: cartScreen,
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        name: addressScreen,
        path: addressScreen,
        builder: (context, state) => const AddressScreen(),
      ),
      GoRoute(
        name: addAddressScreen,
        path: addAddressScreen,
        builder: (context, state) => AddAddressScreen(
          isEdit: state.uri.queryParameters['isEdit'] ?? '',
          addressId: state.uri.queryParameters['addressId'] ?? '',
          fullName: state.uri.queryParameters['name'] ?? '',
          phoneNumber: state.uri.queryParameters['phone'] ?? '',
          address: state.uri.queryParameters['address'] ?? '',
          city: state.uri.queryParameters['city'] ?? '',
          state: state.uri.queryParameters['state'] ?? '',
          pincode: state.uri.queryParameters['pincode'] ?? '',
          dialCodeShipping: state.uri.queryParameters['dialCodeShipping'] ?? '',
          isDefault: state.uri.queryParameters['isDefault'] ?? '',
          addressType: state.uri.queryParameters['addressType'] ?? '',
        ),
      ),
      GoRoute(
        name: orderHistoryScreen,
        path: orderHistoryScreen,
        builder: (context, state) => const PharmaOrderHistoryScreen(),
      ),
      GoRoute(
        name: orderHistoryDetailsScreen,
        path: orderHistoryDetailsScreen,
        builder: (context, state) => OrderHistoryDetailsScreen(
          sizeId: state.uri.queryParameters['sizeId'] ?? '',
          bookingId: state.uri.queryParameters['bookingId'] ?? '',
        ),
      ),
      GoRoute(
        name: addRatingScreen,
        path: addRatingScreen,
        builder: (context, state) => WriteReviewScreen(
          productId: state.uri.queryParameters['productId'] ?? '',
        ),
      ),
      GoRoute(
        name: returnPaymentSelectingScreen,
        path: returnPaymentSelectingScreen,
        builder: (context, state) => ReturnPaymentSelectingScreen(
          amount: state.uri.queryParameters['amount'] ?? '',
          currency: state.uri.queryParameters['currency'] ?? '',
          bookingId: state.uri.queryParameters['bookingId'] ?? '',
          productId: state.uri.queryParameters['productId'] ?? '',
          sizeId: state.uri.queryParameters['sizeId'] ?? '',
          isFromCancelled: state.uri.queryParameters['isFromCancelled'] ?? '',
        ),
      ),
      GoRoute(
        name: cancelProductScreen,
        path: cancelProductScreen,
        builder: (context, state) => CancelProductScreen(
          data: state.extra as GetOrderHistoryDeatilsModel,
        ),
      ),
      GoRoute(
        name: mainBottomNav,
        path: mainBottomNav,
        builder: (context, state) => const MainBottomNav(),
      ),
      GoRoute(
        name: addReminderScreen,
        path: addReminderScreen,
        builder: (context, state) => const AddReminderScreen(),
      ),
      GoRoute(
        name: restaurantsDetailsScreen,
        path: restaurantsDetailsScreen,
        builder: (context, state) => const RestaurantsDetailScreen(),
      ),
      GoRoute(
        name: foodHomeScreen,
        path: foodHomeScreen,
        builder: (context, state) => const FoodHomeScreen(),
      ),
      GoRoute(
        name: allDishesScreen,
        path: allDishesScreen,
        builder: (context, state) => const AllDishesScreen(),
      ),
      GoRoute(
        name: foodCategoryScreen,
        path: foodCategoryScreen,
        builder: (context, state) => const CategoryScreen(),
      ),
      GoRoute(
        name: foodSubCategoryScreen,
        path: foodSubCategoryScreen,
        builder: (context, state) => const SubcategoryScreen(),
      ),
      GoRoute(
        name: foodSearchScreen,
        path: foodSearchScreen,
        builder: (context, state) => const SearchPageScreen(),
      ),
      GoRoute(
        name: foodproductDetailScreen,
        path: foodproductDetailScreen,
        builder: (context, state) => const FoodcProductDetailsScreen(),
      ),
      GoRoute(
        name: foodReviewScreen,
        path: foodReviewScreen,
        builder: (context, state) => const FoodReviewScreen(),
      ),
      GoRoute(
        name: foodCartScreen,
        path: foodCartScreen,
        builder: (context, state) => const FoodCartScreen(),
      ),
      GoRoute(
        name: foodaddresscreen,
        path: foodaddresscreen,
        builder: (context, state) => const FoodAddressScreen(),
      ),
      GoRoute(
        name: foodAddaddresscreen,
        path: foodAddaddresscreen,
        builder: (context, state) => FoodAddAddressScreen(
          addressId: state.uri.queryParameters['addressId'] ?? '',
        ),
      ),
      GoRoute(
        name: foodOrderSuccessScreen,
        path: foodOrderSuccessScreen,
        builder: (context, state) => const FoodOrderSuccessScreen(),
      ),
      GoRoute(
        name: foodOrderHistoryScreen,
        path: foodOrderHistoryScreen,
        builder: (context, state) => const FoodOrderHistoryScreen(),
      ),
      GoRoute(
        name: foodOrderHistoryDetailsScreen,
        path: foodOrderHistoryDetailsScreen,
        builder: (context, state) => const FoodOrderHistoryDetailsScreen(),
      ),
      GoRoute(
        name: foodFavouritesScreen,
        path: foodFavouritesScreen,
        builder: (context, state) => const FoodFavouritesScreen(),
      ),
      GoRoute(
        name: selectLocationScreen,
        path: selectLocationScreen,
        builder: (context, state) => const SelectLocationScreen(),
      ),
      GoRoute(
        name: settingsScreen,
        path: settingsScreen,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        name: profileEditScreen,
        path: profileEditScreen,
        builder: (context, state) => ProfileEditScreen(
          userName: state.uri.queryParameters['userName'] ?? '',
          profileImage: state.uri.queryParameters['profileImage'] ?? '',
          phoneNumber: state.uri.queryParameters['phoneNumber'] ?? '',
          dialCode: state.uri.queryParameters['dialCode'] ?? '',
          height: state.uri.queryParameters['height'] ?? '',
          unit: state.uri.queryParameters['unit'] ?? '',
          weight: state.uri.queryParameters['weight'] ?? '',
          dateOfBirth: state.uri.queryParameters['dateOfBirth'] ?? '',
          gender: state.uri.queryParameters['gender'] ?? '',
          isEdit: state.uri.queryParameters['isEdit'] ?? '',
        ),
      ),
      GoRoute(
        name: reminderScreen,
        path: reminderScreen,
        builder: (context, state) => const ReminderListingScreen(),
      ),
      GoRoute(
        name: changePasswordScreen,
        path: changePasswordScreen,
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        name: foodAddReviewScreen,
        path: foodAddReviewScreen,
        builder: (context, state) => const FoodAddReviewScreen(
            // categoryid: state.uri.queryParameters['categoryid'] ?? '',
            // sectionName: state.uri.queryParameters['sectionName'] ?? '',
            ),
      ),
      GoRoute(
        name: login,
        path: login,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        name: walletScreen,
        path: walletScreen,
        builder: (context, state) => const WalletScreen(),
      ),
      GoRoute(
        name: searchScreen,
        path: searchScreen,
        builder: (context, state) => SearchScreen(
          catagoryId: state.uri.queryParameters['catagoryId'] ?? '',
          subCatagoryId: state.uri.queryParameters['subCatagoryId'] ?? '',
        ),
      ),
      GoRoute(
        name: orderSuccessScreen,
        path: orderSuccessScreen,
        builder: (context, state) => const OrderSuccessScreen(),
      ),
    ],
  );

  static GoRouter get router => _router;
}

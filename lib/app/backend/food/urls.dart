import '../../env.dart';

class FoodUrls {
  static String baseUrl = Environments.foodBaseUrl;
  static String getFoodCategory = "${baseUrl}olympic-user/getCategories";
  static String getFoodHomwBanners = "${baseUrl}olympic-user/getHomeBanner";
  static String getFoodRecommended =
      "${baseUrl}olympic-user/getRecommendedFoods";
  static String getFoodWishList = "${baseUrl}olympic-user/wishlist/get";
  static String addOrRemoveUrl = "${baseUrl}olympic-user/wishlist/add";
  static String getFoodCarturl = "${baseUrl}olympic-user/getCart";
  static String cartIncreamentUrl = "${baseUrl}olympic-user/cart/increment";
  static String cartDcreamentUrl = "${baseUrl}olympic-user/cart/decrement";
  static String cartRemoveUrl = "${baseUrl}olympic-user/cart/remove";
  static String getAddressUrl = "${baseUrl}olympic-user/address/get";
  static String addAddressUrl = "${baseUrl}olympic-user/address/add";
  static String editAddressUrl = "${baseUrl}olympic-user/address/update/";
  static String deleteAddressUrl = "${baseUrl}olympic-user/address/delete/";
  static String getProducts = "${baseUrl}olympic-user/getProducts?";
}

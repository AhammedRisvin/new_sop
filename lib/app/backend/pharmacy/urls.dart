import '../../env.dart';

class Urls {
  static String baseUrl = Environments.baseUrl;

  //  pharmacy
  static String getPharmacyCatagory =
      "${baseUrl}sophwe-user/get-categories?section=";

  static String getPharmacySubCatagory = "${baseUrl}user/subCategory?category=";
  static String getPharmacyProduct = "${baseUrl}user/products?subCategory=";
  static String addOrRemoveWishList = "${baseUrl}user/wishlist";
  static String productDetailedViewUrl = "${baseUrl}user/productDetails";
  static String getReviewUrl = "${baseUrl}user/getReviews?productId=";
  static String getFavouritesUrl = "${baseUrl}user/wishlist";
  static String getPharmaCartUrl = "${baseUrl}user/getCart";
  static String cartIncrementUrl = "${baseUrl}user/incrementCartCount";
  static String cartDecrementUrl = "${baseUrl}user/decrementCartCount";
  static String removeFromCartUrl = "${baseUrl}user/removeCart";
  static String getCouponUrl = "${baseUrl}user/coupon?cartId=";
  static String applyCouponUrl = "${baseUrl}user/coupon";
  static String getPharmaAddressUrl = "${baseUrl}user/shippingAddress";
  static String walletPaymentUrl = "${baseUrl}user/walletPay";
  static String cartPaypalUrl = '${baseUrl}user/proceedPaypalPay?wallet=';
  static String cartStripeUrl = '${baseUrl}user/proceedStripePay?wallet=';
  static String cartPaypalValidation =
      "${baseUrl}user/proceedPaypalPayValidation";
  static String cartStripeValidation = "${baseUrl}user/proceedStripeValidation";
  static String addToCartUrl = "${baseUrl}user/addToCart";
  static String getPharmaOrderHistoryUrl = "${baseUrl}user/getOrders?status=";
  static String getPharmaOrderDetailsHistoryUrl = "${baseUrl}user/orderDetails";
  static String getPharmaOrderCancelUrl =
      "${baseUrl}user/cancelOrder?isWallet=";
  static String getPharmaOrderReturnUrl =
      "${baseUrl}user/returnOrder?isWallet=";
  static String addReviewUrl = "${baseUrl}user/addReview";
}

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/backend/pharmacy/urls.dart';
import 'package:sophwe_newmodule/app/backend/server_client_services.dart';
import 'package:sophwe_newmodule/app/helpers/app_router.dart';
import 'package:sophwe_newmodule/app/helpers/loading_overlay.dart';
import 'package:sophwe_newmodule/app/modules/pharma/address/view_model/address_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../utils/enums.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../widget/cart_paypal_webview_screen.dart';
import '../model/get_cart_model.dart';
import '../model/get_coupons_model.dart';

class PharmaCartProvider extends ChangeNotifier {
  // ------- CART INCREMENT FN START ----- //
  bool isLoading = false;

  void setLoadingAdd(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future quantityIncrementFn({
    required String productId,
    required String selectedSizeId,
    required int quantity,
    required int totalQuantity,
    required BuildContext context,
    required Function() successCallback,
  }) async {
    try {
      setLoadingAdd(true);
      List response = await ServerClient.post(
        Urls.cartIncrementUrl,
        data: {
          "productId": productId,
          "sizeId": selectedSizeId,
        },
      );

      if (response.first >= 200 &&
          response.first < 300 &&
          quantity < totalQuantity) {
        successCallback();
        setLoadingAdd(false);

        notifyListeners();
      } else {
        setLoadingAdd(false);
        toast(
          context,
          title: "Reached Max Quantity",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    } finally {
      notifyListeners();
    }
  }

  Future quantityDecrementFn({
    required String productId,
    required String selectedSizeId,
    required Function() successCallback,
  }) async {
    try {
      setLoadingAdd(true);
      List response = await ServerClient.post(
        Urls.cartDecrementUrl,
        data: {
          "productId": productId,
          "sizeId": selectedSizeId,
        },
      );

      if (response.first >= 200 && response.first < 300) {
        successCallback();
        setLoadingAdd(false);
      } else {
        setLoadingAdd(false);
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    } finally {
      notifyListeners();
    }
  }

  // ------- CART INCREMENT FN END   ----- //

  // ------- CART DELETE FN START ----- //
  Future<void> removeFromCartFn({
    required BuildContext ctx,
    required String productId,
    required String sizeId,
    required Function() successCallback,
  }) async {
    try {
      LoadingOverlay.of(ctx).show();
      var body = {
        "productId": productId,
        "sizeId": sizeId,
      };
      List response = await ServerClient.post(
        Urls.removeFromCartUrl,
        data: body,
      );
      if (response.first >= 200 && response.first < 300) {
        ctx.pop();
        successCallback();
      } else {
        toast(
          ctx,
          title: response.last ?? 'Error in removing item from cart',
        );
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    } finally {
      LoadingOverlay.of(ctx).hide();
      notifyListeners();
    }
  }
  // ------- CART DELETE FN END   ----- //

  // ------- GET COUPONS FN START ----- //

  GetCouponsModel getCouponsModel = GetCouponsModel();
  PharmaCouponStatus couponStatus = PharmaCouponStatus.initial;

  Future<void> getCouponsFn({required String cartId}) async {
    try {
      couponStatus = PharmaCouponStatus.loading;
      getCouponsModel = GetCouponsModel();
      List response = await ServerClient.get(
        Urls.getCouponUrl + cartId,
      );
      if (response.first >= 200 && response.first < 300) {
        getCouponsModel = GetCouponsModel.fromJson(response.last);
        couponStatus = PharmaCouponStatus.loaded;
      } else {
        couponStatus = PharmaCouponStatus.error;
      }
    } catch (e) {
      couponStatus = PharmaCouponStatus.error;
      debugPrint("Error in getPharmaCartFn: $e");
    } finally {
      notifyListeners();
    }
  }

  // ------- GET COUPONS FN END   ----- //

  String appliedCouponName = '';

  String formatCouponExpiryDate(DateTime expiryDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final formatExpiryDate =
        DateTime(expiryDate.year, expiryDate.month, expiryDate.day);

    if (formatExpiryDate == today) {
      return 'Today';
    } else if (formatExpiryDate == tomorrow) {
      return 'Tomorrow';
    } else {
      return '${expiryDate.day.toString().padLeft(2, '0')}/${expiryDate.month.toString().padLeft(2, '0')}/${expiryDate.year}';
    }
  }

  //  ------- APPLY COUPON FN START ----- //

  Future<void> applyCouponFn({
    required BuildContext ctx,
    required String cartId,
    required String couponId,
    required String couponName,
    required Function(
      GetCartModel getCartModel,
    ) successCallback,
  }) async {
    try {
      LoadingOverlay.of(ctx).show();
      var body = {
        "cartId": cartId,
        "couponId": couponId,
      };
      List response = await ServerClient.post(
        Urls.applyCouponUrl,
        data: body,
      );
      if (response.first >= 200 && response.first < 300) {
        final getCartModel = GetCartModel.fromJson(response.last);
        successCallback(
          getCartModel,
        );
        appliedCouponName = couponName;
        selectedCouponId = couponId;
        ctx.pop();
        notifyListeners();
      } else {
        toast(
          ctx,
          title: response.last ?? 'Error in applying coupon',
        );
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    } finally {
      LoadingOverlay.of(ctx).hide();
      notifyListeners();
    }
  }

  //  ------- APPLY COUPON FN END   -----

  // ------- PAYMENT SELECTING FN START ----- //

  List<int> selectedPaymentIndexList = [];

  void setSelectedPaymentMethod(
    int index, {
    required double walletAmount,
    required num totalPrice,
  }) {
    if (walletAmount > 0 && walletAmount < totalPrice) {
      if (index == 0) {
        if (!selectedPaymentIndexList.contains(0)) {
          selectedPaymentIndexList.add(0);
        } else {
          selectedPaymentIndexList.remove(0);
        }
      } else {
        if (!selectedPaymentIndexList.contains(index)) {
          selectedPaymentIndexList.removeWhere((i) => i != 0 && i != index);
          selectedPaymentIndexList.add(index);
        } else {
          selectedPaymentIndexList.remove(index);
        }

        if (selectedPaymentIndexList.length == 1 &&
            selectedPaymentIndexList.contains(0)) {
          selectedPaymentIndexList.clear();
        }
      }
    } else if (walletAmount >= totalPrice) {
      // Wallet can cover the entire amount
      selectedPaymentIndexList.clear();
      selectedPaymentIndexList.add(index);
    } else {
      // Wallet cannot be used (amount is 0 or negative)
      if (index != 0) {
        selectedPaymentIndexList.clear();
        selectedPaymentIndexList.add(index);
      }
    }
    notifyListeners();
  }

  // ------- PAYMENT SELECTING FN END   ----- //

  String selectedCouponId = '';
  //  ------ WALLET  PAYMENT FN START ----- //

  Future walletPaymentFn({
    required BuildContext context,
    required String amount,
    required String cartId,
    required num discountableAmount,
  }) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.post(
        Urls.walletPaymentUrl,
        data: discountableAmount > 0
            ? {
                "amount": amount,
                "shippingId": context
                    .read<PharmaAddressProvider>()
                    .defaultShippingAddress
                    ?.id,
                "cartId": cartId,
                "couponId": selectedCouponId
              }
            : {
                "amount": amount,
                "shippingId": context
                    .read<PharmaAddressProvider>()
                    .defaultShippingAddress
                    ?.id,
                "cartId": cartId,
              },
        post: true,
      );

      if (response.first >= 200 && response.first < 300) {
        context.pop();
        selectedPaymentIndexList.clear();
        selectedCouponId = '';
        context.pushReplacementNamed(AppRouter.orderSuccessScreen);
      } else {
        context.pop();
        toast(
          context,
          title: response.last,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      context.pop();
      toast(
        context,
        title: "Server Busy Please Try Again Later",
        backgroundColor: Colors.red,
      );
      debugPrint('Error occurred during upload: $e ');
    } finally {
      LoadingOverlay.of(context).hide();
      notifyListeners();
    }
  }
  //  ------ WALLET  PAYMENT FN END   ----- //

  //  ------- PAYPAL PAYMENT FN START ----- //
  String paymentIntentId = '';

  String orderId = '';
  Future createStripeFn({
    required BuildContext context,
    required String amount,
    required String cartId,
    required String isWalletApplied,
    required num discountableAmount,
  }) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.post(
        Urls.cartStripeUrl + isWalletApplied,
        data: discountableAmount > 0
            ? {
                "amount": amount,
                "shippingId": context
                    .read<PharmaAddressProvider>()
                    .defaultShippingAddress
                    ?.id,
                "cartId": cartId,
                "couponId": selectedCouponId
              }
            : {
                "amount": amount,
                "shippingId": context
                    .read<PharmaAddressProvider>()
                    .defaultShippingAddress
                    ?.id,
                "cartId": cartId,
              },
        post: true,
      );
      if (response.first >= 200 && response.first < 300) {
        paymentIntentId = response.last['clientSecret'];
        orderId = response.last['orderId'];
        makeStripePayment(context: context, cartId: cartId);
      } else {
        LoadingOverlay.of(context).hide();
        context.pop();
        toast(
          context,
          title: "Bank server is busy. Please try again later",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
      context.pop();
      toast(
        context,
        title: "Bank server is busy. Please try again later",
        backgroundColor: Colors.red,
      );
      debugPrint('Error occurred during upload: $e ');
    }
  }

  Future<void> makeStripePayment({
    required BuildContext context,
    required cartId,
  }) async {
    try {
      try {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                merchantDisplayName: "prospect",
                paymentIntentClientSecret: paymentIntentId));
      } catch (e) {
        LoadingOverlay.of(context).hide();
      }
      //STEP 3: Display Payment sheet
      try {
        LoadingOverlay.of(context).hide();

        await Stripe.instance.presentPaymentSheet().then((value) async {
          await paymentValidationFn(
            clintId: paymentIntentId,
            context: context,
            cartId: cartId,
          );
        });
      } on Exception catch (e) {
        LoadingOverlay.of(context).hide();

        if (e is StripeException) {
          debugPrint('Error occurred during upload: $e ');
        } else {
          debugPrint('Error occurred during upload: $e ');
        }
      } catch (e) {
        LoadingOverlay.of(context).hide();
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
      toast(
        context,
        title: "Bank server is busy. Please try again later",
        backgroundColor: Colors.red,
      );
      debugPrint('Error occurred during upload: $e ');
    }
  }

  //validate payment
  Future paymentValidationFn({
    required clintId,
    required cartId,
    required BuildContext context,
  }) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.post(
        Urls.cartStripeValidation,
        data: {
          "clientSecret": clintId,
          "orderId": orderId,
          "cartId": cartId,
          "couponId": selectedCouponId
        },
        post: true,
      );
      if (response.first >= 200 && response.first < 300) {
        LoadingOverlay.of(context).hide();
        selectedCouponId = '';
        selectedPaymentIndexList.clear();
        context.pushReplacementNamed(AppRouter.orderSuccessScreen);
      } else {
        context.pop();
        LoadingOverlay.of(context).hide();
        toast(
          context,
          title: "Bank server is busy. Please try again later",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
    }

    notifyListeners();
  }
  //  ------- PAYPAL PAYMENT FN END   -----

  //  ------- PAYPAL PAYMENT FN START ----- //
  String paypalUrl = '';
  String paypalSuccessUrl = '';
  String paypalCancelUrl = '';
  String payPalAmount = "";
  String paypalCartId = '';
  paypalAmountFn(String amount) {
    payPalAmount = amount;
    notifyListeners();
  }

  Future createPaypalFn({
    required BuildContext context,
    required String isWalletApplied,
    required String cartId,
    required num discountableAmount,
  }) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.post(
        Urls.cartPaypalUrl + isWalletApplied,
        data: discountableAmount > 0
            ? {
                "amount": payPalAmount,
                "shippingId": context
                    .read<PharmaAddressProvider>()
                    .defaultShippingAddress
                    ?.id,
                "cartId": cartId,
                "couponId": selectedCouponId
              }
            : {
                "amount": payPalAmount,
                "shippingId": context
                    .read<PharmaAddressProvider>()
                    .defaultShippingAddress
                    ?.id,
                "cartId": cartId,
              },
        post: true,
      );

      if (response.first >= 200 && response.first < 300) {
        LoadingOverlay.of(context).hide();
        paypalCartId = cartId;
        paypalUrl = response.last['url'];
        paypalSuccessUrl = response.last['successUrl'];
        paypalCancelUrl = response.last['cancelUrl'];

        orderId = response.last['orderId'];

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const CartPaypalScreen(),
        ));
      } else {
        LoadingOverlay.of(context).hide();
        toast(context, title: response.last, backgroundColor: Colors.red);
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
      toast(
        context,
        title: "Bank server is busy. Please try again later",
        backgroundColor: Colors.red,
      );
    }
  }

  //validate payment
  Future paypalPaymentValidationFn(
      {required String paymentId,
      required String payerID,
      required BuildContext context,
      required WebViewController controller}) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.post(
        Urls.cartPaypalValidation,
        data: {
          "payerId": payerID,
          "paymentId": paymentId,
          "payAmount": payPalAmount,
          "orderId": orderId,
          "cartId": paypalCartId
        },
        post: true,
      );

      if (response.first >= 200 && response.first < 300) {
        LoadingOverlay.of(context).hide();
        selectedPaymentIndexList.clear();
        selectedCouponId = '';
        selectedPaymentIndexList.clear();
        successPopUp(
          image: "assets/images/orderSuccess.png",
          context: context,
          content: '''Payment has been \n successfully completed .''',
          title: 'Payment Success',
          ontap: () async {
            controller.clearCache();
            controller.clearLocalStorage();
            bool value = await controller.canGoBack();
            if (value) {
              controller.goBack();
            } else {
              context.pushNamed(AppRouter.mainBottomNav);
            }
          },
        );
      } else {
        toast(
          context,
          title: "Bank server is busy. Please try again later",
          backgroundColor: Colors.red,
        );
        LoadingOverlay.of(context).hide();
      }
    } catch (e) {
      toast(
        context,
        title: "Bank server is busy. Please try again later",
        backgroundColor: Colors.red,
      );
      LoadingOverlay.of(context).hide();
    }

    notifyListeners();
  }
  //  ------- PAYPAL PAYMENT FN END   ----- //
}

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sophwe_newmodule/app/backend/pharmacy/urls.dart';
import 'package:sophwe_newmodule/app/backend/server_client_services.dart';
import 'package:sophwe_newmodule/app/helpers/loading_overlay.dart';
import 'package:sophwe_newmodule/app/modules/widgets/common_widgets.dart';
import 'package:sophwe_newmodule/app/utils/app_constants.dart';

import '../../../../../utils/enums.dart';
import '../../../../home/home/model/get_home_data_model.dart';
import '../../cart/model/get_cart_model.dart';
import '../model/get_product_detailed_view.dart';

class DetailedProductViewProvider extends ChangeNotifier {
  //  -------- GET DETAILS OF PRODUCT FN START--------

  GetProductDetailViewModel model = GetProductDetailViewModel();
  GetDetailedVIewStatus status = GetDetailedVIewStatus.initial;

  Future<void> getDetailedVIewFn({
    required String productLink,
  }) async {
    try {
      status = GetDetailedVIewStatus.loading;
      model = GetProductDetailViewModel();
      var body = {
        "link": productLink,
      };
      List response = await ServerClient.post(
        Urls.productDetailedViewUrl,
        data: body,
      );
      if (response.first >= 200 && response.first < 300) {
        model = GetProductDetailViewModel.fromJson(response.last);
        selectedSizeId = model.product?.details?.first.id ?? "";
        status = GetDetailedVIewStatus.loaded;
        notifyListeners();
      } else {
        status = GetDetailedVIewStatus.error;
      }
    } catch (e) {
      status = GetDetailedVIewStatus.error;
      debugPrint('Error in getDetailedVIewFn: $e');
    } finally {
      notifyListeners();
    }
  }
  //  -------- GET DETAILS OF PRODUCT FN END  --------

  String formatNumber(num value) {
    if (value >= 1000 && value < 1000000) {
      // Thousands
      return "${(value / 1000).toStringAsFixed(1)}K+";
    } else if (value >= 1000000 && value < 1000000000) {
      // Millions
      return "${(value / 1000000).toStringAsFixed(1)}M+";
    } else if (value >= 1000000000) {
      // Billions
      return "${(value / 1000000000).toStringAsFixed(1)}B+";
    } else {
      // Less than 1000
      return value.toString();
    }
  }

  double calculateReviewPercentage(
      num totalReviewCount, num eachStarRatingCount) {
    if (totalReviewCount == 0) return 0;
    return eachStarRatingCount / totalReviewCount;
  }

  int selectedIndex = 0;
  String selectedSizeId = "";
  void selectContainer(int index, String sizeId) {
    selectedIndex = index;
    selectedSizeId = sizeId;
    notifyListeners();
  }

  bool isProductAddedToCart = false;

  Future<void> getPharmaCartFn({required String productLink}) async {
    try {
      List response = await ServerClient.get(
        Urls.getPharmaCartUrl,
      );
      if (response.first >= 200 && response.first < 300) {
        final getCartModel = GetCartModel.fromJson(response.last);
        final product = getCartModel.cartData?.cart!.firstWhere(
          (element) {
            return element.productLink == productLink;
          },
          orElse: () => LatestProduct(),
        );
        isProductAddedToCart = product?.productLink == productLink;
        notifyListeners();
      } else {
        isProductAddedToCart = false;
        debugPrint("Error in getPharmaCartFn: ${response.last}");
      }
    } catch (e) {
      isProductAddedToCart = false;
      debugPrint("Error in getPharmaCartFn: $e");
    }
  }

  Future<void> addToCartFn({
    required String productId,
    required BuildContext ctx,
  }) async {
    try {
      LoadingOverlay.of(ctx).show();
      List response = await ServerClient.post(
        Urls.addToCartUrl,
        data: {
          "productId": productId,
          "sizeId": selectedSizeId,
        },
      );
      if (response.first >= 200 && response.first < 300) {
        isProductAddedToCart = true;

        toast(
          ctx,
          title: response.last['message'],
          backgroundColor: AppConstants.stepperGreen,
        );
        notifyListeners();
      } else {
        toast(ctx, title: response.last, backgroundColor: AppConstants.red);
        debugPrint("Error in addToCartFn: ${response.last}");
      }
    } catch (e) {
      toast(ctx, title: "Server is busy", backgroundColor: AppConstants.red);
      debugPrint("Error in addToCartFn: $e");
    } finally {
      LoadingOverlay.of(ctx).hide();
    }
  }

  //  share product ink

  void shareLink(BuildContext context, String link) {
    Share.share(
      link,
      subject: "Check out this product on Sophwe App!",
    );
  }
}

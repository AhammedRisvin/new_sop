// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/backend/pharmacy/urls.dart';
import 'package:sophwe_newmodule/app/backend/server_client_services.dart';
import 'package:sophwe_newmodule/app/modules/home/home/view%20model/home_screen_provider.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/catagory%20screen/model/get_product_model.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/catagory%20screen/view%20model/catagory_provider.dart';
import 'package:sophwe_newmodule/app/modules/pharma/product/product%20details/view%20model/detailed_product_view_provider.dart';

import '../../../../../utils/enums.dart';
import '../../../../home/home/model/get_home_data_model.dart';
import '../../../product/favourites/model/favourites_model.dart';
import '../../../product/favourites/view_model/favourites_provider.dart';
import '../../../product/product details/model/get_product_detailed_view.dart';
import '../model/pharma_catagory_model.dart';

class PharmaHomeProvider extends ChangeNotifier {
  // ----------------- Get Pharma Home  screen start ----------------- //

  GetPharmaHomeModel getPharmaHomeModel = GetPharmaHomeModel();
  PharmaCatagoryStatus pharmaCatagoryStatus = PharmaCatagoryStatus.initial;
  Future<void> getPharmaHomeCatagoryFn() async {
    pharmaCatagoryStatus = PharmaCatagoryStatus.loading;
    try {
      String sectionId = '66766148f36cd0dfff0e841b';
      getPharmaHomeModel = GetPharmaHomeModel();
      List response = await ServerClient.get(
        Urls.getPharmacyCatagory + sectionId,
      );
      if (response.first >= 200 && response.first <= 299) {
        pharmaCatagoryStatus = PharmaCatagoryStatus.loaded;
        getPharmaHomeModel = GetPharmaHomeModel.fromJson(response.last);
        notifyListeners();
      } else {
        pharmaCatagoryStatus = PharmaCatagoryStatus.error;
      }
    } catch (e) {
      pharmaCatagoryStatus = PharmaCatagoryStatus.error;
      debugPrint('Error: $e');
    } finally {
      notifyListeners();
    }
  }
  // ----------------- Get Pharma Home  screen end ----------------- //

  // -----------------   ADD TO WISHLIST FN START  ----------------- //

  Future<void> addToWishListFn(String productId, BuildContext ctx) async {
    try {
      var params = {
        'id': productId,
      };
      List response = await ServerClient.post(
        Urls.addOrRemoveWishList,
        data: params,
      );
      if (response.first >= 200 && response.first <= 299) {
        debugPrint('Added to wishlist');
        commonWishlist(
          productId: productId,
          ctx: ctx,
        );
        ctx.read<DetailedProductViewProvider>().model.product?.wishlist =
            !(ctx.read<DetailedProductViewProvider>().model.product?.wishlist ??
                false);
        notifyListeners();
      } else {
        debugPrint('Error in adding to wishlist');
      }
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      notifyListeners();
    }
  }

  // -----------------   ADD TO WISHLIST FN END  ----------------- //

  void commonWishlist({required String productId, required BuildContext ctx}) {
    try {
      GetProductModel productModel =
          ctx.read<CatagoryProvider>().getProductModel;
      for (var element in productModel.products ?? []) {
        if (element.id == productId) {
          element.wishlist = !(element.wishlist ?? false);
        }
      }
      FavouritesModel favouritesModel =
          ctx.read<PharmaFavouritesProvider>().favouritesModel;
      for (var element in favouritesModel.wishlists?.product ?? []) {
        if (element.id == productId) {
          element.wishlist = !(element.wishlist ?? false);
        }
      }

      GetProductDetailViewModel relatedProductsModel =
          ctx.read<DetailedProductViewProvider>().model;
      for (var element in relatedProductsModel.relatedProducts ?? []) {
        if (element.id == productId) {
          element.wishlist = !(element.wishlist ?? false);
        }
      }
      GetHomeDataModel model = ctx.read<HomeProvider>().model;
      for (var element in model.latestProducts ?? []) {
        if (element.id == productId) {
          element.wishlist = !(element.wishlist ?? false);
        }
      }
      for (var element in getPharmaHomeModel.latestProducts ?? []) {
        if (element.id == productId) {
          element.wishlist = !(element.wishlist ?? false);
        }
      }
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      ctx.read<HomeProvider>().justUpdate();
      notifyListeners();
    }
  }

  // -----------------   REMOVE WISHLIST FN END  ----------------- //
}

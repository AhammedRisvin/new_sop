// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/loading_overlay.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/home%20screen/view%20model/home_provider.dart';

import '../../../../../backend/pharmacy/urls.dart';
import '../../../../../backend/server_client_services.dart';
import '../../../../../utils/enums.dart';
import '../model/favourites_model.dart';

class PharmaFavouritesProvider extends ChangeNotifier {
  // ------------- LIST Favourites FN START --------- //

  FavouritesModel favouritesModel = FavouritesModel();
  PharmaFavouritesStatus favouritesStatus = PharmaFavouritesStatus.loading;

  int currentPage = 1;
  bool hasMore = true;

  Future<void> getFavouritesFn({
    String page = '1',
  }) async {
    if (!hasMore) return;

    try {
      favouritesModel = FavouritesModel();
      favouritesStatus = PharmaFavouritesStatus.loading;
      List response = await ServerClient.get(
        Urls.getFavouritesUrl,
      );
      if (response.first >= 200 && response.first < 300) {
        favouritesModel = FavouritesModel.fromJson(response.last);
        favouritesStatus = PharmaFavouritesStatus.loaded;
        notifyListeners();
      } else {
        favouritesStatus = PharmaFavouritesStatus.error;
      }
    } catch (e) {
      favouritesStatus = PharmaFavouritesStatus.error;
      debugPrint('Get Review Error: $e');
    } finally {
      notifyListeners();
    }
  }

  // -------------  LIST Favourites FN END  --------- //

  Future<void> removeFromFavouritesFn({
    required String productId,
    required BuildContext ctx,
  }) async {
    try {
      LoadingOverlay.of(ctx).show();
      var params = {
        'id': productId,
      };
      List response = await ServerClient.post(
        Urls.addOrRemoveWishList,
        data: params,
      );
      if (response.first >= 200 && response.first < 300) {
        getFavouritesFn();

        ctx.read<PharmaHomeProvider>().getPharmaHomeCatagoryFn();
      }
    } catch (e) {
      debugPrint('Remove from Favourites Error: $e');
    } finally {
      LoadingOverlay.of(ctx).hide();
      notifyListeners();
    }
  }
}

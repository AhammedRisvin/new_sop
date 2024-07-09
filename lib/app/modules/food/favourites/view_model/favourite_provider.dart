import 'package:flutter/material.dart';

import '../../../../backend/food/food_server_client_services.dart';
import '../../../../backend/food/urls.dart';
import '../../../../utils/food/food_enums.dart';
import '../../../widgets/common_widgets.dart';
import '../model/wishlist_model.dart';

class FavouriteProvider extends ChangeNotifier {
  bool isFavourite = false;
  int currentIndex = -1;

  void toggleFavourite({required int index}) {
    isFavourite = !isFavourite;
    currentIndex = index;
    notifyListeners();
  }

  /*........................Api integration......................*/
  /*........................Api favorites......................*/

  WhishListModel whishListModel = WhishListModel();
  GetWishListsStatus getWishListsStatus = GetWishListsStatus.initial;
  Future getFoodWishListFnc({required BuildContext context}) async {
    try {
      getWishListsStatus = GetWishListsStatus.loading;
      final response = await FoodServerClient.get(FoodUrls.getFoodWishList);
      print('statusCode:::${response.first}');
      if (response.first >= 200 && response.first < 300) {
        whishListModel = WhishListModel.fromJson(response.last);

        getWishListsStatus = GetWishListsStatus.loaded;
      } else {
        getWishListsStatus = GetWishListsStatus.error;
        toast(context,
            title: response.last, backgroundColor: Colors.red, duration: 2);
      }
    } catch (e) {
      getWishListsStatus = GetWishListsStatus.error;
      toast(context,
          title: 'something have proplem',
          backgroundColor: Colors.red,
          duration: 2);
    } finally {
      notifyListeners();
    }
  }

  /*........................Api addOrRemove Wishlist......................*/
  Future addOrRemoveInWishlistFnc(
      {required BuildContext context, required String productId}) async {
    try {
      final response = await FoodServerClient.post(FoodUrls.addOrRemoveUrl,
          post: true,
          data: {
            'id': productId,
          });
      print('statusCode:::${response.first}');
      if (response.first >= 200 && response.first < 300) {
        whishListModel.wishlists?.product
            ?.removeWhere((item) => item.id == productId);
      } else {
        toast(context,
            title: response.last, backgroundColor: Colors.red, duration: 2);
      }
    } catch (e) {
      toast(context,
          title: 'something have proplem',
          backgroundColor: Colors.red,
          duration: 2);
    } finally {
      notifyListeners();
    }
  }
}

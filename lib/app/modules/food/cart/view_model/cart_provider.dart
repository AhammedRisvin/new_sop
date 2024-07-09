import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sophwe_newmodule/app/helpers/app_router.dart';

import '../../../../backend/food/food_server_client_services.dart';
import '../../../../backend/food/urls.dart';
import '../../../../utils/food/food_enums.dart';
import '../../../widgets/common_widgets.dart';
import '../model/cart_model.dart';

class FoodCartProvider extends ChangeNotifier {
  bool istrue = false;
  int? addOnCurrentIndex;

  addOnTrueOrFalse({bool? value, int? index}) {
    istrue = value ?? false;
    addOnCurrentIndex = index ?? -1;
    notifyListeners();
  }

  /*........................Api integration......................*/
  /*........................Api Cart......................*/

  GetCartStatus getCartStatus = GetCartStatus.initial;

  FoodCartModel foodCartModel = FoodCartModel();

  Future getCartIncrement({
    required BuildContext context,
    required Function() cartfn,
    required String productId,
  }) async {
    try {
      final response = await FoodServerClient.put(
        FoodUrls.cartIncreamentUrl,
        data: {'productId': productId},
      );

      if (response.first >= 200 && response.first < 300) {
        cartfn();
      } else {
        // ignore: use_build_context_synchronously
        toast(context,
            title: response.last, backgroundColor: Colors.red, duration: 2);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      toast(context,
          title: 'something have proplem',
          backgroundColor: Colors.red,
          duration: 2);
    }
  }

  Future getCartDecrement({
    required BuildContext context,
    required Function() cartfn,
    required String productId,
  }) async {
    try {
      final response = await FoodServerClient.put(
        FoodUrls.cartDcreamentUrl,
        data: {'productId': productId},
      );
      if (response.first >= 200 && response.first < 300) {
        cartfn();
      } else {
        // ignore: use_build_context_synchronously
        toast(context,
            title: response.last, backgroundColor: Colors.red, duration: 2);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      toast(context,
          title: 'something have proplem',
          backgroundColor: Colors.red,
          duration: 2);
    }
  }

  Future getCartRemove({
    required BuildContext context,
    required Function() cartfn,
    required String productId,
  }) async {
    try {
      final response = await FoodServerClient.put(
        FoodUrls.cartRemoveUrl,
        data: {'productId': productId},
      );
      if (response.first >= 200 && response.first < 300) {
        // cartfn();
        context.push(AppRouter.cartScreen);
      } else {
        context.push(AppRouter.cartScreen);
        // ignore: use_build_context_synchronously
        toast(context,
            title: response.last, backgroundColor: Colors.red, duration: 2);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      toast(context,
          title: 'something have proplem',
          backgroundColor: Colors.red,
          duration: 2);
    }
  }
}

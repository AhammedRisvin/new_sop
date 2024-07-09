import 'package:flutter/material.dart';
import 'package:sophwe_newmodule/app/backend/food/urls.dart';
import 'package:sophwe_newmodule/app/modules/widgets/common_widgets.dart';

import '../../../../backend/food/food_server_client_services.dart';
import '../../../../utils/food/food_enums.dart';
import '../model/carousel.dart';
import '../model/recommended_mode.dart';

class FoodHomeProvider extends ChangeNotifier {
  List<String> categoryList = ['Non Veg', 'Veg', 'Non'];

  final List<String> sortItems = [
    'Default',
    'Price Low to High',
    'Price High to Low',
  ];

  List<String> filterList = [
    'Filter',
    'Fast delivery',
    'Rating 4.2',
  ];

  List<String> filterListBottomSheet = [
    'Sort',
    'Filter',
    'Veg-Non',
    'Delivery Time',
  ];

  List<String> sortList = [
    'Default',
    'Rating',
    'Price Low to High',
    'Price High to Low',
  ];

  List<String> ratingList = [
    'Default',
    'Rating',
    'Price Low to High',
    'Price High to Low',
  ];

  List<String> vegNonList = [
    'Non Veg',
    'Veg',
  ];

  String? sortSelectedValue;

  sortSelectedValueFnc({String? value}) {
    sortSelectedValue = value;
    notifyListeners();
  }

  int caroselPageChange = 0;

  void nextPage({int? value}) {
    caroselPageChange = value ?? 0;
    notifyListeners();
  }

  int filterCurrentIndex = 0;
  filterCurrentIndexFnc({int? index}) {
    filterCurrentIndex = index ?? 0;
    notifyListeners();
  }

  int sortCurrentIndex = 0;
  sortCurrentIndexFnc({int? index}) {
    sortCurrentIndex = index ?? 0;
    notifyListeners();
  }

  bool ratingValue = false;
  int ratingIndex = 0;
  ratingValueFnc({int index = 0}) {
    ratingValue != ratingValue;
    ratingIndex = index;
    notifyListeners();
  }

  /*........................Api integration......................*/
  /*........................Api categgorys......................*/

  /*........................Api Banners......................*/
  GetFoodcarouselModel carouselModel = GetFoodcarouselModel();
  GetFoodHomeBannersStatus getFoodHomeBannersStatus =
      GetFoodHomeBannersStatus.initial;
  Future getFoodBannersFnc({required BuildContext context}) async {
    try {
      getFoodHomeBannersStatus = GetFoodHomeBannersStatus.loading;
      final response = await FoodServerClient.get(FoodUrls.getFoodHomwBanners);
      print('statusCode:::${response.first}');
      if (response.first >= 200 && response.first < 300) {
        carouselModel = GetFoodcarouselModel.fromJson(response.last);

        getFoodHomeBannersStatus = GetFoodHomeBannersStatus.loaded;
      } else {
        getFoodHomeBannersStatus = GetFoodHomeBannersStatus.error;
        toast(context,
            title: response.last, backgroundColor: Colors.red, duration: 2);
      }
    } catch (e) {
      getFoodHomeBannersStatus = GetFoodHomeBannersStatus.error;
      toast(context,
          title: 'something have proplem',
          backgroundColor: Colors.red,
          duration: 2);
    } finally {
      notifyListeners();
    }
  }

  /*........................Api Recommended......................*/

  GetFoodRecommendedStatus getFoodRecommendedStatus =
      GetFoodRecommendedStatus.initial;
  GetFoodRecommendedModel recommendedModel = GetFoodRecommendedModel();
  Future getFoodRecommendedFnc({required BuildContext context}) async {
    try {
      getFoodRecommendedStatus = GetFoodRecommendedStatus.loading;
      final response = await FoodServerClient.get(FoodUrls.getFoodRecommended);
      print('statusCode:::${response.first}');
      if (response.first >= 200 && response.first < 300) {
        recommendedModel = GetFoodRecommendedModel.fromJson(response.last);

        getFoodRecommendedStatus = GetFoodRecommendedStatus.loaded;
      } else {
        getFoodRecommendedStatus = GetFoodRecommendedStatus.error;
        toast(context,
            title: response.last, backgroundColor: Colors.red, duration: 2);
      }
    } catch (e) {
      getFoodRecommendedStatus = GetFoodRecommendedStatus.error;
      toast(context,
          title: 'something have proplem',
          backgroundColor: Colors.red,
          duration: 2);
    } finally {
      notifyListeners();
    }
  }
}

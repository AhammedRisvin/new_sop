import 'package:flutter/material.dart';

import '../../../../backend/food/food_server_client_services.dart';
import '../../../../backend/food/urls.dart';
import '../../../../utils/food/food_enums.dart';
import '../../../widgets/common_widgets.dart';
import '../../home/model/category_Model.dart';
import '../model/product_model.dart';

class SubcategoryProvider extends ChangeNotifier {
  List<String> categoryList = [
    'All',
    'Doctor',
    'Eletrician',
    'Plumber',
    'Driver'
  ];

  int categoryIndex = -1;
  categoryIndexFnc({int? value}) {
    categoryIndex = value ?? 0;
    notifyListeners();
  }

/*.......................Api integrations....................*/
  /*.......................api call for get category....................*/

  GetFoodCategoryModel categoryModel = GetFoodCategoryModel();
  GetFoodCategirysStatus getFoodCategirysStatus =
      GetFoodCategirysStatus.initial;
  Future getFoodCategirysFnc({required BuildContext context}) async {
    try {
      getFoodCategirysStatus = GetFoodCategirysStatus.loading;
      final response = await FoodServerClient.get(FoodUrls.getFoodCategory);
      print('statusCode:::${response.first}');
      if (response.first >= 200 && response.first < 300) {
        categoryModel = GetFoodCategoryModel.fromJson(response.last);
        print('categoryModel:::${categoryModel.subCategories!.length}');
        getFoodCategirysStatus = GetFoodCategirysStatus.loaded;
      } else {
        getFoodCategirysStatus = GetFoodCategirysStatus.error;
        toast(context,
            title: response.last, backgroundColor: Colors.red, duration: 2);
      }
    } catch (e) {
      getFoodCategirysStatus = GetFoodCategirysStatus.error;
      toast(context,
          title: 'something have proplem',
          backgroundColor: Colors.red,
          duration: 2);
    } finally {
      notifyListeners();
    }
  }

  FoodProductModel foodProductModel = FoodProductModel();
  GetProductsStatus getProductsStatus = GetProductsStatus.initial;
  Future getFoodProductsFnc({
    required BuildContext context,
    String? subCategoryId,
  }) async {
    try {
      getProductsStatus = GetProductsStatus.loading;
      final response = await FoodServerClient.get(
          '${FoodUrls.getProducts}subCategory=$subCategoryId');
      print('statusCode:::${response.first}');
      if (response.first >= 200 && response.first < 300) {
        foodProductModel = FoodProductModel.fromJson(response.last);
        print('categoryModel:::${categoryModel.subCategories!.length}');
        getProductsStatus = GetProductsStatus.loaded;
      } else {
        getProductsStatus = GetProductsStatus.error;
        toast(context,
            title: response.last, backgroundColor: Colors.red, duration: 2);
      }
    } catch (e) {
      getProductsStatus = GetProductsStatus.error;
      toast(context,
          title: 'something have proplem',
          backgroundColor: Colors.red,
          duration: 2);
    } finally {
      notifyListeners();
    }
  }
}

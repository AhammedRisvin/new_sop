import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/extentions.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/food/food_enums.dart';
import '../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/order_and_review_product_card.dart';
import '../../widgets/shimmer.dart';
import '../view_model/favourite_provider.dart';

class FoodFavouritesScreen extends StatefulWidget {
  const FoodFavouritesScreen({super.key});

  @override
  State<FoodFavouritesScreen> createState() => _FoodFavouritesScreenState();
}

class _FoodFavouritesScreenState extends State<FoodFavouritesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavouriteProvider>().getFoodWishListFnc(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, _) {
        return Scaffold(
          backgroundColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          appBar: PreferredSize(
            preferredSize: Size(Responsive.width * 100, Responsive.height * 6),
            child: const CommonAppBarWidgets(title: 'Favourites'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<FavouriteProvider>(builder: (context, obj, _) {
                    return obj.getWishListsStatus == GetWishListsStatus.loading
                        ? const OrderAndReviewShimmer()
                        : obj.whishListModel.wishlists?.product == null ||
                                obj.whishListModel.wishlists!.product!.isEmpty
                            ? const Text('list is empty')
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final products = obj.whishListModel.wishlists
                                      ?.product?[index];
                                  return OrderAndReviewCardWidgets(
                                    isFavorite: true,
                                    index: index,
                                    product: products,
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    SizeBoxH(Responsive.height * 3),
                                itemCount: obj.whishListModel.wishlists?.product
                                        ?.length ??
                                    0);
                  }),
                  SizeBoxH(Responsive.height * 1),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

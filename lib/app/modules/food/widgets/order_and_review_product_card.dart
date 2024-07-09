import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/app_router.dart';
import 'package:sophwe_newmodule/app/modules/food/favourites/view_model/favourite_provider.dart';

import '../../../helpers/extentions.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../pharma/home/home screen/view model/theme_provider.dart';
import '../../widgets/common_widgets.dart';
import '../cart/widgets/food_remove_show_dialog.dart';
import '../favourites/model/wishlist_model.dart';

class OrderAndReviewCardWidgets extends StatelessWidget {
  final bool isOrder;
  final bool isFavorite;
  final int? index;
  final Product? product;
  const OrderAndReviewCardWidgets(
      {this.isFavorite = false,
      this.isOrder = false,
      this.index,
      this.product,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
        selector: (p0, p1) => p1.isDarkModeOn,
        builder: (context, isDarkModeOn, _) {
          return CommonInkwell(
            onTap: () {
              if (isOrder) {
                context.push(AppRouter.foodOrderHistoryDetailsScreen);
              } else {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => FoodOrderHistoryDetailsScreen()));
              }
            },
            child: Container(
              width: Responsive.width * 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:
                    isDarkModeOn ? AppConstants.darkGrey : AppConstants.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x21000000), // Equivalent to #00000021
                    offset: Offset(0, 0),
                    blurRadius: 4,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  CachedImageWidget(
                    imageUrl: product?.image ?? '',
                    width: Responsive.width * 22,
                    height: Responsive.height * 10,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  SizeBoxV(Responsive.width * 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonTextWidget(
                              color: isDarkModeOn
                                  ? AppConstants.darkPrimaryColor
                                  : AppConstants.darkBlue,
                              text: product?.productName ?? '',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              maxLines: 1,
                              overFlow: TextOverflow.ellipsis,
                            ),
                            isFavorite
                                ? Consumer<FavouriteProvider>(
                                    builder: (context, obj, _) {
                                    return CommonInkwell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return FoodConfirmationWidget(
                                              title: "Remove Item?",
                                              message:
                                                  "Are you sure yow want to remove this item?",
                                              onTap: () {
                                                obj.addOrRemoveInWishlistFnc(
                                                    context: context,
                                                    productId:
                                                        product?.id ?? '');
                                                context.pop();
                                              },
                                              isDarkModeOn: isDarkModeOn,
                                            );
                                          },
                                        );
                                      },
                                      child: Icon(Icons.favorite,
                                          color: isDarkModeOn
                                              ? AppConstants.darkPrimaryColor
                                              : AppConstants.lightPrimaryColor,
                                          size: 20),
                                    );
                                  })
                                : const SizedBox.shrink()
                          ],
                        ),
                        SizeBoxH(Responsive.height * 0.5),
                        isOrder
                            ? CommonTextWidget(
                                color: isDarkModeOn
                                    ? AppConstants.white
                                    : AppConstants.black,
                                text: "30 July 2024 -13:15",
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                maxLines: 1,
                                overFlow: TextOverflow.ellipsis,
                              )
                            : CommonTextWidget(
                                color: isDarkModeOn
                                    ? AppConstants.white
                                    : AppConstants.black,
                                text: product?.description ?? '',
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                maxLines: 2,
                                overFlow: TextOverflow.ellipsis,
                              ),
                        SizeBoxH(Responsive.height * 0.5),
                        Row(
                          children: [
                            isFavorite
                                ? const SizedBox.shrink()
                                : Row(
                                    mainAxisAlignment: isOrder
                                        ? MainAxisAlignment.spaceBetween
                                        : MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: AppConstants.yellow,
                                        size: 16,
                                      ),
                                      CommonTextWidget(
                                        color: isDarkModeOn
                                            ? AppConstants.white
                                            : AppConstants.black,
                                        text: isOrder
                                            ? "${product?.ratings ?? ''} Rated"
                                            : "${product?.ratings ?? ''}",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                            isOrder
                                ? SizeBoxV(Responsive.width * 3)
                                : const SizedBox.shrink(),
                            isOrder || isFavorite
                                ? CommonTextWidget(
                                    color: isDarkModeOn
                                        ? AppConstants.darkPrimaryColor
                                        : AppConstants.darkBlue,
                                    text:
                                        '${product?.price} ${product?.price ?? ''}',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  )
                                : CommonTextWidget(
                                    color: isDarkModeOn
                                        ? AppConstants.darkPrimaryColor
                                        : AppConstants.darkBlue,
                                    text: "13 September 2023",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    maxLines: 2,
                                    overFlow: TextOverflow.ellipsis,
                                  ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

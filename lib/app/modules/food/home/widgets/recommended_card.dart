import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/extentions.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../widgets/common_widgets.dart';
import '../../widgets/productcardimage.dart';
import '../model/recommended_mode.dart';

class FoodHomeRecomendedProductWidget extends StatelessWidget {
  final UpdatedProduct? product;
  const FoodHomeRecomendedProductWidget({
    super.key,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
        selector: (_, value) => value.isDarkModeOn,
        builder: (context, isDarkModeOn, _) {
          return Column(
            children: [
              ProductCardImage(
                url: product?.image ?? '',
                radius: 10,
                isWhishlist: true,
              ),
              Container(
                width: Responsive.width * 45,
                decoration: BoxDecoration(
                    color: isDarkModeOn
                        ? const Color(0xff141313)
                        : AppConstants.white,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: isDarkModeOn
                        ? null
                        : [
                            const BoxShadow(
                              color:
                                  Color(0x1F000000), // Equivalent to #0000001F
                              offset: Offset(0, 0),
                              blurRadius: 4,
                            ),
                          ]),
                padding: const EdgeInsets.only(
                    left: 9, right: 9, top: 11, bottom: 19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            // width: Responsive.width * 15,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: isDarkModeOn
                                  ? const Color(0xff333333)
                                  : const Color(0xff38651a).withOpacity(0.1),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: CommonTextWidget(
                              overFlow: TextOverflow.ellipsis,
                              color: isDarkModeOn
                                  ? AppConstants.white
                                  : AppConstants.categoryBlue,
                              text: product?.subCategory ?? '',
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Image.asset(
                              AppImages.fireImg,
                              width: 17,
                              height: 17,
                            ),
                            CommonTextWidget(
                              color: isDarkModeOn
                                  ? AppConstants.white
                                  : AppConstants.black,
                              text: '${product?.cookingTime} mins',
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              overFlow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizeBoxH(Responsive.height * 1),
                    CommonTextWidget(
                      align: TextAlign.start,
                      overFlow: TextOverflow.ellipsis,
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      text: product?.name ?? '',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Responsive.width * 40,
                          child: CommonTextWidget(
                            align: TextAlign.start,
                            overFlow: TextOverflow.ellipsis,
                            color: isDarkModeOn
                                ? AppConstants.darkPrimaryColor
                                : AppConstants.darkGrey,
                            text:
                                '${product?.currencyCode ?? ''} ${product?.price?.toStringAsFixed(2) ?? ''}',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: AppConstants.darkYellow,
                              size: 15,
                            ),
                            SizedBox(
                              width: Responsive.width * 25,
                              child: CommonTextWidget(
                                color: isDarkModeOn
                                    ? AppConstants.white
                                    : AppConstants.black,
                                text:
                                    "${product?.rating ?? ''} (${product?.reviews ?? ''} +reviews) ",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                overFlow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              AppImages.cartImg,
                              width: 25,
                              height: 25,
                              color: isDarkModeOn
                                  ? AppConstants.darkPrimaryColor
                                  : AppConstants.black,
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}

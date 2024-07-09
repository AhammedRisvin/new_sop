import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../helpers/app_router.dart';
import '../../../helpers/extentions.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../pharma/home/home screen/view model/theme_provider.dart';
import '../../widgets/common_widgets.dart';
import '../subcategory/model/product_model.dart';

class ItemsCard extends StatelessWidget {
  final Product? product;
  const ItemsCard({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
        selector: (_, value) => value.isDarkModeOn,
        builder: (context, isDarkModeOn, _) {
          return CommonInkwell(
            onTap: () {
              context.push(AppRouter.foodproductDetailScreen);
            },
            child: Container(
              width: Responsive.width * 40,
              decoration: BoxDecoration(
                color:
                    isDarkModeOn ? const Color(0xff2B2B2B) : AppConstants.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x26000000), // Equivalent to #00000026
                    offset: Offset(0, 0),
                    blurRadius: 4,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: AppConstants.darkYellow,
                            size: 12,
                          ),
                          CommonTextWidget(
                            color: isDarkModeOn
                                ? AppConstants.white
                                : AppConstants.black,
                            text:
                                '${product?.ratings?.average ?? ''}(${product?.ratings?.count})+',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.darkBlue,
                        child: Icon(Icons.favorite_border,
                            color:
                                isDarkModeOn ? Colors.red : AppConstants.white,
                            size: 20),
                      )
                    ],
                  ),
                  SizeBoxH(Responsive.height * 1.5),
                  Center(
                    child: CachedImageWidget(
                      imageUrl: product?.images?.first ?? '',
                      height: Responsive.height * 10,
                      width: Responsive.width * 22,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  SizeBoxH(Responsive.height * 1.5),
                  CommonTextWidget(
                    color:
                        isDarkModeOn ? AppConstants.white : AppConstants.black,
                    text: product?.productName ?? '',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    align: TextAlign.start,
                    overFlow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizeBoxH(Responsive.height * 0.5),
                  CommonTextWidget(
                    color: isDarkModeOn
                        ? AppConstants.white
                        : AppConstants.darkBlue,
                    text: ' ${product?.price ?? ''}',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    align: TextAlign.center,
                    overFlow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )
                ],
              ),
            ),
          );
        });
  }
}

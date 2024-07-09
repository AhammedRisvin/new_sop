import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/extentions.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../widgets/common_widgets.dart';
import '../../restaurants/widgets/product_image_widgets.dart';

class ProductCard extends StatelessWidget {
  final bool isEmpty;
  final bool reviewRight;
  final bool isRecommented;
  const ProductCard(
      {this.isEmpty = false,
      this.reviewRight = false,
      this.isRecommented = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
        selector: (_, value) => value.isDarkModeOn,
        builder: (context, isDarkModeOn, _) {
          return Column(
            children: [
              ProductImageContainer(
                reviewRight: true,
                isEmpty: isEmpty,
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
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x21000000), // Equivalent to #00000021
                      offset: Offset(0, 0),
                      blurRadius: 3,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextWidget(
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      text: 'Pumpking Restaurant',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      overFlow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizeBoxH(Responsive.height * 0.5),
                    isRecommented
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonTextWidget(
                                color: isDarkModeOn
                                    ? AppConstants.white
                                    : AppConstants.black,
                                text: 'Chicken biriyani full ',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                overFlow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              SizeBoxH(Responsive.height * 0.5),
                              CommonTextWidget(
                                color: isDarkModeOn
                                    ? AppConstants.white
                                    : AppConstants.black,
                                text: '15 to 30 mins',
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                overFlow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              SizeBoxH(Responsive.height * 0.5),
                              CommonTextWidget(
                                color: isDarkModeOn
                                    ? AppConstants.white
                                    : AppConstants.black,
                                text: '2 leg piece + 2 eggs + mayonise',
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                overFlow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              SizeBoxH(Responsive.height * 1.5),
                            ],
                          )
                        : CommonTextWidget(
                            color: isDarkModeOn
                                ? AppConstants.white
                                : AppConstants.black,
                            text: '4.2 (100)+',
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isRecommented
                            ? CommonTextWidget(
                                color: isDarkModeOn
                                    ? AppConstants.white
                                    : AppConstants.darkBlue,
                                text: 'AED 57.75',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: isDarkModeOn
                                        ? const Color(0xff272626)
                                        : AppConstants.darkBlue,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 5, left: 6, right: 9),
                                margin:
                                    EdgeInsets.only(top: Responsive.height * 1),
                                child: CommonTextWidget(
                                  color: isDarkModeOn
                                      ? AppConstants.white
                                      : AppConstants.darkBlue,
                                  text: 'AED 57.75',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                        SizeBoxV(Responsive.width * 1),
                        Image.asset(
                          AppImages.cartImg,
                          width: 20,
                          height: 20,
                          color: isDarkModeOn
                              ? AppConstants.darkPrimaryColor
                              : AppConstants.darkBlue,
                        )
                      ],
                    ),
                    SizeBoxH(Responsive.height * 1),
                  ],
                ),
              ),
            ],
          );
        });
  }
}

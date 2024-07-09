import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/extentions.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../widgets/common_widgets.dart';
import '../../widgets/productcardimage.dart';

class FoodRestaurentWidget extends StatelessWidget {
  const FoodRestaurentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
        selector: (_, value) => value.isDarkModeOn,
        builder: (context, isDarkModeOn, _) {
          return Column(
            children: [
              const ProductCardImage(
                url:
                    'https://t4.ftcdn.net/jpg/04/95/28/65/240_F_495286577_rpsT2Shmr6g81hOhGXALhxWOfx1vOQBa.jpg',
                isShowWhishlist: false,
                isWhishlist: false,
              ),
              Container(
                width: Responsive.width * 45,
                decoration: BoxDecoration(
                    color: isDarkModeOn
                        ? const Color(0xff141313)
                        : AppConstants.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
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
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CommonTextWidget(
                            color: isDarkModeOn
                                ? AppConstants.white
                                : AppConstants.black,
                            text: 'Chackoshhhhhhhhhhhhhhhhhhhhhhhhhh',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            overFlow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: AppConstants.darkYellow,
                              size: 18,
                            ),
                            const SizeBoxV(3),
                            CommonTextWidget(
                              color: isDarkModeOn
                                  ? AppConstants.white
                                  : AppConstants.black,
                              text: '4.2',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            )
                          ],
                        )
                      ],
                    ),
                    SizeBoxH(Responsive.height * .5),
                    SizedBox(
                      width: Responsive.width * 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.schedule,
                            color: isDarkModeOn
                                ? AppConstants.white
                                : AppConstants.black,
                            size: 15,
                          ),
                          const SizeBoxV(3),
                          Expanded(
                            child: CommonTextWidget(
                              color: isDarkModeOn
                                  ? AppConstants.white
                                  : AppConstants.black,
                              text:
                                  '15 to 30 minsssssssssssssssssssssssssssssssssssssssssss',
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              overFlow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizeBoxH(Responsive.height * 0.5),
                    SizedBox(
                      height: Responsive.height * 1.6,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => const SizeBoxV(5),
                        itemBuilder: (context, index) => CommonTextWidget(
                          color: isDarkModeOn
                              ? AppConstants.darkPrimaryColor
                              : AppConstants.darkBlue,
                          text: 'Beverages,',
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          overFlow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    SizeBoxH(Responsive.height * 0.3),
                    Row(
                      children: [
                        Image.asset(
                          AppImages.locationOrangeIcon,
                          color: isDarkModeOn
                              ? AppConstants.darkPrimaryColor
                              : AppConstants.darkBlue,
                        ),
                        SizeBoxV(Responsive.width * 1),
                        Expanded(
                          child: CommonTextWidget(
                            color: isDarkModeOn
                                ? AppConstants.white
                                : AppConstants.black,
                            text:
                                'Areekod Localitylllllllllllllllllllllllllllll   1.4 Km',
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            overFlow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    SizeBoxH(Responsive.height * 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonButton(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            isDarkMode: isDarkModeOn,
                            borderRadius: BorderRadius.circular(5),
                            ontap: () {},
                            text: "Order now",
                            textColor: AppConstants.white,
                            width: Responsive.width * 37,
                            height: Responsive.height * 3.5),
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/modules/food/widgets/items_card.dart';

import '../../../../helpers/app_router.dart';
import '../../../../helpers/extentions.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../widgets/common_widgets.dart';
import '../../widgets/add_on_widgets.dart';
import '../view_model/prdocut_detail_provider.dart';

class FoodcProductDetailsScreen extends StatelessWidget {
  const FoodcProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, _) => Scaffold(
        backgroundColor: isDarkModeOn ? AppConstants.black : AppConstants.white,
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 1.6,
                child: Stack(
                  children: [
                    Container(
                      height: Responsive.height * 100,
                      width: Responsive.width * 100,
                      color: const Color(0xffEAEAEA),
                      child: Column(
                        children: [
                          CachedImageWidget(
                            imageUrl:
                                "https://t4.ftcdn.net/jpg/04/95/28/65/240_F_495286577_rpsT2Shmr6g81hOhGXALhxWOfx1vOQBa.jpg",
                            width: Responsive.width * 100,
                            height: Responsive.height * 48,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 35,
                      left: 1,
                      right: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: isDarkModeOn
                                  ? AppConstants.white
                                  : AppConstants.black,
                            ),
                          ),
                          Row(
                            children: [
                              Switch(
                                value: isDarkModeOn,
                                onChanged: (value) {
                                  Provider.of<ThemeProvider>(context,
                                          listen: false)
                                      .updateTheme();
                                },
                              ),
                              CommonInkwell(
                                onTap: () {},
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: AppConstants.white,
                                  child: Icon(Icons.favorite_border,
                                      color: AppConstants.black, size: 25),
                                ),
                              ),
                              SizeBoxV(Responsive.width * 3),
                              const CircleAvatar(
                                radius: 20,
                                backgroundColor: AppConstants.white,
                                child: Icon(Icons.share,
                                    color: AppConstants.black, size: 25),
                              ),
                              SizeBoxV(Responsive.width * 3),
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: Responsive.height * 40,
                      child: Container(
                        width: Responsive.width * 100,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: isDarkModeOn
                              ? AppConstants.black
                              : AppConstants.white,
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTextWidget(
                              color: isDarkModeOn
                                  ? AppConstants.white
                                  : AppConstants.black,
                              text: "textt",
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            SizeBoxH(Responsive.height * 1.5),
                            CommonTextWidget(
                              color: isDarkModeOn
                                  ? AppConstants.subtextColor
                                  : AppConstants.subtextColor,
                              text:
                                  "MCT oil, which stands for medium-chain triglyceride oil, is a type of dietary fat that is composed of medium-length chains of fatty acids. These fattY acids are called medium-chain triglycerides.",
                              fontSize: 12,
                              maxLines: null,
                              align: TextAlign.start,
                              fontWeight: FontWeight.w500,
                            ),
                            SizeBoxH(Responsive.height * 2),
                            Row(
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
                                  text: "4.7 ",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                CommonTextWidget(
                                  color: isDarkModeOn
                                      ? AppConstants.white
                                      : AppConstants.black,
                                  text: "(100+) ",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            SizeBoxH(Responsive.height * 1),
                            CommonInkwell(
                              onTap: () {
                                context.pushNamed(AppRouter.foodReviewScreen);
                              },
                              child: Row(
                                children: [
                                  CommonTextWidget(
                                    color: isDarkModeOn
                                        ? AppConstants.white
                                        : AppConstants.black,
                                    text: "View Reviews",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: isDarkModeOn
                                        ? AppConstants.white
                                        : AppConstants.black,
                                    size: 14,
                                  )
                                ],
                              ),
                            ),
                            SizeBoxH(Responsive.height * 1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonTextWidget(
                                  color: isDarkModeOn
                                      ? AppConstants.darkPrimaryColor
                                      : AppConstants.darkBlue,
                                  text: "AED 31.00",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                Consumer<ProductDetailProvider>(
                                    builder: (context, obj, _) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CommonInkwell(
                                        onTap: () {
                                          obj.countDecreament();
                                        },
                                        child: Container(
                                          width: Responsive.width * 9,
                                          height: Responsive.height * 4,
                                          decoration: BoxDecoration(
                                              color: isDarkModeOn
                                                  ? AppConstants.darkGrey
                                                  : AppConstants.darkBlue,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: const Icon(
                                            Icons.remove,
                                            color: AppConstants.white,
                                          ),
                                        ),
                                      ),
                                      SizeBoxV(Responsive.width * 3),
                                      CommonTextWidget(
                                        color: isDarkModeOn
                                            ? AppConstants.white
                                            : AppConstants.darkBlue,
                                        text: '${obj.count}',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      SizeBoxV(Responsive.width * 3),
                                      CommonInkwell(
                                        onTap: () {
                                          obj.countIncrement();
                                        },
                                        child: Container(
                                          width: Responsive.width * 9,
                                          height: Responsive.height * 4,
                                          decoration: BoxDecoration(
                                              color: isDarkModeOn
                                                  ? AppConstants.darkGrey
                                                  : AppConstants.darkBlue,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: const Icon(
                                            Icons.add,
                                            color: AppConstants.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                })
                              ],
                            ),
                            SizeBoxH(Responsive.height * 2),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonTextWidget(
                                  color: isDarkModeOn
                                      ? AppConstants.white
                                      : AppConstants.black,
                                  text: "Related Products",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                SizeBoxH(Responsive.height * 1),
                                CommonTextWidget(
                                  color: isDarkModeOn
                                      ? AppConstants.subtextColor
                                      : AppConstants.subtextColor,
                                  text: "People usually order these as well",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                SizeBoxH(Responsive.height * 2),
                                SizedBox(
                                  height: Responsive.height * 30,
                                  child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      return const ItemsCard();
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizeBoxV(10),
                                    itemCount: 10,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                  ),
                                ),
                              ],
                            ),
                            SizeBoxH(Responsive.height * 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      AppImages.chaticon,
                                      color: isDarkModeOn
                                          ? AppConstants.white
                                          : AppConstants.black,
                                    ),
                                    SizeBoxV(Responsive.width * 4),
                                    CommonTextWidget(
                                      align: TextAlign.start,
                                      fontWeight: FontWeight.w500,
                                      color: isDarkModeOn
                                          ? AppConstants.white
                                          : AppConstants.black,
                                      text: "Any special requests?",
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                                CommonTextWidget(
                                  align: TextAlign.start,
                                  fontWeight: FontWeight.w500,
                                  color: isDarkModeOn
                                      ? AppConstants.darkPrimaryColor
                                      : AppConstants.darkBlue,
                                  text: "Add note",
                                  fontSize: 14,
                                ),
                              ],
                            ),
                            SizeBoxH(Responsive.height * 2),
                            CommonTextWidget(
                              color: isDarkModeOn
                                  ? AppConstants.white
                                  : AppConstants.black,
                              text: 'Choice of Add on',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            const AddOnWdgets(),
                            SizeBoxH(Responsive.height * 2),
                            CommonButton(
                              ontap: () {},
                              height: Responsive.height * 6,
                              text: "Add to cart",
                              isDarkMode: isDarkModeOn,
                            ),
                            SizeBoxH(Responsive.height * 2),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

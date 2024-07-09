import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/app_router.dart';
import '../../../../helpers/extentions.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../widgets/common_widgets.dart';
import '../../home/widgets/productcard.dart';
import '../../widgets/carousel_widgets.dart';
import '../../widgets/searchwidgets.dart';
import '../../widgets/toppicscard.dart';

class ListOfCategorysWidgets extends StatelessWidget {
  const ListOfCategorysWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
        selector: (_, value) => value.isDarkModeOn,
        builder: (context, isDarkModeOn, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CarouserlWidgets(),
              SizeBoxH(Responsive.height * 2.8),
              const Searchwidgets(),
              SizeBoxH(Responsive.height * 2.8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonTextWidget(
                          color: isDarkModeOn
                              ? AppConstants.darkPrimaryColor
                              : AppConstants.black,
                          text: 'All Dishes',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        CommonInkwell(
                          onTap: () {
                            context.push(AppRouter.allDishesScreen);
                          },
                          child: CommonTextWidget(
                            color: isDarkModeOn
                                ? AppConstants.darkPrimaryColor
                                : AppConstants.black,
                            text: 'See All',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizeBoxH(Responsive.height * 2),
                  Consumer(builder: (context, obj, _) {
                    return SizedBox(
                      height: Responsive.height * 16,
                      child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 20),
                          itemBuilder: (context, index) {
                            return CommonInkwell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Container(
                                    width: Responsive.width * 18,
                                    height: Responsive.height * 9,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppConstants.black,
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: CachedImageWidget(
                                      imageUrl:
                                          'https://t4.ftcdn.net/jpg/04/95/28/65/240_F_495286577_rpsT2Shmr6g81hOhGXALhxWOfx1vOQBa.jpg',
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  SizeBoxH(Responsive.height * 0.7),
                                  SizedBox(
                                    width: Responsive.width * 14,
                                    child: CommonTextWidget(
                                      color: isDarkModeOn
                                          ? AppConstants.white
                                          : AppConstants.black,
                                      text: 'Chicken curry & rice',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      overFlow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizeBoxV(Responsive.width * 5),
                          itemCount: 4),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CommonTextWidget(
                      color: isDarkModeOn
                          ? AppConstants.darkPrimaryColor
                          : AppConstants.black,
                      text: 'Top pics',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      align: TextAlign.start,
                    ),
                  ),
                  SizeBoxH(Responsive.height * 2),
                  SizedBox(
                    height: Responsive.height * 25,
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        separatorBuilder: (context, index) =>
                            SizeBoxV(Responsive.width * 5),
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return const ToppicscardWdgets();
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonTextWidget(
                              color: isDarkModeOn
                                  ? AppConstants.white
                                  : AppConstants.black,
                              text: 'Recomended (12)',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            CommonTextWidget(
                              color: isDarkModeOn
                                  ? AppConstants.white
                                  : AppConstants.black,
                              text: 'View All',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        Consumer(builder: (context, obj, _) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 4,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 15,
                                    childAspectRatio: 5 / 7,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              return CommonInkwell(
                                onTap: () {},
                                child: const ProductCard(
                                  isRecommented: true,
                                  reviewRight: true,
                                ),
                              );
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CommonTextWidget(
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      text: 'Beverages ( 20 )',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizeBoxH(Responsive.height * 2),
                  Consumer(builder: (context, obj, _) {
                    return SizedBox(
                      height: Responsive.height * 25,
                      child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 20),
                          itemBuilder: (context, index) {
                            return const ProductCard(
                              isEmpty: true,
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizeBoxV(Responsive.width * 5),
                          itemCount: 5),
                    );
                  }),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: CommonTextWidget(
                      color: AppConstants.black,
                      text: ' Shake & Juices ( 16 )',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizeBoxH(Responsive.height * 2),
                  Consumer(builder: (context, obj, _) {
                    return SizedBox(
                      height: Responsive.height * 25,
                      child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 20),
                          itemBuilder: (context, index) {
                            return const ProductCard(
                              isEmpty: true,
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizeBoxV(Responsive.width * 5),
                          itemCount: 5),
                    );
                  }),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: CommonTextWidget(
                      color: AppConstants.black,
                      text: ' Sand wich & Burgers ( 6 )',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizeBoxH(Responsive.height * 2),
                  Consumer(builder: (context, obj, _) {
                    return SizedBox(
                      height: Responsive.height * 25,
                      child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 20),
                          itemBuilder: (context, index) {
                            return const ProductCard(
                              isEmpty: true,
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizeBoxV(Responsive.width * 5),
                          itemCount: 5),
                    );
                  }),
                ],
              ),
            ],
          );
        });
  }
}

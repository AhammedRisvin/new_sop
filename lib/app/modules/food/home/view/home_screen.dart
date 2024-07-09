import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/app_router.dart';
import 'package:sophwe_newmodule/app/helpers/extentions.dart';
import 'package:sophwe_newmodule/app/modules/food/home/view_model/food_home.dart';
import 'package:sophwe_newmodule/app/modules/food/home/widgets/shimmer.dart';

import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/food/food_enums.dart';
import '../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../widgets/common_widgets.dart';
import '../../widgets/carousel_widgets.dart';
import '../../widgets/searchwidgets.dart';
import '../widgets/altration_widgets.dart';
import '../widgets/recommended_card.dart';
import '../widgets/restuarend_card.dart';

class FoodHomeScreen extends StatefulWidget {
  const FoodHomeScreen({super.key});

  @override
  State<FoodHomeScreen> createState() => _FoodHomeScreenState();
}

class _FoodHomeScreenState extends State<FoodHomeScreen> {
  @override
  void initState() {
    super.initState();

    // context.read<FoodHomeProvider>().getFoodCategirysFnc(context: context);
    context.read<FoodHomeProvider>().getFoodRecommendedFnc(context: context);
    context.read<FoodHomeProvider>().getFoodBannersFnc(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
        selector: (_, value) => value.isDarkModeOn,
        builder: (context, isDarkModeOn, _) {
          return Scaffold(
              backgroundColor:
                  isDarkModeOn ? AppConstants.black : AppConstants.white,
              appBar: PreferredSize(
                preferredSize:
                    Size(Responsive.width * 100, Responsive.height * 10),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 18, right: 18, top: Responsive.height * 6),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Responsive.width * 45,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset(AppImages.locationOrangeIcon),
                                  SizeBoxV(Responsive.width * 2),
                                  Expanded(
                                    child: CommonTextWidget(
                                      color: isDarkModeOn
                                          ? AppConstants.white
                                          : AppConstants.black,
                                      text:
                                          'Calicut ,Town plazaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      overFlow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                              SizeBoxH(Responsive.height * 0.5),
                              CommonTextWidget(
                                color: isDarkModeOn
                                    ? AppConstants.white
                                    : AppConstants.black,
                                text:
                                    'Calicut ,Town plaza, kerala indiaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                overFlow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                        CommonInkwell(
                          onTap: () {
                            context.push(AppRouter.foodOrderHistoryScreen);
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                AppImages.orderHistoryIcon,
                                color: isDarkModeOn
                                    ? AppConstants.white
                                    : AppConstants.black,
                              ),
                              SizeBoxH(Responsive.height * 0.7),
                              CommonTextWidget(
                                color: isDarkModeOn
                                    ? AppConstants.white
                                    : AppConstants.black,
                                text: 'Order History',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        CommonInkwell(
                          onTap: () {
                            context.push(AppRouter.foodFavouritesScreen);
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.favorite_outline,
                                color: isDarkModeOn
                                    ? AppConstants.white
                                    : AppConstants.black,
                              ),
                              SizeBoxH(Responsive.height * 0.7),
                              CommonTextWidget(
                                color: isDarkModeOn
                                    ? AppConstants.white
                                    : AppConstants.black,
                                text: 'Favorites',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        CommonInkwell(
                          onTap: () {
                            context.push(AppRouter.foodCartScreen);
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                AppImages.shoppingCart,
                                color: isDarkModeOn
                                    ? AppConstants.white
                                    : AppConstants.black,
                              ),
                              SizeBoxH(Responsive.height * 0.7),
                              CommonTextWidget(
                                color: isDarkModeOn
                                    ? AppConstants.white
                                    : AppConstants.black,
                                text: 'Cart',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizeBoxH(Responsive.height * 1),
                    const Searchwidgets(),
                    SizeBoxH(Responsive.height * 2),
                    Consumer<FoodHomeProvider>(builder: (context, obj, _) {
                      return obj.getFoodHomeBannersStatus ==
                              GetFoodHomeBannersStatus.loading
                          ? CarouselShimmer(
                              height: Responsive.height * 18,
                            )
                          : obj.carouselModel.topBanners == null ||
                                  obj.carouselModel.topBanners!.isEmpty
                              ? const Text('carosel isEmpty')
                              : CarouserlWidgets(
                                  imageUrl: obj
                                      .carouselModel
                                      .topBanners?[obj.caroselPageChange]
                                      .banner,
                                  caroselLength:
                                      obj.carouselModel.topBanners?.length ??
                                          0);
                    }),
                    SizeBoxH(Responsive.height * 2),
                    CategoryAndViewAll(
                      onTap: () {
                        context.push(AppRouter.foodCategoryScreen);
                      },
                    ),
                    SizeBoxH(Responsive.height * 2),
                    Consumer<FoodHomeProvider>(builder: (context, obj, _) {
                      return Container(
                        height: Responsive.height * 15,
                        alignment: Alignment.centerLeft,
                        child:
                            // obj.getFoodCategirysStatus ==
                            //         GetFoodCategirysStatus.loading
                            //     ? const CategorysShimmer()
                            //     : obj.categoryModel.subCategories == null ||
                            //             obj.categoryModel.subCategories!.isEmpty
                            //         ? const Text('Nocategorys')
                            //         :
                            ListView.separated(
                                shrinkWrap: true,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return CommonInkwell(
                                    onTap: () {
                                      context
                                          .push(AppRouter.foodCategoryScreen);
                                    },
                                    child: Column(
                                      children: [
                                        CachedImageWidget(
                                          imageUrl: AppImages.splashLogo,
                                          height: Responsive.height * 10,
                                          width: Responsive.width * 22,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        SizeBoxH(Responsive.height * 0.7),
                                        SizedBox(
                                          width: Responsive.width * 14,
                                          child: CommonTextWidget(
                                              color: isDarkModeOn
                                                  ? AppConstants.white
                                                  : AppConstants.categoryGrey,
                                              text: obj.categoryList[index],
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              overFlow: TextOverflow.fade,
                                              maxLines: 2,
                                              letterSpacing: -0.3,
                                              height: 5),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    SizeBoxV(Responsive.width * 5),
                                itemCount: obj.categoryList.length),
                      );
                    }),
                    SizeBoxH(Responsive.height * 2),
                    const CategoryAndViewAll(
                      isrecommeded: true,
                    ),
                    Consumer<FoodHomeProvider>(builder: (context, obj, _) {
                      return Container(
                        margin: const EdgeInsets.only(
                          top: 15,
                        ),
                        height: Responsive.height * 30,
                        child: obj.getFoodRecommendedStatus ==
                                GetFoodRecommendedStatus.loading
                            ? const RecommendedShimmer()
                            : obj.recommendedModel.updatedProducts == null ||
                                    obj.recommendedModel.updatedProducts!
                                        .isEmpty
                                ? const Text('no Product')
                                : ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    padding: const EdgeInsets.only(left: 20),
                                    separatorBuilder: (context, index) =>
                                        const SizeBoxV(20),
                                    itemCount: obj.recommendedModel
                                            .updatedProducts?.length ??
                                        0,
                                    reverse: true,
                                    itemBuilder: (context, index) {
                                      final product = obj.recommendedModel
                                          .updatedProducts?[index];
                                      return CommonInkwell(
                                        onTap: () {
                                          context.push(AppRouter
                                              .restaurantsDetailsScreen);
                                        },
                                        child: FoodHomeRecomendedProductWidget(
                                          product: product,
                                        ),
                                      );
                                    },
                                  ),
                      );
                    }),
                    Consumer<FoodHomeProvider>(builder: (context, obj, _) {
                      return obj.getFoodHomeBannersStatus ==
                              GetFoodHomeBannersStatus.loading
                          ? CarouselShimmer(
                              height: Responsive.height * 18,
                            )
                          : obj.carouselModel.bottomBanners == null ||
                                  obj.carouselModel.bottomBanners!.isEmpty
                              ? const Text('carosel isEmpty')
                              : CarouserlWidgets(
                                  hieght: Responsive.height * 18,
                                  caroselLength:
                                      obj.carouselModel.bottomBanners?.length ??
                                          0,
                                  imageUrl: obj
                                      .carouselModel
                                      .bottomBanners?[obj.caroselPageChange]
                                      .banner,
                                );
                    }),
                    SizeBoxH(Responsive.height * 2),
                    const AltrationWidgets(),
                    Container(
                      margin: EdgeInsets.only(top: Responsive.height * 2),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonTextWidget(
                            color: isDarkModeOn
                                ? AppConstants.white
                                : AppConstants.black,
                            text: 'Restaurants to explore',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          SizeBoxH(Responsive.height * 2),
                          GridView.builder(
                            shrinkWrap: true,
                            itemCount: 6,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: Responsive.height * 0.072,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              return const FoodRestaurentWidget();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}

class CategoryAndViewAll extends StatelessWidget {
  final bool isrecommeded;
  final void Function()? onTap;

  const CategoryAndViewAll({this.isrecommeded = false, super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
        selector: (_, value) => value.isDarkModeOn,
        builder: (context, isDarkModeOn, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonTextWidget(
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                  text: isrecommeded ? 'Recommended' : 'Catogeries',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                CommonInkwell(
                  onTap: onTap,
                  child: CommonTextWidget(
                    color: isDarkModeOn
                        ? AppConstants.darkPrimaryColor
                        : AppConstants.categoryBlue,
                    text: 'See All',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        });
  }
}

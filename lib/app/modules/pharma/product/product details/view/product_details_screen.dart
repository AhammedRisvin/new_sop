import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/app_router.dart';
import 'package:sophwe_newmodule/app/helpers/extentions.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/home%20screen/view%20model/home_provider.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/home%20screen/view%20model/theme_provider.dart';
import 'package:sophwe_newmodule/app/modules/pharma/product/cart/view_model/pharma_cart_provider.dart';
import 'package:sophwe_newmodule/app/modules/pharma/product/product%20details/view%20model/detailed_product_view_provider.dart';
import 'package:sophwe_newmodule/app/modules/widgets/common_widgets.dart';
import 'package:sophwe_newmodule/app/utils/enums.dart';
import 'package:sophwe_newmodule/app/utils/prefferences.dart';

import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_images.dart';
import '../../../../widgets/empty_screen.dart';
import '../../../widget/related_product_widget.dart';
import '../../../widget/size_selecting_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.productLink,
  });

  final String productLink;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

DetailedProductViewProvider? provider;
PharmaCartProvider? cartProvider;

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    provider = context.read<DetailedProductViewProvider>();
    provider?.getDetailedVIewFn(
      productLink: widget.productLink,
    );
    provider?.getPharmaCartFn(
      productLink: widget.productLink,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, _) => Scaffold(
        backgroundColor: isDarkModeOn ? AppConstants.black : AppConstants.white,
        body: Consumer<DetailedProductViewProvider>(
          builder: (context, provider, child) => provider.status ==
                  GetDetailedVIewStatus.loading
              ? SizedBox(
                  height: Responsive.height * 100,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : provider.status == GetDetailedVIewStatus.loaded
                  ? CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          pinned: true,
                          expandedHeight: Responsive.height * 37,
                          backgroundColor: Colors.transparent,
                          flexibleSpace: FlexibleSpaceBar(
                            background: CachedImageWidget(
                              imageUrl: provider.model.product?.images?.first ??
                                  "https://5.imimg.com/data5/MA/NH/MY-66315538/1-500x500.jpg",
                              width: Responsive.width * 100,
                              height: Responsive.height * 31,
                            ),
                          ),
                          leading: IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: AppConstants.black),
                            onPressed: () => Navigator.pop(context),
                          ),
                          actions: [
                            Consumer<PharmaHomeProvider>(
                              builder: (context, value, child) => CommonInkwell(
                                onTap: () {
                                  value.addToWishListFn(
                                    provider.model.product?.id ?? "",
                                    context,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: isDarkModeOn
                                        ? AppConstants.commonGold
                                        : AppConstants.darkBlue,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child:
                                      provider.model.product?.wishlist == true
                                          ? Icon(
                                              Icons.favorite,
                                              size: 16,
                                              color: isDarkModeOn
                                                  ? AppConstants.black
                                                  : AppConstants.white,
                                            )
                                          : Icon(
                                              Icons.favorite_outline,
                                              size: 16,
                                              color: isDarkModeOn
                                                  ? AppConstants.black
                                                  : AppConstants.white,
                                            ),
                                ),
                              ),
                            ),
                            const SizeBoxV(20),
                            CommonInkwell(
                              onTap: () {
                                provider.shareLink(
                                  context,
                                  provider.model.product?.link ?? "",
                                );
                              },
                              child: Image.asset(
                                AppImages.blueBgShare,
                                height: 30,
                              ),
                            ),
                            const SizeBoxV(20),
                          ],
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Container(
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonTextWidget(
                                      color: isDarkModeOn
                                          ? AppConstants.white
                                          : AppConstants.black,
                                      text:
                                          provider.model.product?.productName ??
                                              "",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    SizeBoxH(Responsive.height * 0.8),
                                    CommonTextWidget(
                                      color: isDarkModeOn
                                          ? AppConstants.black
                                          : AppConstants.black,
                                      text:
                                          provider.model.product?.description ??
                                              "",
                                      fontSize: 10,
                                      maxLines: null,
                                      align: TextAlign.start,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    SizeBoxH(Responsive.height * 2),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: AppConstants.yellow,
                                          size: 16,
                                        ),
                                        const SizeBoxV(5),
                                        CommonTextWidget(
                                          color: isDarkModeOn
                                              ? AppConstants.white
                                              : AppConstants.black,
                                          text: provider.model.product?.ratings
                                                  ?.average
                                                  ?.toStringAsFixed(2) ??
                                              '',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        CommonTextWidget(
                                          color: isDarkModeOn
                                              ? AppConstants.white
                                              : AppConstants.black,
                                          text:
                                              " (${provider.formatNumber(provider.model.product?.ratings?.count ?? 0)})",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                    SizeBoxH(Responsive.height * 1),
                                    Visibility(
                                      visible: (provider.model.product?.ratings
                                                  ?.count ??
                                              0) >=
                                          1,
                                      child: CommonInkwell(
                                        onTap: () {
                                          context.pushNamed(
                                              AppRouter.viewReviewScreen,
                                              queryParameters: {
                                                "productId": provider
                                                        .model.product?.id ??
                                                    "",
                                                "imageUrl": provider
                                                        .model
                                                        .product
                                                        ?.images
                                                        ?.first ??
                                                    "",
                                              });
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
                                    ),
                                    SizeBoxH(Responsive.height * 1),
                                    CommonTextWidget(
                                      color: isDarkModeOn
                                          ? AppConstants.commonGold
                                          : AppConstants.darkBlue,
                                      text:
                                          "${provider.model.product?.price} AED",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    SizeBoxH(Responsive.height * 1.5),
                                    SizeSelectingWidget(
                                      isDarkModeOn: isDarkModeOn,
                                      sizeList:
                                          provider.model.product?.details ?? [],
                                      currency:
                                          provider.model.product?.currency ??
                                              "",
                                    ),
                                    RelatedProductWidget(
                                      isDarkModeOn: isDarkModeOn,
                                      provider: provider,
                                    ),
                                  ],
                                ),
                              );
                            },
                            childCount: 1,
                          ),
                        ),
                      ],
                    )
                  : EmptyScreenWidget(
                      text: "Server under maintenance, please try again later.",
                      image: AppImages.serverMaintenanceImage,
                      height: Responsive.height * 80,
                      isFromServerError: true,
                      ontap: () {
                        provider.getDetailedVIewFn(
                          productLink: widget.productLink,
                        );
                      },
                    ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8,bottom: 8,),
          child:   CommonButton(
                ontap: () {
                  log("reached here");
                  if (AppPref.isSignedIn) {
                    if (provider?.isProductAddedToCart == true) {
                      context.pushNamed(AppRouter.cartScreen);
                      log("aaa");
                    } else {
                      provider?.addToCartFn(
                        productId: provider?.model.product?.id ?? '',
                        ctx: context,
                      );
                    }
                  } else {
                    context.pushReplacementNamed(AppRouter.login);
                  }
                },
                height: Responsive.height * 6,
                text: provider?.isProductAddedToCart == true
                    ? "View Cart"
                    : "Add to Cart",
                isDarkMode: isDarkModeOn,
              )
        ),
      ),
    );
  }
}

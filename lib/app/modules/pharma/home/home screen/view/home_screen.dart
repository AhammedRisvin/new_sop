import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/app_router.dart';
import 'package:sophwe_newmodule/app/modules/widgets/common_widgets.dart';
import 'package:sophwe_newmodule/app/utils/app_images.dart';
import 'package:sophwe_newmodule/app/utils/enums.dart';

import '../../../../../helpers/extentions.dart';
import '../../../../../helpers/size_box.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../widgets/empty_screen.dart';
import '../view model/home_provider.dart';
import '../view model/theme_provider.dart';
import '../widget/pharma_home_screen_shimmer.dart';
import '../widget/product_listing_widget.dart';

class PharmaHomeScreen extends StatefulWidget {
  const PharmaHomeScreen({super.key});

  @override
  State<PharmaHomeScreen> createState() => _PharmaHomeScreenState();
}

class _PharmaHomeScreenState extends State<PharmaHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PharmaHomeProvider>().getPharmaHomeCatagoryFn();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (_, value) => value.isDarkModeOn,
      builder: (context, isDarkModeOn, _) => Scaffold(
        backgroundColor: isDarkModeOn ? AppConstants.black : AppConstants.white,
        appBar: AppBar(
          backgroundColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          surfaceTintColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          title: CommonTextWidget(
            color: isDarkModeOn ? AppConstants.white : AppConstants.black,
            text: "Grocery",
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          actions: [
            CommonInkwell(
              onTap: () {
                context.push(AppRouter.orderHistoryScreen);
              },
              child: Image.asset(
                AppImages.orderhistoryIcon,
                height: 45,
                color: isDarkModeOn ? AppConstants.white : AppConstants.black,
              ),
            ),
            const SizeBoxV(20),
            CommonInkwell(
              onTap: () {
                context.push(AppRouter.favouritesScreen);
              },
              child: Image.asset(
                AppImages.favouritesIcon,
                height: 45,
                color: isDarkModeOn ? AppConstants.white : AppConstants.black,
              ),
            ),
            const SizeBoxV(20),
            CommonInkwell(
              onTap: () {
                context.push(AppRouter.cartScreen);
              },
              child: Image.asset(
                AppImages.cartIcon,
                height: 45,
                color: isDarkModeOn ? AppConstants.white : AppConstants.black,
              ),
            ),
            const SizeBoxV(20),
          ],
          automaticallyImplyLeading: false,
        ),
        body: Consumer<PharmaHomeProvider>(
          builder: (context, provider, child) => provider
                      .pharmaCatagoryStatus ==
                  PharmaCatagoryStatus.loading
              ? const PharmaHomeShimmer()
              : provider.pharmaCatagoryStatus == PharmaCatagoryStatus.loaded
                  ? SingleChildScrollView(
                      padding: const EdgeInsets.all(12),
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonInkwell(
                            onTap: () {
                              context.pushNamed(AppRouter.searchScreen,
                                  queryParameters: {
                                    "catagoryId": "",
                                    "subCatagoryId": "",
                                  });
                            },
                            child: Container(
                              width: Responsive.width * 100,
                              height: Responsive.height * 6,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: AppConstants.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppConstants.black10),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: AppConstants.black40,
                                    size: 18,
                                  ),
                                  SizeBoxV(20),
                                  CommonTextWidget(
                                    color: AppConstants.black40,
                                    text: "Search...",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.mic_rounded,
                                    size: 18,
                                    color: AppConstants.black40,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: provider.getPharmaHomeModel.categories
                                    ?.isNotEmpty ??
                                false,
                            child: Container(
                              margin: const EdgeInsets.only(
                                top: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonTextWidget(
                                    color: isDarkModeOn
                                        ? AppConstants.white
                                        : AppConstants.black,
                                    text: "Popular Categories",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  const SizeBoxH(15),
                                  SizedBox(
                                    height: Responsive.height * 13,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final catagoryData = provider
                                            .getPharmaHomeModel
                                            .categories?[index];
                                        return CommonInkwell(
                                          onTap: () {
                                            context.pushNamed(
                                                AppRouter.catagoryScreen,
                                                queryParameters: {
                                                  "catagoryId":
                                                      catagoryData?.id ?? "",
                                                  "catagoryName":
                                                      catagoryData?.name ??
                                                          "Medicines"
                                                });
                                          },
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                radius: Responsive.height * 4,
                                                backgroundColor: isDarkModeOn
                                                    ? Colors.accents
                                                        .elementAt(
                                                            (index + 44) %
                                                                Colors.accents
                                                                    .length)
                                                        .withOpacity(0.5)
                                                    : Colors.accents
                                                        .elementAt(
                                                            (index + 20) %
                                                                Colors.accents
                                                                    .length)
                                                        .withOpacity(0.5),
                                                child: CachedImageWidget(
                                                  imageUrl:
                                                      catagoryData?.image ?? "",
                                                  width: 40,
                                                  height: 40,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                              ),
                                              const SizeBoxH(10),
                                              CommonTextWidget(
                                                color: isDarkModeOn
                                                    ? AppConstants.white
                                                    : AppConstants.black,
                                                text: catagoryData?.name ??
                                                    "Medicines",
                                                fontSize: 12,
                                                maxLines: 2,
                                                overFlow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          const SizeBoxV(20),
                                      itemCount: provider.getPharmaHomeModel
                                              .categories?.length ??
                                          0,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonTextWidget(
                                        color: isDarkModeOn
                                            ? AppConstants.white
                                            : AppConstants.black,
                                        text: "Latest Products",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      const SizeBoxH(15),
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10,
                                          childAspectRatio:
                                              Responsive.height * 0.085,
                                        ),
                                        itemCount: provider.getPharmaHomeModel
                                                .latestProducts?.length ??
                                            0,
                                        itemBuilder: (context, index) {
                                          final latestProduct = provider
                                              .getPharmaHomeModel
                                              .latestProducts?[index];
                                          return CommonProductListingWidget(
                                            onTap: () {
                                              context.pushNamed(
                                                  AppRouter
                                                      .productDetailsScreen,
                                                  queryParameters: {
                                                    "productLink":
                                                        latestProduct?.link ??
                                                            "",
                                                  });
                                            },
                                            isDarkModeOn: isDarkModeOn,
                                            data: latestProduct,
                                          );
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : EmptyScreenWidget(
                      text: "Server under maintenance, please try again later.",
                      image: AppImages.serverMaintenanceImage,
                      height: Responsive.height * 80,
                      isFromServerError: true,
                      ontap: () {
                        provider.getPharmaHomeCatagoryFn();
                      },
                    ),
        ),
      ),
    );
  }
}

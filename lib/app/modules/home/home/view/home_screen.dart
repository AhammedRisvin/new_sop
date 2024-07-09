import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/extentions.dart';
import 'package:sophwe_newmodule/app/modules/home/home/view%20model/home_screen_provider.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/home%20screen/view%20model/theme_provider.dart';
import 'package:sophwe_newmodule/app/modules/widgets/common_widgets.dart';
import 'package:sophwe_newmodule/app/utils/app_constants.dart';
import 'package:sophwe_newmodule/app/utils/enums.dart';

import '../../../../helpers/app_router.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_images.dart';
import '../../../bottom_navigation_bar/view model/main_bottom_navigation_provider.dart';
import '../../../pharma/home/home screen/widget/product_listing_widget.dart';
import '../../../widgets/empty_screen.dart';
import '../../settings/main/view_model/settings_provider.dart';
import '../widget/home_screen_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

SettingsProvider? settingsProvider;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    settingsProvider = context.read<SettingsProvider>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeProvider>().getHomeDataFn();
      settingsProvider?.getProfileDataFn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, child) => Scaffold(
        backgroundColor: isDarkModeOn ? AppConstants.black : AppConstants.white,
        appBar: AppBar(
          backgroundColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          surfaceTintColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          automaticallyImplyLeading: false,
          toolbarHeight: 60,
          title: Consumer<SettingsProvider>(
            builder: (context, value, child) => Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizeBoxH(10),
                  value.getProfileData.profileData?.profileImage == "empty"
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            "assets/images/defaultProfPic.png",
                            height: 30,
                            width: 30,
                          ),
                        )
                      : CachedImageWidget(
                          imageUrl: value
                                  .getProfileData.profileData?.profileImage ??
                              "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png",
                          height: 30,
                          width: 30,
                          borderRadius: BorderRadius.circular(100),
                        ),
                  const SizeBoxH(5),
                  CommonTextWidget(
                    color:
                        isDarkModeOn ? AppConstants.white : AppConstants.black,
                    text:
                        "Hello ! ${value.getProfileData.profileData?.name ?? "User"}",
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
          // actions: [
          //   CommonInkwell(
          //     onTap: () {
          //       context.pushNamed(AppRouter.selectLocationScreen);
          //     },
          //     child: SizedBox(
          //       width: Responsive.width * 42,
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         children: [
          //           const SizeBoxH(10),
          //           Row(
          //             children: [
          //               CommonTextWidget(
          //                 color: isDarkModeOn
          //                     ? AppConstants.white
          //                     : AppConstants.black,
          //                 text: "Calicut ,Town plaza",
          //                 fontSize: 11,
          //                 maxLines: 1,
          //                 overFlow: TextOverflow.ellipsis,
          //                 fontWeight: FontWeight.w600,
          //               ),
          //               const SizeBoxV(10),
          //               Image.asset(
          //                 "assets/icons/mainLocationIcon.png",
          //                 height: 20,
          //               )
          //             ],
          //           ),
          //           CommonTextWidget(
          //             color: isDarkModeOn
          //                 ? AppConstants.white
          //                 : AppConstants.black,
          //             text: "Calicut ,Town plaza,kerala,india",
          //             fontSize: 11,
          //             maxLines: 1,
          //             letterSpacing: -0.2,
          //             overFlow: TextOverflow.ellipsis,
          //             fontWeight: FontWeight.w600,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          //   const SizeBoxV(10)
          // ],
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Consumer<HomeProvider>(
            builder: (context, provider, child) => provider.status ==
                    GetHomeStatus.loading
                ? const HomeScreenShimmer()
                : provider.status == GetHomeStatus.loaded
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const SizeBoxH(10),
                          // SizedBox(
                          //   height: Responsive.height * 12,
                          //   child: CommonInkwell(
                          //     onTap: () {
                          //       context
                          //           .read<MainBottomNavigationProvider>()
                          //           .updateBottomNavIndex(3);
                          //     },
                          //     child: Column(
                          //       children: [
                          //         CircleAvatar(
                          //           radius: Responsive.height * 4.5,
                          //           backgroundColor: isDarkModeOn
                          //               ? AppConstants.commonGold
                          //                   .withOpacity(0.1)
                          //               : const Color(0xff1B3865)
                          //                   .withOpacity(0.1),
                          //           child: Image.asset(
                          //             "assets/icons/pharmaHomeIcon.png",
                          //             height: Responsive.height * 3.5,
                          //             width: Responsive.height * 3.5,
                          //             color: isDarkModeOn
                          //                 ? AppConstants.commonGold
                          //                 : AppConstants.darkBlue,
                          //           ),
                          //         ),
                          //         const SizeBoxH(10),
                          //         Expanded(
                          //           child: CommonTextWidget(
                          //             color: isDarkModeOn
                          //                 ? AppConstants.white
                          //                 : AppConstants.black,
                          //             text: "Grocery",
                          //             fontSize: 12,
                          //             maxLines: 2,
                          //             overFlow: TextOverflow.ellipsis,
                          //             fontWeight: FontWeight.w600,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // const SizeBoxH(10),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     CommonTextWidget(
                          //       color: isDarkModeOn
                          //           ? AppConstants.white
                          //           : AppConstants.black,
                          //       text: "Restaurants to explore",
                          //       fontSize: 13,
                          //       overFlow: TextOverflow.ellipsis,
                          //       fontWeight: FontWeight.w600,
                          //     ),
                          //     TextButton(
                          //       onPressed: () {},
                          //       child: CommonTextWidget(
                          //         color: isDarkModeOn
                          //             ? AppConstants.commonGold
                          //             : AppConstants.darkBlue,
                          //         text: "See All",
                          //         fontSize: 11,
                          //         overFlow: TextOverflow.ellipsis,
                          //         fontWeight: FontWeight.w600,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // const SizeBoxH(5),
                          // SizedBox(
                          //   height: Responsive.height * 30,
                          //   child: ListView.separated(
                          //     shrinkWrap: true,
                          //     scrollDirection: Axis.horizontal,
                          //     itemBuilder: (context, index) {
                          //       final restaurantData =
                          //           provider.model.restaurentData?[index];
                          //       return RestaurantToExploreProductWidget(
                          //         isDarkModeOn: isDarkModeOn,
                          //         data: restaurantData,
                          //       );
                          //     },
                          //     separatorBuilder: (context, index) =>
                          //         const SizeBoxH(10),
                          //     itemCount:
                          //         provider.model.restaurentData?.length ?? 0,
                          //   ),
                          // ),
                          // Visibility(
                          //   visible:
                          //       provider.model.bannerDatas?.isNotEmpty ?? false,
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       const SizeBoxH(27),
                          //       CarousalSliderWidget(
                          //         data: provider.model.bannerDatas ?? [],
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // const SizeBoxH(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonTextWidget(
                                color: isDarkModeOn
                                    ? AppConstants.white
                                    : AppConstants.black,
                                text: "Latest Products",
                                fontSize: 16,
                                overFlow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w600,
                              ),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<MainBottomNavigationProvider>()
                                      .updateBottomNavIndex(3);
                                },
                                child: CommonTextWidget(
                                  color: isDarkModeOn
                                      ? AppConstants.commonGold
                                      : AppConstants.darkBlue,
                                  text: "See All",
                                  fontSize: 11,
                                  overFlow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: Responsive.width * 3,
                              childAspectRatio: Responsive.height * 0.08,
                            ),
                            itemCount:
                                provider.model.latestProducts?.length ?? 0,
                            itemBuilder: (context, index) {
                              final latestProductData =
                                  provider.model.latestProducts?[index];
                              return CommonProductListingWidget(
                                onTap: () {
                                  context.pushNamed(
                                      AppRouter.productDetailsScreen,
                                      queryParameters: {
                                        "productLink":
                                            latestProductData?.link ?? "",
                                      });
                                },
                                isDarkModeOn: isDarkModeOn,
                                data: latestProductData,
                              );
                            },
                          ),
                          const SizeBoxH(20),
                        ],
                      )
                    : EmptyScreenWidget(
                        text: "Server is Busy, Try again later",
                        image: AppImages.serverMaintenanceImage,
                        height: Responsive.height * 80,
                        isFromServerError: true,
                        ontap: () {
                          context.read<HomeProvider>().getHomeDataFn();
                        },
                      ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/app_router.dart';
import 'package:sophwe_newmodule/app/helpers/extentions.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/home%20screen/view%20model/theme_provider.dart';
import 'package:sophwe_newmodule/app/modules/pharma/product/favourites/view_model/favourites_provider.dart';
import 'package:sophwe_newmodule/app/modules/widgets/empty_screen.dart';
import 'package:sophwe_newmodule/app/utils/app_images.dart';
import 'package:sophwe_newmodule/app/utils/enums.dart';

import '../../../../../utils/app_constants.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../widget/cart_and_favourite_listing_widget.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

PharmaFavouritesProvider? provider;

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  void initState() {
    provider = Provider.of<PharmaFavouritesProvider>(context, listen: false);
    provider?.getFavouritesFn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, _) => Scaffold(
        backgroundColor: isDarkModeOn ? AppConstants.black : AppConstants.white,
        appBar: AppBar(
          surfaceTintColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          title: CommonTextWidget(
            color: isDarkModeOn ? AppConstants.white : AppConstants.black,
            text: "Favourites",
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          backgroundColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: isDarkModeOn ? AppConstants.white : AppConstants.black,
            ),
          ),
        ),
        body: Consumer<PharmaFavouritesProvider>(
          builder: (context, provider, child) => provider
                      .favouritesModel.wishlists?.product?.isEmpty ==
                  true
              ? EmptyScreenWidget(
                  text: "Empty screen",
                  image: AppImages.noFavouritesImage,
                  height: Responsive.height * 80,
                )
              : provider.favouritesStatus == PharmaFavouritesStatus.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : provider.favouritesStatus == PharmaFavouritesStatus.loaded
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final product = provider
                                  .favouritesModel.wishlists?.product?[index];
                              return CartAndFavouriteListingWidget(
                                isDarkModeOn: isDarkModeOn,
                                productData: product,
                                onTap: () {
                                  context.pushNamed(
                                      AppRouter.productDetailsScreen,
                                      queryParameters: {
                                        "productLink": product?.link ?? "",
                                      });
                                },
                                successCallback: () {},
                              );
                            },
                            itemCount: provider.favouritesModel.wishlists
                                    ?.product?.length ??
                                0,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                          ),
                        )
                      : EmptyScreenWidget(
                          text: "Server Busy ",
                          image: AppImages.serverMaintenanceImage,
                          height: Responsive.height * 80,
                          isFromServerError: true,
                          ontap: () {
                            provider.getFavouritesFn();
                          },
                        ),
        ),
      ),
    );
  }
}

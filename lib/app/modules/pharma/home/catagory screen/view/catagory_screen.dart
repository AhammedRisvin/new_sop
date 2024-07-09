import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/extentions.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/catagory%20screen/view%20model/catagory_provider.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/home%20screen/view%20model/theme_provider.dart';
import 'package:sophwe_newmodule/app/modules/widgets/empty_screen.dart';
import 'package:sophwe_newmodule/app/utils/enums.dart';

import '../../../../../helpers/app_router.dart';
import '../../../../../helpers/size_box.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_images.dart';
import '../../../../widgets/common_widgets.dart';
import '../../home screen/widget/product_listing_widget.dart';
import '../widget/filter_widget.dart';
import '../widget/sub_catagory_shimmer_widget.dart';

class CatagoryScreen extends StatefulWidget {
  const CatagoryScreen({
    super.key,
    required this.catagoryName,
    required this.catagoryId,
  });

  final String catagoryName;
  final String catagoryId;

  @override
  State<CatagoryScreen> createState() => _CatagoryScreenState();
}

CatagoryProvider? provider;

class _CatagoryScreenState extends State<CatagoryScreen> {
  @override
  void initState() {
    super.initState();
    provider = context.read<CatagoryProvider>();
    provider?.getSubCatagoryFn(
      catagoryId: widget.catagoryId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, child) => Scaffold(
          backgroundColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          appBar: AppBar(
            backgroundColor:
                isDarkModeOn ? AppConstants.black : AppConstants.white,
            title: CommonTextWidget(
              color: isDarkModeOn ? AppConstants.white : AppConstants.black,
              text: widget.catagoryName,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            actions: [
              CommonInkwell(
                onTap: () {
                  context.pushNamed(
                    AppRouter.searchScreen,
                    queryParameters: {
                      "catagoryId": widget.catagoryId,
                      "subCatagoryId": provider?.selectedSubCatagoryId ?? "",
                    },
                  );
                },
                child: Image.asset(
                  AppImages.searchIcon,
                  height: 20,
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                ),
              ),
              const SizeBoxV(20),
              FilterWidget(
                isDarkModeOn: isDarkModeOn,
                onSelected: (value) {
                  provider?.getProductFn(
                    catagoryId: widget.catagoryId,
                    subCatagoryId: provider?.selectedSubCatagoryId ?? "",
                    filterKeyWord: value,
                  );
                },
              ),
              const SizeBoxV(20),
            ],
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: isDarkModeOn ? AppConstants.white : AppConstants.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            surfaceTintColor:
                isDarkModeOn ? AppConstants.black : AppConstants.white,
          ),
          body: Consumer<CatagoryProvider>(
            builder: (context, provider, child) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    provider.getSubCatagoryModel.subCategories?.isEmpty == true
                        ? const SizedBox.shrink()
                        : provider.pharmaSubCatagoryStatus ==
                                GetSubCatagoryStatus.loading
                            ? const SubCatagoryShimmerWidget()
                            : provider.pharmaSubCatagoryStatus ==
                                    GetSubCatagoryStatus.loaded
                                ? SizedBox(
                                    height: 40,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final selected =
                                            provider.selectedIndex == index;
                                        final subCatagoryData = provider
                                            .getSubCatagoryModel
                                            .subCategories?[index];
                                        return CommonInkwell(
                                          onTap: () {
                                            provider.selectContainer(
                                              index,
                                              subCatagoryData?.id ?? "",
                                            );
                                            provider.getProductFn(
                                              catagoryId: widget.catagoryId,
                                              subCatagoryId:
                                                  subCatagoryData?.id ?? "",
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: isDarkModeOn
                                                  ? selected
                                                      ? AppConstants.commonGold
                                                      : AppConstants.black
                                                  : selected
                                                      ? AppConstants.darkBlue
                                                      : AppConstants.white,
                                              border: Border.all(
                                                color: isDarkModeOn
                                                    ? AppConstants.commonGold
                                                    : AppConstants.darkBlue,
                                              ),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                            ),
                                            child: Center(
                                              child: CommonTextWidget(
                                                color: isDarkModeOn
                                                    ? selected
                                                        ? AppConstants.white
                                                        : AppConstants.white
                                                    : selected
                                                        ? AppConstants.white
                                                        : AppConstants.black,
                                                text:
                                                    subCatagoryData?.name ?? "",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          const SizeBoxV(10),
                                      itemCount: provider.getSubCatagoryModel
                                              .subCategories?.length ??
                                          0,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                    const SizeBoxH(20),
                    provider.getProductModel.products?.isEmpty == true
                        ? EmptyScreenWidget(
                            text: "No Product available right now",
                            image: AppImages.reminderEmpty,
                            height: Responsive.height * 70,
                          )
                        : provider.getProductStatus == GetProductStatus.loading
                            ? SizedBox(
                                height: Responsive.height * 70,
                                width: Responsive.width * 100,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : provider.getProductStatus ==
                                    GetProductStatus.loaded
                                ? Expanded(
                                    child: GridView.builder(
                                      physics: const ScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        childAspectRatio:
                                            Responsive.height * 0.08,
                                      ),
                                      itemCount: provider
                                          .getProductModel.products?.length,
                                      itemBuilder: (context, index) {
                                        final productData = provider
                                            .getProductModel.products?[index];
                                        return CommonProductListingWidget(
                                          onTap: () {
                                            context.pushNamed(
                                                AppRouter.productDetailsScreen,
                                                queryParameters: {
                                                  "productLink":
                                                      productData?.link ?? "",
                                                });
                                          },
                                          isDarkModeOn: isDarkModeOn,
                                          data: productData,
                                        );
                                      },
                                    ),
                                  )
                                : EmptyScreenWidget(
                                    text: "Server Busy Please try again later",
                                    image: AppImages.serverMaintenanceImage,
                                    height: Responsive.height * 70,
                                    isFromServerError: true,
                                    ontap: () {
                                      provider.getSubCatagoryFn(
                                        catagoryId: widget.catagoryId,
                                      );
                                    },
                                  )
                  ],
                ),
              );
            },
          )),
    );
  }
}

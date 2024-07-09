import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/extentions.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/home%20screen/view%20model/theme_provider.dart';
import 'package:sophwe_newmodule/app/modules/widgets/common_widgets.dart';
import 'package:sophwe_newmodule/app/modules/widgets/empty_screen.dart';
import 'package:sophwe_newmodule/app/utils/app_constants.dart';
import 'package:sophwe_newmodule/app/utils/app_images.dart';
import 'package:sophwe_newmodule/app/utils/enums.dart';

import '../../product details/view model/detailed_product_view_provider.dart';
import '../view model/raing_provider.dart';
import '../widget/review_product_widget.dart';
import '../widget/review_progrerss_widget.dart';
import '../widget/review_widget.dart';

class ViewReviewScreen extends StatefulWidget {
  const ViewReviewScreen({
    super.key,
    required this.productId,
    required this.imageUrl,
  });

  final String productId;
  final String imageUrl;

  @override
  State<ViewReviewScreen> createState() => _ViewReviewScreenState();
}

RatingProvider? ratingProvider;

class _ViewReviewScreenState extends State<ViewReviewScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    ratingProvider = context.read<RatingProvider>();
    ratingProvider?.getReviewFn(productId: widget.productId);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (ratingProvider?.hasMore ?? false) {
        ratingProvider?.getReviewFn(
          productId: widget.productId,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, child) => Scaffold(
        backgroundColor: isDarkModeOn ? AppConstants.black : AppConstants.white,
        appBar: AppBar(
          title: CommonTextWidget(
            color: isDarkModeOn ? AppConstants.white : AppConstants.black,
            text: "Reviews",
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
          surfaceTintColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
        ),
        body: Consumer<RatingProvider>(
          builder: (context, provider, child) => provider.reviewStatus ==
                  ReviewStatus.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : provider.reviewStatus == ReviewStatus.loaded
                  ? SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ReviewProductWidget(
                            widget: widget,
                            isDarkModeOn: isDarkModeOn,
                            provider: provider,
                          ),
                          const SizeBoxH(10),
                          Divider(
                            thickness: 1,
                            color: isDarkModeOn
                                ? AppConstants.white.withOpacity(0.3)
                                : AppConstants.black10,
                          ),
                          const SizeBoxH(10),
                          Row(
                            children: [
                              SizedBox(
                                height: 110,
                                width: Responsive.width * 28,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CommonTextWidget(
                                          color: isDarkModeOn
                                              ? AppConstants.white
                                              : AppConstants.black,
                                          text: provider.reviewModel.totalAvg
                                                  ?.toStringAsFixed(1) ??
                                              "",
                                          fontSize: 40,
                                          letterSpacing: 3,
                                          fontWeight: FontWeight.w800,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: CommonTextWidget(
                                            color: isDarkModeOn
                                                ? AppConstants.white
                                                : AppConstants.black,
                                            text: " /5",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ),
                                    CommonTextWidget(
                                      color: isDarkModeOn
                                          ? AppConstants.white
                                          : AppConstants.black,
                                      text:
                                          "${context.read<DetailedProductViewProvider>().formatNumber(
                                                provider.reviewModel
                                                        .totalReview ??
                                                    0,
                                              )} Reviews",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Responsive.height * 13,
                                child: VerticalDivider(
                                  thickness: 1,
                                  width: 5,
                                  color: isDarkModeOn
                                      ? AppConstants.white.withOpacity(0.3)
                                      : AppConstants.black10,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ReviewProgressWidget(
                                      reviewedColorCount: 5,
                                      totalReviewCount:
                                          provider.reviewModel.totalReview ?? 0,
                                      eachStarRatingCount: provider
                                              .reviewModel.ratingsCount?.the5 ??
                                          0,
                                      isDarkModeOn: isDarkModeOn,
                                    ),
                                    SizeBoxH(Responsive.height * 0.8),
                                    ReviewProgressWidget(
                                      reviewedColorCount: 4,
                                      totalReviewCount:
                                          provider.reviewModel.totalReview ?? 0,
                                      eachStarRatingCount: provider
                                              .reviewModel.ratingsCount?.the4 ??
                                          0,
                                      isDarkModeOn: isDarkModeOn,
                                    ),
                                    SizeBoxH(Responsive.height * 0.8),
                                    ReviewProgressWidget(
                                      reviewedColorCount: 3,
                                      totalReviewCount:
                                          provider.reviewModel.totalReview ?? 0,
                                      eachStarRatingCount: provider
                                              .reviewModel.ratingsCount?.the3 ??
                                          0,
                                      isDarkModeOn: isDarkModeOn,
                                    ),
                                    SizeBoxH(Responsive.height * 0.8),
                                    ReviewProgressWidget(
                                      reviewedColorCount: 2,
                                      totalReviewCount:
                                          provider.reviewModel.totalReview ?? 0,
                                      eachStarRatingCount: provider
                                              .reviewModel.ratingsCount?.the2 ??
                                          0,
                                      isDarkModeOn: isDarkModeOn,
                                    ),
                                    SizeBoxH(Responsive.height * 0.8),
                                    ReviewProgressWidget(
                                      reviewedColorCount: 1,
                                      totalReviewCount:
                                          provider.reviewModel.totalReview ?? 0,
                                      eachStarRatingCount: provider
                                              .reviewModel.ratingsCount?.the1 ??
                                          0,
                                      isDarkModeOn: isDarkModeOn,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizeBoxH(50),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                provider.reviewModel.reviews?.length ?? 0,
                            separatorBuilder: (context, index) =>
                                const SizeBoxH(15),
                            itemBuilder: (context, index) {
                              var data = provider.reviewModel.reviews?[index];
                              return ReviewWidget(
                                review: data,
                                isDarkModeOn: isDarkModeOn,
                              );
                            },
                          )
                        ],
                      ),
                    )
                  : EmptyScreenWidget(
                      text: "Server Busy try again later",
                      image: AppImages.serverMaintenanceImage,
                      height: Responsive.height * 70,
                      isFromServerError: true,
                      ontap: () {
                        ratingProvider?.getReviewFn(
                            productId: widget.productId);
                      },
                    ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/extentions.dart';

import '../../../../../helpers/size_box.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../widgets/common_widgets.dart';
import '../../product details/view model/detailed_product_view_provider.dart';

class ReviewProgressWidget extends StatelessWidget {
  final double reviewedColorCount;
  final bool isDarkModeOn;
  final num totalReviewCount;
  final num eachStarRatingCount;

  const ReviewProgressWidget({
    super.key,
    required this.reviewedColorCount,
    required this.isDarkModeOn,
    required this.totalReviewCount,
    required this.eachStarRatingCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizeBoxV(20),
          Row(
            children: buildStarIcons(reviewedColorCount),
          ),
          const SizeBoxV(10),
          SizedBox(
            width: Responsive.width * 28,
            child: Padding(
              padding: const EdgeInsets.only(top: 1.0),
              child: LinearProgressIndicator(
                color: AppConstants.reviewStarColor,
                value: context
                    .read<DetailedProductViewProvider>()
                    .calculateReviewPercentage(
                      totalReviewCount,
                      eachStarRatingCount,
                    ),
              ),
            ),
          ),
          const SizeBoxV(10),
          CommonTextWidget(
            color: isDarkModeOn ? AppConstants.white : AppConstants.black,
            text: context
                .read<DetailedProductViewProvider>()
                .formatNumber(eachStarRatingCount),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }

  List<Widget> buildStarIcons(num reviewedColorCount) {
    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      stars.add(
        Icon(
          i < reviewedColorCount
              ? Icons.star
              : Icons.star_border, // Change icon based on condition
          color: i < reviewedColorCount
              ? AppConstants.reviewStarColor
              : Colors.grey,
          size: 15,
        ),
      );
    }
    return stars;
  }
}

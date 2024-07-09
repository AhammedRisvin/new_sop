import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/extentions.dart';
import '../../../../../helpers/size_box.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../widgets/common_widgets.dart';
import '../../product details/view model/detailed_product_view_provider.dart';
import '../view model/raing_provider.dart';
import '../view/view_reviews_screen.dart';

class ReviewProductWidget extends StatelessWidget {
  const ReviewProductWidget({
    super.key,
    required this.widget,
    required this.isDarkModeOn,
    required this.provider,
  });

  final ViewReviewScreen widget;
  final bool isDarkModeOn;
  final RatingProvider provider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: Responsive.height * 10,
          width: Responsive.height * 10,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppConstants.black10,
            ),
          ),
          child: CachedImageWidget(
            imageUrl: widget.imageUrl,
            height: Responsive.height * 8,
            width: Responsive.height * 8,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizeBoxV(20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: AppConstants.yellow,
                  size: 18,
                ),
                const SizeBoxV(5),
                CommonTextWidget(
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                  text: provider.reviewModel.totalAvg?.toStringAsFixed(1) ??
                      "4.7",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                )
              ],
            ),
            const SizeBoxH(5),
            CommonTextWidget(
              color: isDarkModeOn ? AppConstants.white : AppConstants.black,
              text:
                  "Based on ${context.read<DetailedProductViewProvider>().formatNumber(
                        provider.reviewModel.totalReview ?? 0,
                      )} ratings",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ],
    );
  }
}

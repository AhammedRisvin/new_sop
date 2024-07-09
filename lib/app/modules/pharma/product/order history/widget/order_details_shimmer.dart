import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../helpers/extentions.dart';
import '../../../../../helpers/size_box.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_images.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../widget/row_text_widget.dart';
import '../../../widget/stepper_widget.dart';
import 'order_history_product_widget.dart';

class OrderDetailsShimmer extends StatelessWidget {
  const OrderDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const OrderHistoryProductWidget(
              isDarkModeOn: false,
            ),
            SizeBoxH(Responsive.height * 6),
            const RowTextWidget(
              leftText: "Discountable amount",
              rightText: "76.98 AED",
              isDarkModeOn: false,
            ),
            SizeBoxH(Responsive.height * 2),
            const RowTextWidget(
              leftText: "Payable",
              rightText: "76.98 AED",
              isDarkModeOn: false,
            ),
            SizeBoxH(Responsive.height * 2),
            const RowTextWidget(
              leftText: "Total amount",
              rightText: "76.98 AED",
              isFromTotalPrice: true,
              isDarkModeOn: false,
            ),
            SizeBoxH(Responsive.height * 1),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              width: Responsive.width * 100,
              // height: Responsive.height * 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppConstants.black10,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonTextWidget(
                    color: AppConstants.black,
                    fontSize: 16,
                    text: "Shipping Address",
                    fontWeight: FontWeight.w600,
                  ),
                  SizeBoxH(10),
                  CommonTextWidget(
                    align: TextAlign.start,
                    color: AppConstants.black,
                    fontSize: 12,
                    text:
                        "Perum Asper Rd. Mangkubumi, Wonosobo 56733 Jawa Tengah, Indonesia",
                  ),
                ],
              ),
            ),
            const StepperWidget(
              isDarkModeOn: false,
            ),
            const SizeBoxH(20),
            CommonInkwell(
              onTap: () {},
              child: Container(
                width: Responsive.width * 100,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppConstants.black10,
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.addReviewIcon,
                      height: Responsive.height * 4,
                    ),
                    const SizeBoxV(20),
                    const CommonTextWidget(
                      color: AppConstants.black,
                      fontSize: 16,
                      text: "Add a Review",
                      fontWeight: FontWeight.w600,
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppConstants.black,
                      size: 18,
                    )
                  ],
                ),
              ),
            ),
            const SizeBoxH(30),
            CommonButton(
              ontap: () {},
              height: Responsive.height * 6,
              text: "",
              isDarkMode: false,
              bgColor:
                  const Color.fromARGB(255, 236, 123, 123).withOpacity(0.3),
              textColor: AppConstants.red,
              isFromRedButton: true,
            ),
            const SizeBoxH(30),
          ],
        ),
      ),
    );
  }
}

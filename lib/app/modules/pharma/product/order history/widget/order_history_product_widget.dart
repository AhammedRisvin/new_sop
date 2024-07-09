import 'package:flutter/material.dart';
import 'package:sophwe_newmodule/app/modules/pharma/product/order%20history/model/pharma_order_history_dtails_model.dart';

import '../../../../../helpers/extentions.dart';
import '../../../../../helpers/size_box.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../widget/row_text_widget.dart';

class OrderHistoryProductWidget extends StatelessWidget {
  const OrderHistoryProductWidget({
    super.key,
    required this.isDarkModeOn,
    this.data,
    this.currency,
  });
  final bool isDarkModeOn;
  final OrderData? data;
  final String? currency;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonInkwell(
          onTap: () {},
          child: Container(
            width: Responsive.width * 100,
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppConstants.transparent,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CachedImageWidget(
                      imageUrl: data?.productImage?.first ??
                          "https://img.lovepik.com/element/40115/2654.png_860.png",
                      height: Responsive.height * 12,
                      width: Responsive.width * 24,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    const SizeBoxV(12),
                    Expanded(
                      child: SizedBox(
                        height: Responsive.height * 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CommonTextWidget(
                              color: isDarkModeOn
                                  ? AppConstants.white
                                  : AppConstants.black,
                              text: data?.productName ?? "",
                              fontSize: 16,
                              letterSpacing: -0.1,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizeBoxH(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: Responsive.width * 18,
                                  height: Responsive.height * 3.5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        color: isDarkModeOn
                                            ? AppConstants.white
                                            : AppConstants.black),
                                  ),
                                  child: Center(
                                    child: CommonTextWidget(
                                      color: isDarkModeOn
                                          ? AppConstants.white
                                          : AppConstants.black,
                                      text: "QTY : ${data?.quantity ?? 0}",
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: Responsive.height * 1),
                                  child: CommonTextWidget(
                                    color: isDarkModeOn
                                        ? AppConstants.commonGold
                                        : AppConstants.darkBlue,
                                    text:
                                        "${data?.price?.toStringAsFixed(2) ?? 0} $currency",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        SizeBoxH(Responsive.height * 0.5),
        CommonTextWidget(
          color: isDarkModeOn ? AppConstants.white : AppConstants.black,
          fontSize: 15,
          text: "Payment Summary",
          fontWeight: FontWeight.w600,
        ),
        SizeBoxH(Responsive.height * 2),
        RowTextWidget(
          leftText: "Discountable amount",
          rightText: "${data?.discount?.toStringAsFixed(2) ?? 0} $currency",
          isDarkModeOn: isDarkModeOn,
        ),
        SizeBoxH(Responsive.height * 2),
        RowTextWidget(
          leftText: "Deliver charge",
          rightText: "${data?.price?.toStringAsFixed(2) ?? 0} $currency",
          isDarkModeOn: isDarkModeOn,
        ),
        SizeBoxH(Responsive.height * 2),
        RowTextWidget(
          leftText: "Total amount",
          rightText: "${data?.totalPrice?.toStringAsFixed(2) ?? 0} $currency",
          isFromTotalPrice: true,
          isDarkModeOn: isDarkModeOn,
        ),
      ],
    );
  }
}

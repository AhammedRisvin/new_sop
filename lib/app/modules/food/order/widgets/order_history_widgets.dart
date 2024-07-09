import 'package:flutter/material.dart';

import '../../../../helpers/extentions.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../widgets/common_widgets.dart';

class FoodOrderHistoryProductWidget extends StatelessWidget {
  const FoodOrderHistoryProductWidget({
    super.key,
    required this.isDarkModeOn,
  });
  final bool isDarkModeOn;
  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
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
                  imageUrl:
                      "https://t4.ftcdn.net/jpg/04/95/28/65/240_F_495286577_rpsT2Shmr6g81hOhGXALhxWOfx1vOQBa.jpg",
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
                          text: "Amlodipine tablets",
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
                                  text: "QTY : 1",
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: Responsive.height * 1),
                              child: CommonTextWidget(
                                color: isDarkModeOn
                                    ? AppConstants.commonGold
                                    : AppConstants.darkBlue,
                                text: "AED 57.75",
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
    );
  }
}

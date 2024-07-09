import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/modules/pharma/product/product%20details/model/get_product_detailed_view.dart';
import 'package:sophwe_newmodule/app/modules/pharma/product/product%20details/view%20model/detailed_product_view_provider.dart';

import '../../../helpers/extentions.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../widgets/common_widgets.dart';

class SizeSelectingWidget extends StatelessWidget {
  const SizeSelectingWidget({
    super.key,
    required this.isDarkModeOn,
    required this.sizeList,
    required this.currency,
  });

  final bool isDarkModeOn;
  final List<Detail> sizeList;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailedProductViewProvider>(
      builder: (context, provider, child) => SizedBox(
        height: Responsive.height * 11,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final sizes = sizeList[index];
            final selected = provider.selectedIndex == index;
            return CommonInkwell(
              onTap: () {
                provider.selectContainer(
                  index,
                  sizes.id ?? '',
                );
              },
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppConstants.black10,
                      ),
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      color: (sizes.quantity ?? 0) == 0
                          ? isDarkModeOn
                              ? AppConstants.black40
                              : AppConstants.black40
                          : isDarkModeOn
                              ? selected
                                  ? AppConstants.commonGold
                                  : AppConstants.transparent
                              : selected
                                  ? AppConstants.darkBlue
                                  : AppConstants.transparent,
                    ),
                    width: Responsive.width * 30,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonTextWidget(
                          color: isDarkModeOn
                              ? selected
                                  ? AppConstants.black
                                  : AppConstants.white
                              : selected
                                  ? AppConstants.white
                                  : AppConstants.black,
                          text: sizes.size ?? "",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizeBoxH(1),
                        CommonTextWidget(
                          color: isDarkModeOn
                              ? selected
                                  ? AppConstants.black
                                  : AppConstants.white
                              : selected
                                  ? AppConstants.white
                                  : AppConstants.black,
                          text: "${sizes.price?.toStringAsFixed(2)} $currency",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  (sizes.quantity ?? 0) == 0
                      ? const Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: CommonTextWidget(
                            color: AppConstants.red,
                            text: "Not available",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizeBoxV(10),
          itemCount: sizeList.length,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/extentions.dart';
import 'package:sophwe_newmodule/app/modules/pharma/product/return_payment/view_model/pharma_order_cancel_provider.dart';
import 'package:sophwe_newmodule/app/modules/widgets/common_widgets.dart';

import '../../../../../helpers/size_box.dart';
import '../../../../../utils/app_constants.dart';

class CancelReasonWidget extends StatelessWidget {
  const CancelReasonWidget({
    super.key,
    required this.isDarkModeOn,
  });

  final bool isDarkModeOn;

  @override
  Widget build(BuildContext context) {
    return Consumer<PharmaOrderCancelProvider>(
      builder: (context, provider, child) => CommonInkwell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                height: Responsive.height * 40,
                width: Responsive.width * 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: isDarkModeOn ? AppConstants.black : AppConstants.white,
                ),
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: CommonTextWidget(
                              text: "Select the reason",
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: isDarkModeOn
                                  ? AppConstants.white
                                  : AppConstants.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              context.pop();
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 28,
                              color: AppConstants.black40,
                            ),
                          ),
                        ],
                      ),
                      const SizeBoxH(10),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.cancellationReasons.length,
                        separatorBuilder: (context, index) => const SizeBoxH(0),
                        itemBuilder: (context, index) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () {
                                provider.setSelectedReason(
                                  provider.cancellationReasons[index],
                                );
                                context.pop();
                              },
                              child: CommonTextWidget(
                                align: TextAlign.start,
                                text: provider.cancellationReasons[index],
                                fontSize: 16,
                                maxLines: 2,
                                overFlow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w500,
                                color: isDarkModeOn
                                    ? AppConstants.white
                                    : AppConstants.black,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizeBoxH(20),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          width: Responsive.width * 100,
          height: Responsive.height * 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isDarkModeOn ? AppConstants.black10 : AppConstants.black10,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonTextWidget(
                color: isDarkModeOn
                    ? AppConstants.commonGold
                    : AppConstants.darkBlue,
                text: provider.selectedReason == ''
                    ? "Cancellation reason (optional)"
                    : provider.selectedReason,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: isDarkModeOn
                    ? AppConstants.commonGold
                    : AppConstants.darkBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

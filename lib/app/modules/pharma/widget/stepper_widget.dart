import 'package:flutter/material.dart';
import 'package:sophwe_newmodule/app/modules/pharma/product/order%20history/model/pharma_order_history_dtails_model.dart';
import 'package:sophwe_newmodule/app/modules/pharma/product/order%20history/view_model/order_history_provider.dart';

import '../../../helpers/extentions.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../widgets/common_widgets.dart';

class StepperWidget extends StatelessWidget {
  final bool isDarkModeOn;
  final OrderData? data;
  final OrderHistoryProvider? provider;
  const StepperWidget({
    super.key,
    required this.isDarkModeOn,
    this.data,
    this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(
        top: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppConstants.black10,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextWidget(
            color: isDarkModeOn ? AppConstants.white : AppConstants.black,
            fontSize: 16,
            text: "Order Status",
            fontWeight: FontWeight.w600,
          ),
          const SizeBoxH(10),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data?.shippingInfo?.length ?? 0,
            separatorBuilder: (context, index) => const SizeBoxV(10),
            itemBuilder: (context, index) {
              final stepperData = data?.shippingInfo?[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const CircleAvatar(
                        radius: 12,
                        backgroundColor: Color(0xff28A745),
                        child: Icon(
                          Icons.check,
                          color: AppConstants.white,
                          size: 20,
                        ),
                      ),
                      Visibility(
                        visible: data?.shippingInfo?.length != index + 1,
                        child: SizedBox(
                          height: Responsive.height * 6,
                          child: const VerticalDivider(
                            color: Color(0xff28A745),
                            thickness: 6,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizeBoxV(Responsive.width * 2),
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: CommonTextWidget(
                            color: isDarkModeOn
                                ? AppConstants.white
                                : AppConstants.black,
                            fontSize: 16,
                            text: stepperData?.status ?? "",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizeBoxV(10),
                        CommonTextWidget(
                          color: isDarkModeOn
                              ? AppConstants.white.withOpacity(0.6)
                              : AppConstants.black40,
                          fontSize: 12,
                          text: provider?.formatDateTime(
                                  stepperData?.date?.toLocal() ??
                                      DateTime.now()) ??
                              "",
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

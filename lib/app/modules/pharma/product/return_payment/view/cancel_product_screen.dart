import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/extentions.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/home%20screen/view%20model/theme_provider.dart';
import 'package:sophwe_newmodule/app/modules/pharma/product/order%20history/model/pharma_order_history_dtails_model.dart';
import 'package:sophwe_newmodule/app/modules/pharma/product/order%20history/widget/order_history_product_widget.dart';
import 'package:sophwe_newmodule/app/modules/widgets/common_widgets.dart';

import '../../../../../helpers/app_router.dart';
import '../../../../../utils/app_constants.dart';
import '../view_model/pharma_order_cancel_provider.dart';
import '../widget/cancel_reason_widget.dart';

class CancelProductScreen extends StatelessWidget {
  final GetOrderHistoryDeatilsModel data;
  const CancelProductScreen({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, child) => Scaffold(
        backgroundColor: isDarkModeOn ? AppConstants.black : AppConstants.white,
        appBar: AppBar(
          backgroundColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          surfaceTintColor:
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
        ),
        body: Consumer<PharmaOrderCancelProvider>(
          builder: (context, provider, child) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                OrderHistoryProductWidget(
                  isDarkModeOn: isDarkModeOn,
                  data: data.orderDatas?[0],
                  currency: data.currency,
                ),
                const SizeBoxH(20),
                CancelReasonWidget(
                  isDarkModeOn: isDarkModeOn,
                ),
                const SizeBoxH(20),
                CommonButton(
                  ontap: () {
                    if (provider.selectedReason == '') {
                      toast(
                        context,
                        title: "Select a reason to continue",
                        backgroundColor: AppConstants.red,
                      );
                    } else {
                      context.pushNamed(AppRouter.returnPaymentSelectingScreen,
                          queryParameters: {
                            "amount": data.orderDatas?[0].totalPrice
                                ?.toStringAsFixed(2),
                            "currency": data.currency,
                            "bookingId": data.orderDatas?[0].bookingId,
                            "productId": data.orderDatas?[0].productId,
                            "sizeId": data.orderDatas?[0].sizeId,
                          });
                    }
                  },
                  height: Responsive.height * 6,
                  text: "Cancel Item",
                  isDarkMode: isDarkModeOn,
                  bgColor: const Color(0xffE8391C),
                  textColor: AppConstants.white,
                  isFromRedButton: true,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

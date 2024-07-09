import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/app_router.dart';
import 'package:sophwe_newmodule/app/modules/widgets/confimration_widget.dart';
import 'package:sophwe_newmodule/app/modules/widgets/empty_screen.dart';
import 'package:sophwe_newmodule/app/utils/app_images.dart';
import 'package:sophwe_newmodule/app/utils/enums.dart';

import '../../../../../helpers/extentions.dart';
import '../../../../../helpers/size_box.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../home/home screen/view model/theme_provider.dart';
import '../../../widget/stepper_widget.dart';
import '../view_model/order_history_provider.dart';
import '../widget/order_details_shimmer.dart';
import '../widget/order_history_product_widget.dart';

class OrderHistoryDetailsScreen extends StatefulWidget {
  const OrderHistoryDetailsScreen({
    super.key,
    required this.sizeId,
    required this.bookingId,
  });

  final String sizeId;
  final String bookingId;

  @override
  State<OrderHistoryDetailsScreen> createState() =>
      _OrderHistoryDetailsScreenState();
}

OrderHistoryProvider? provider;

class _OrderHistoryDetailsScreenState extends State<OrderHistoryDetailsScreen> {
  @override
  void initState() {
    super.initState();
    provider = context.read<OrderHistoryProvider>();
    provider?.getPharmaOrderHistoryDetailsFn(
      bookingId: widget.bookingId,
      sizeId: widget.sizeId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, _) => Scaffold(
        backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
        appBar: AppBar(
          surfaceTintColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          title: CommonTextWidget(
            color: isDarkModeOn ? AppConstants.white : AppConstants.black,
            text: "Order History",
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
        ),
        body: Consumer<OrderHistoryProvider>(
          builder: (context, value, child) {
            final data = value.getOrderHistoryDeatilsModel;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: value.orderHistoryDetailsStatus ==
                      PharmaOrderDetailsHistoryStatus.loading
                  ? const OrderDetailsShimmer()
                  : value.orderHistoryDetailsStatus ==
                          PharmaOrderDetailsHistoryStatus.loaded
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OrderHistoryProductWidget(
                              isDarkModeOn: isDarkModeOn,
                              data: data.orderDatas?[0],
                              currency: data.currency,
                            ),
                            SizeBoxH(Responsive.height * 2),
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
                                  color: isDarkModeOn
                                      ? AppConstants.black10
                                      : AppConstants.black10,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CommonTextWidget(
                                    color: isDarkModeOn
                                        ? AppConstants.white
                                        : AppConstants.black,
                                    fontSize: 16,
                                    text: "Shipping Address",
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const SizeBoxH(10),
                                  CommonTextWidget(
                                    align: TextAlign.start,
                                    color: isDarkModeOn
                                        ? AppConstants.white
                                        : AppConstants.black,
                                    fontSize: 12,
                                    text:
                                        "${data.shippingAddress?.address ?? ""}, ${data.shippingAddress?.city ?? ""}, ${data.shippingAddress?.state ?? ""}, ${data.shippingAddress?.pincode ?? ""} \nPhone Number : ${data.shippingAddress?.dialCodeShipping ?? ""} ${data.shippingAddress?.phone ?? ""} ",
                                  ),
                                ],
                              ),
                            ),
                            StepperWidget(
                              isDarkModeOn: isDarkModeOn,
                              data: data.orderDatas?[0],
                              provider: provider,
                            ),
                            if (data.orderDatas?[0].orderStatus
                                        ?.toLowerCase() ==
                                    "delivered" &&
                                data.orderDatas?[0].isAddedTheReview ==
                                    false) ...[
                              CommonInkwell(
                                onTap: () {
                                  context.pushNamed(AppRouter.addRatingScreen,
                                      queryParameters: {
                                        "productId":
                                            data.orderDatas?[0].productId,
                                      });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 20),
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
                                      CommonTextWidget(
                                        color: isDarkModeOn
                                            ? AppConstants.white
                                            : AppConstants.black,
                                        fontSize: 16,
                                        text: "Add a Review",
                                        fontWeight: FontWeight.w600,
                                      ),
                                      const Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: isDarkModeOn
                                            ? AppConstants.white
                                            : AppConstants.black,
                                        size: 18,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            if (data.orderDatas?[0].orderStatus
                                        ?.toLowerCase() ==
                                    "ordered" ||
                                data.orderDatas?[0].orderStatus
                                        ?.toLowerCase() ==
                                    "placed" ||
                                data.orderDatas?[0].orderStatus
                                        ?.toLowerCase() ==
                                    "picked") ...[
                              Column(
                                children: [
                                  const SizeBoxH(30),
                                  CommonButton(
                                    ontap: () {
                                      context.pushNamed(
                                        AppRouter.cancelProductScreen,
                                        extra: data,
                                      );
                                    },
                                    height: Responsive.height * 6,
                                    text: "Cancel Order",
                                    isDarkMode: isDarkModeOn,
                                    bgColor:
                                        const Color.fromARGB(255, 236, 123, 123)
                                            .withOpacity(0.3),
                                    textColor: AppConstants.red,
                                    isFromRedButton: true,
                                  ),
                                ],
                              ),
                            ],
                            if (data.orderDatas?[0].orderStatus
                                        ?.toLowerCase() ==
                                    "delivered" &&
                                data.orderDatas?[0].isReturn == true) ...[
                              Column(
                                children: [
                                  const SizeBoxH(30),
                                  CommonButton(
                                    ontap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return ConfirmationWidget(
                                            title:
                                                "Are you sure you want to Return your order ?",
                                            message:
                                                "If you cancel now ,you may not be to avail this deal again.do you still want to Return",
                                            onTap: () {
                                              context.pushNamed(
                                                  AppRouter
                                                      .returnPaymentSelectingScreen,
                                                  queryParameters: {
                                                    "amount": data
                                                        .orderDatas?[0]
                                                        .totalPrice
                                                        ?.toStringAsFixed(2),
                                                    "currency": data.currency,
                                                    "bookingId": data
                                                        .orderDatas?[0]
                                                        .bookingId,
                                                    "productId": data
                                                        .orderDatas?[0]
                                                        .productId,
                                                    "sizeId": data
                                                        .orderDatas?[0].sizeId,
                                                  });
                                            },
                                            onCancel: () {
                                              context.pop();
                                            },
                                            isDarkModeOn: isDarkModeOn,
                                            buttonText: "Return",
                                          );
                                        },
                                      );
                                    },
                                    height: Responsive.height * 6,
                                    text: "Return Order",
                                    isDarkMode: isDarkModeOn,
                                    bgColor:
                                        const Color.fromARGB(255, 236, 123, 123)
                                            .withOpacity(0.3),
                                    textColor: AppConstants.red,
                                    isFromRedButton: true,
                                  ),
                                ],
                              ),
                            ]
                          ],
                        )
                      : EmptyScreenWidget(
                          text:
                              "Server under maintenance, please try again later",
                          image: AppImages.serverMaintenanceImage,
                          height: Responsive.height * 80,
                          isFromServerError: true,
                          ontap: () {
                            provider?.getPharmaOrderHistoryDetailsFn(
                              bookingId: widget.bookingId,
                              sizeId: widget.sizeId,
                            );
                          },
                        ),
            );
          },
        ),
      ),
    );
  }
}

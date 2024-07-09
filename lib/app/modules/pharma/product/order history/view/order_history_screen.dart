import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/home%20screen/view%20model/theme_provider.dart';
import 'package:sophwe_newmodule/app/modules/pharma/product/order%20history/view_model/order_history_provider.dart';
import 'package:sophwe_newmodule/app/modules/widgets/empty_screen.dart';
import 'package:sophwe_newmodule/app/utils/app_images.dart';
import 'package:sophwe_newmodule/app/utils/enums.dart';

import '../../../../../helpers/app_router.dart';
import '../../../../../helpers/extentions.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../widgets/common_widgets.dart';

class PharmaOrderHistoryScreen extends StatefulWidget {
  const PharmaOrderHistoryScreen({super.key});

  @override
  State<PharmaOrderHistoryScreen> createState() =>
      _PharmaOrderHistoryScreenState();
}

OrderHistoryProvider? provider;

class _PharmaOrderHistoryScreenState extends State<PharmaOrderHistoryScreen> {
  @override
  void initState() {
    super.initState();
    provider = context.read<OrderHistoryProvider>();
    provider?.getPharmaOrderHistoryFn(
      deliveryStatus: provider?.historyFilterStatus ?? "Placed",
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
          actions: [
            Visibility(
              visible:
                  provider?.getOrderHistoryModel.response?.isNotEmpty == true,
              child: OrderHistoryFilterWidget(
                isDarkModeOn: isDarkModeOn,
                onSelected: (value) {
                  provider?.getPharmaOrderHistoryFn(
                    deliveryStatus: value,
                  );
                },
              ),
            ),
            const SizeBoxV(10)
          ],
        ),
        body: Consumer<OrderHistoryProvider>(
          builder: (context, value, child) => value
                      .getOrderHistoryModel.response?.isEmpty ==
                  true
              ? EmptyScreenWidget(
                  text: "${provider?.historyFilterStatus} Order History Empty",
                  image: AppImages.emptyOrderHistory,
                  height: Responsive.height * 80,
                )
              : value.status == PharmaOrderHistoryStatus.loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppConstants.commonGold,
                      ),
                    )
                  : value.status == PharmaOrderHistoryStatus.loaded
                      ? SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          physics: const ScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonTextWidget(
                                color: isDarkModeOn
                                    ? AppConstants.white
                                    : AppConstants.black,
                                text: value.historyFilterStatus,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              const SizeBoxH(10),
                              ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final data = value
                                      .getOrderHistoryModel.response?[index];
                                  final currency =
                                      value.getOrderHistoryModel.currency;
                                  return CommonInkwell(
                                    onTap: () {
                                      context.pushNamed(
                                          AppRouter.orderHistoryDetailsScreen,
                                          queryParameters: {
                                            "sizeId": data?.sizeId ?? "",
                                            "bookingId": data?.bookingId ?? "",
                                          });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppConstants.black10,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          CachedImageWidget(
                                            imageUrl: data?.images?.first ??
                                                "https://5.imimg.com/data5/MA/NH/MY-66315538/1-500x500.jpg",
                                            height: Responsive.height * 12,
                                            width: Responsive.height * 12,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          const SizeBoxV(10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CommonTextWidget(
                                                  color: data?.orderStatus ==
                                                          "Placed"
                                                      ? AppConstants
                                                          .stepperGreen
                                                      : data?.orderStatus ==
                                                              "Delivered"
                                                          ? isDarkModeOn
                                                              ? AppConstants
                                                                  .white
                                                              : AppConstants
                                                                  .black
                                                          : data?.orderStatus ==
                                                                  "Cancelled"
                                                              ? AppConstants.red
                                                              : data?.orderStatus ==
                                                                      "Returned"
                                                                  ? isDarkModeOn
                                                                      ? AppConstants
                                                                          .white
                                                                      : AppConstants
                                                                          .black
                                                                  : AppConstants
                                                                      .stepperGreen,
                                                  text: data?.orderStatus ==
                                                          "Placed"
                                                      ? "${data?.estimatedDeliveryTime ?? ""} Delivery"
                                                      : data?.orderStatus ==
                                                              "Delivered"
                                                          ? "Delivered"
                                                          : data?.orderStatus ==
                                                                  "Cancelled"
                                                              ? "Order Cancelled"
                                                              : data?.orderStatus ==
                                                                      "Returned"
                                                                  ? "Order Returned"
                                                                  : "",
                                                  fontSize: 16,
                                                  overFlow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                const SizeBoxH(5),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CommonTextWidget(
                                                      color: isDarkModeOn
                                                          ? AppConstants.white
                                                          : AppConstants.black,
                                                      text: data?.productName ??
                                                          "",
                                                      fontSize: 16,
                                                      maxLines: 2,
                                                      overFlow:
                                                          TextOverflow.ellipsis,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ],
                                                ),
                                                const SizeBoxH(5),
                                                CommonTextWidget(
                                                  align: TextAlign.start,
                                                  color: isDarkModeOn
                                                      ? AppConstants.black10
                                                      : AppConstants.black10,
                                                  text:
                                                      "Size: ${data?.size ?? ""}   Qty : ${data?.quantity ?? ""}",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  maxLines: 4,
                                                  overFlow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizeBoxH(5),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CommonTextWidget(
                                                          color: isDarkModeOn
                                                              ? AppConstants
                                                                  .commonGold
                                                              : AppConstants
                                                                  .darkBlue,
                                                          text:
                                                              "${data?.price?.toStringAsFixed(2) ?? ""} $currency",
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizeBoxH(15),
                                itemCount: value.getOrderHistoryModel.response
                                        ?.length ??
                                    0,
                                shrinkWrap: true,
                              ),
                            ],
                          ),
                        )
                      : EmptyScreenWidget(
                          text:
                              "Server under maintenance, please try again later.",
                          image: AppImages.serverMaintenanceImage,
                          height: Responsive.height * 80,
                          isFromServerError: true,
                          ontap: () {
                            provider?.getPharmaOrderHistoryFn(
                              deliveryStatus:
                                  provider?.historyFilterStatus ?? "",
                            );
                          },
                        ),
        ),
      ),
    );
  }
}

class OrderHistoryFilterWidget extends StatelessWidget {
  const OrderHistoryFilterWidget({
    super.key,
    required this.isDarkModeOn,
    this.onSelected,
  });

  final bool isDarkModeOn;
  final Function(String)? onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Placed',
          child: CommonTextWidget(
            color: isDarkModeOn ? AppConstants.black : AppConstants.white,
            text: 'Placed',
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        PopupMenuItem<String>(
          value: 'Delivered',
          child: CommonTextWidget(
            color: isDarkModeOn ? AppConstants.black : AppConstants.white,
            text: 'Completed',
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        PopupMenuItem<String>(
          value: 'Cancelled',
          child: CommonTextWidget(
            color: isDarkModeOn ? AppConstants.black : AppConstants.white,
            text: 'Cancelled',
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        PopupMenuItem<String>(
          value: 'Returned',
          child: CommonTextWidget(
            color: isDarkModeOn ? AppConstants.black : AppConstants.white,
            text: 'Returned',
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
      icon: Image.asset(
        AppImages.filterIcon,
        height: 20,
        color: isDarkModeOn ? AppConstants.commonGold : AppConstants.darkBlue,
      ),
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: isDarkModeOn ? AppConstants.commonGold : AppConstants.darkBlue,
    );
  }
}

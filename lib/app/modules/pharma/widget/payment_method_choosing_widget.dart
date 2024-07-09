import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/modules/pharma/product/cart/view_model/pharma_cart_provider.dart';
import 'package:sophwe_newmodule/app/utils/app_constants.dart';

import '../../../helpers/extentions.dart';
import '../../../utils/app_images.dart';
import '../../widgets/common_widgets.dart';
import '../product/return_payment/view_model/pharma_order_cancel_provider.dart';

class PaymentMethodChoosingWidget extends StatelessWidget {
  const PaymentMethodChoosingWidget({
    super.key,
    required this.isDarkModeOn,
    required this.walletAmount,
    required this.totalPrice,
    this.provider,
    required this.cartId,
    required this.discountableAmount,
  });

  final bool isDarkModeOn;
  final double walletAmount;
  final num totalPrice;
  final PharmaCartProvider? provider;
  final String cartId;
  final num discountableAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          walletAmount == 0 ? Responsive.height * 33 : Responsive.height * 40,
      width: Responsive.width * 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkModeOn ? AppConstants.black : AppConstants.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextWidget(
            color:
                isDarkModeOn ? AppConstants.commonGold : AppConstants.darkBlue,
            text: "Payment Method",
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          Visibility(
            visible: walletAmount != 0,
            child: Column(
              children: [
                SizeBoxH(Responsive.height * 2),
                PaymentMethodChoosingListTile(
                  isDarkModeOn: isDarkModeOn,
                  image: AppImages.cartWalletImage,
                  title: "wallet",
                  isFromReturn: false,
                  index: 0,
                  totalPrice: totalPrice,
                  walletAmount: walletAmount,
                  isFromWallet: true,
                ),
              ],
            ),
          ),
          SizeBoxH(Responsive.height * 1),
          PaymentMethodChoosingListTile(
            isDarkModeOn: isDarkModeOn,
            image: AppImages.cartStripeImage,
            title: "Stripe",
            isFromReturn: false,
            index: 1,
            totalPrice: totalPrice,
            walletAmount: walletAmount,
          ),
          SizeBoxH(Responsive.height * 1),
          PaymentMethodChoosingListTile(
            isDarkModeOn: isDarkModeOn,
            image: AppImages.cartPaypalImage,
            title: "Paypal",
            isFromReturn: false,
            index: 2,
            totalPrice: totalPrice,
            walletAmount: walletAmount,
          ),
          SizeBoxH(Responsive.height * 2),
          CommonButton(
            text: "Continue",
            isDarkMode: isDarkModeOn,
            ontap: () {
              if (provider?.selectedPaymentIndexList.isEmpty == true) {
                Fluttertoast.showToast(
                  msg: "Please select a payment method",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              } else {
                if (provider?.selectedPaymentIndexList.contains(0) == true) {
                  provider?.walletPaymentFn(
                    context: context,
                    amount: totalPrice.toStringAsFixed(2),
                    cartId: cartId,
                    discountableAmount: discountableAmount,
                  );
                } else if (provider?.selectedPaymentIndexList.contains(1) ==
                    true) {
                  provider?.createStripeFn(
                    context: context,
                    isWalletApplied: "false",
                    amount: totalPrice.toStringAsFixed(2),
                    cartId: cartId,
                    discountableAmount: discountableAmount,
                  );
                } else if (provider?.selectedPaymentIndexList.contains(2) ==
                        true &&
                    provider?.selectedPaymentIndexList.contains(0) == true) {
                  // Paypal payment with wallet
                  provider?.createStripeFn(
                    context: context,
                    isWalletApplied: "true",
                    amount: totalPrice.toStringAsFixed(2),
                    cartId: cartId,
                    discountableAmount: discountableAmount,
                  );
                } else if (provider?.selectedPaymentIndexList.contains(2) ==
                    true) {
                  provider?.paypalAmountFn(totalPrice.toStringAsFixed(2));
                  provider?.createPaypalFn(
                    context: context,
                    isWalletApplied: "false",
                    cartId: cartId,
                    discountableAmount: discountableAmount,
                  );
                } else if (provider?.selectedPaymentIndexList.contains(2) ==
                        true &&
                    provider?.selectedPaymentIndexList.contains(0) == true) {
                  // Paypal payment with wallet
                  provider?.paypalAmountFn(totalPrice.toStringAsFixed(2));
                  provider?.createPaypalFn(
                    context: context,
                    isWalletApplied: "true",
                    cartId: cartId,
                    discountableAmount: discountableAmount,
                  );
                }
              }
            },
            height: Responsive.height * 6,
          ),
        ],
      ),
    );
  }
}

class PaymentMethodChoosingListTile extends StatelessWidget {
  const PaymentMethodChoosingListTile({
    super.key,
    required this.isDarkModeOn,
    required this.title,
    required this.image,
    required this.isFromReturn,
    required this.index,
    required this.totalPrice,
    required this.walletAmount,
    this.isFromWallet = false,
  });

  final bool isDarkModeOn;
  final String title;
  final String image;
  final bool isFromReturn;
  final int index;
  final num totalPrice;
  final double walletAmount;
  final bool isFromWallet;

  @override
  Widget build(BuildContext context) {
    return Consumer<PharmaCartProvider>(
      builder: (context, provider, child) {
        final isSelected = provider.selectedPaymentIndexList.contains(index);

        return Consumer<PharmaOrderCancelProvider>(
          builder: (context, value, child) {
            final isRefundMethodSelected =
                value.selectedReturnMethodIndex == index;
            return ListTile(
              onTap: () {
                if (!isFromReturn) {
                  provider.setSelectedPaymentMethod(
                    index,
                    totalPrice: totalPrice,
                    walletAmount: walletAmount,
                  );
                } else {
                  value.updateSelectedReturnMethodIndex(index);
                }
              },
              title: isFromWallet == true
                  ? Row(
                      children: [
                        CommonTextWidget(
                          align: TextAlign.start,
                          color: isDarkModeOn
                              ? AppConstants.white
                              : AppConstants.black,
                          text: title,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        Expanded(
                          child: CommonTextWidget(
                            align: TextAlign.start,
                            color: isDarkModeOn
                                ? AppConstants.white
                                : AppConstants.black,
                            text:
                                "        Balance : ${walletAmount.toStringAsFixed(2)}",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  : CommonTextWidget(
                      align: TextAlign.start,
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      text: title,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
              leading: Image.asset(
                image,
                height: 40,
              ),
              trailing: isFromReturn
                  ? CircleAvatar(
                      backgroundColor: isDarkModeOn
                          ? AppConstants.commonGold
                          : AppConstants.darkBlue,
                      radius: 12,
                      child: CircleAvatar(
                        backgroundColor: isDarkModeOn
                            ? AppConstants.black
                            : AppConstants.white,
                        radius: 10,
                        child: CircleAvatar(
                          backgroundColor: isDarkModeOn
                              ? isRefundMethodSelected
                                  ? AppConstants.black
                                  : AppConstants.commonGold
                              : isRefundMethodSelected
                                  ? AppConstants.darkBlue
                                  : AppConstants.white,
                          radius: 8,
                        ),
                      ),
                    )
                  : Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isDarkModeOn
                            ? isSelected
                                ? AppConstants.commonGold
                                : AppConstants.transparent
                            : isSelected
                                ? AppConstants.darkBlue
                                : AppConstants.transparent,
                        border: Border.all(
                          color: isDarkModeOn
                              ? AppConstants.commonGold
                              : AppConstants.darkBlue,
                        ),
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}

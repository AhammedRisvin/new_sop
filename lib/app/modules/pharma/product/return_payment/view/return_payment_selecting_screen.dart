import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/extentions.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/home%20screen/view%20model/theme_provider.dart';
import 'package:sophwe_newmodule/app/modules/pharma/widget/payment_method_choosing_widget.dart';
import 'package:sophwe_newmodule/app/utils/app_constants.dart';
import 'package:sophwe_newmodule/app/utils/app_images.dart';

import '../../../../widgets/common_widgets.dart';
import '../view_model/pharma_order_cancel_provider.dart';

class ReturnPaymentSelectingScreen extends StatefulWidget {
  final String amount;
  final String currency;
  final String sizeId;
  final String productId;
  final String bookingId;
  final String isFromCancelled;
  const ReturnPaymentSelectingScreen({
    super.key,
    required this.amount,
    required this.sizeId,
    required this.productId,
    required this.bookingId,
    required this.currency,
    required this.isFromCancelled,
  });

  @override
  State<ReturnPaymentSelectingScreen> createState() =>
      _ReturnPaymentSelectingScreenState();
}

class _ReturnPaymentSelectingScreenState
    extends State<ReturnPaymentSelectingScreen> {
  TextEditingController bankNameController = TextEditingController();
  TextEditingController ibanController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController accountHolderNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  width: Responsive.width * 100,
                  height: Responsive.height * 6,
                  decoration: BoxDecoration(
                    color: isDarkModeOn
                        ? AppConstants.commonGold.withOpacity(0.2)
                        : AppConstants.darkBlue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isDarkModeOn
                          ? const Color(0xffE8EBEF)
                          : const Color(0xffE8EBEF),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonTextWidget(
                        color: isDarkModeOn
                            ? AppConstants.commonGold
                            : AppConstants.darkBlue,
                        fontSize: 16,
                        text: "Total Amount",
                        fontWeight: FontWeight.w500,
                      ),
                      CommonTextWidget(
                        color: isDarkModeOn
                            ? AppConstants.commonGold
                            : AppConstants.darkBlue,
                        fontSize: 16,
                        text: "${widget.amount} ${widget.currency}",
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                const SizeBoxH(30),
                PaymentMethodChoosingListTile(
                  isDarkModeOn: isDarkModeOn,
                  title: "Refund to your Wallet",
                  image: AppImages.cartWalletImage,
                  isFromReturn: true,
                  index: 0,
                  totalPrice: 0,
                  walletAmount: 0,
                ),
                const SizeBoxH(20),
                PaymentMethodChoosingListTile(
                  isDarkModeOn: isDarkModeOn,
                  title: "Refund to your Bank",
                  image: AppImages.cartBankImage,
                  isFromReturn: true,
                  index: 1,
                  totalPrice: 0,
                  walletAmount: 0,
                ),
                const SizeBoxH(30),
                CommonButton(
                  ontap: () {
                    if (provider.selectedReturnMethodIndex == 0) {
                      if (widget.isFromCancelled == "true") {
                        provider.cancelProductFn(
                          sizeId: widget.sizeId,
                          productId: widget.productId,
                          bookingId: widget.bookingId,
                          ctx: context,
                          isFromWallet: true,
                          accountNumber: '',
                          bankName: '',
                          fullName: '',
                          iban: '',
                          clear: () {},
                        );
                      } else {
                        provider.returnProductFn(
                          sizeId: widget.sizeId,
                          productId: widget.productId,
                          bookingId: widget.bookingId,
                          ctx: context,
                          isFromWallet: true,
                          accountNumber: '',
                          bankName: '',
                          fullName: '',
                          iban: '',
                          clear: () {},
                        );
                      }
                    } else {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: SingleChildScrollView(
                              child: Container(
                                height: Responsive.height * 50,
                                width: Responsive.width * 100,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: isDarkModeOn
                                      ? AppConstants.black
                                      : AppConstants.white,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonTextWidget(
                                      color: isDarkModeOn
                                          ? AppConstants.white
                                          : AppConstants.black,
                                      text: "Add Bank Details",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    const SizeBoxH(20),
                                    CommonTextFormField(
                                      bgColor: AppConstants.transparent,
                                      hintText: "Bank Name",
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.next,
                                      controller: bankNameController,
                                      color: isDarkModeOn
                                          ? AppConstants.white
                                          : AppConstants.black,
                                      borderColor: isDarkModeOn
                                          ? AppConstants.white
                                          : AppConstants.black10,
                                    ),
                                    const SizeBoxH(20),
                                    CommonTextFormField(
                                      bgColor: AppConstants.transparent,
                                      hintText: "Iban",
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.next,
                                      controller: ibanController,
                                      color: isDarkModeOn
                                          ? AppConstants.white
                                          : AppConstants.black,
                                      borderColor: isDarkModeOn
                                          ? AppConstants.white
                                          : AppConstants.black10,
                                    ),
                                    const SizeBoxH(20),
                                    CommonTextFormField(
                                      bgColor: AppConstants.transparent,
                                      hintText: "Account No",
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      controller: accountNoController,
                                      color: isDarkModeOn
                                          ? AppConstants.white
                                          : AppConstants.black,
                                      borderColor: isDarkModeOn
                                          ? AppConstants.white
                                          : AppConstants.black10,
                                    ),
                                    const SizeBoxH(20),
                                    CommonTextFormField(
                                      bgColor: AppConstants.transparent,
                                      hintText: "Account Holder Name",
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.done,
                                      controller: accountHolderNameController,
                                      color: isDarkModeOn
                                          ? AppConstants.white
                                          : AppConstants.black,
                                      borderColor: isDarkModeOn
                                          ? AppConstants.white
                                          : AppConstants.black10,
                                    ),
                                    const SizeBoxH(30),
                                    CommonButton(
                                      ontap: () {
                                        Navigator.of(context).pop();

                                        Future.microtask(() {
                                          if (widget.isFromCancelled ==
                                              "true") {
                                            provider.cancelProductFn(
                                              sizeId: widget.sizeId,
                                              productId: widget.productId,
                                              bookingId: widget.bookingId,
                                              ctx: context,
                                              isFromWallet: false,
                                              accountNumber:
                                                  accountNoController.text,
                                              bankName: bankNameController.text,
                                              fullName:
                                                  accountHolderNameController
                                                      .text,
                                              iban: ibanController.text,
                                              clear: () {
                                                accountNoController.clear();
                                                bankNameController.clear();
                                                accountHolderNameController
                                                    .clear();
                                                ibanController.clear();
                                              },
                                            );
                                          } else {
                                            provider.returnProductFn(
                                              sizeId: widget.sizeId,
                                              productId: widget.productId,
                                              bookingId: widget.bookingId,
                                              ctx: context,
                                              isFromWallet: false,
                                              accountNumber:
                                                  accountNoController.text,
                                              bankName: bankNameController.text,
                                              fullName:
                                                  accountHolderNameController
                                                      .text,
                                              iban: ibanController.text,
                                              clear: () {
                                                accountNoController.clear();
                                                bankNameController.clear();
                                                accountHolderNameController
                                                    .clear();
                                                ibanController.clear();
                                              },
                                            );
                                          }
                                        });
                                      },
                                      height: Responsive.height * 6,
                                      text: "Submit",
                                      isDarkMode: isDarkModeOn,
                                    ),
                                    const SizeBoxH(10),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  height: Responsive.height * 6,
                  text: "Continue",
                  isDarkMode: isDarkModeOn,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    bankNameController.dispose();
    ibanController.dispose();
    accountNoController.dispose();
    accountHolderNameController.dispose();
    super.dispose();
  }
}

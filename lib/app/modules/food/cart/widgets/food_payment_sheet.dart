import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sophwe_newmodule/app/helpers/app_router.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/utils/app_constants.dart';

import '../../../../helpers/extentions.dart';
import '../../../../utils/app_images.dart';
import '../../../widgets/common_widgets.dart';

class FoodPaymentMethodChoosingWidget extends StatelessWidget {
  const FoodPaymentMethodChoosingWidget({
    super.key,
    required this.isDarkModeOn,
  });

  final bool isDarkModeOn;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.height * 40,
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
          SizeBoxH(Responsive.height * 2),
          PaymentMethodChoosingListTile(
            isDarkModeOn: isDarkModeOn,
            image: AppImages.cartWalletImage,
            isSelected: false,
            title: "wallet",
            onTap: () {},
            isFromReturn: false,
          ),
          SizeBoxH(Responsive.height * 1),
          PaymentMethodChoosingListTile(
            isDarkModeOn: isDarkModeOn,
            image: AppImages.cartStripeImage,
            isSelected: true,
            title: "Stripe",
            onTap: () {},
            isFromReturn: false,
          ),
          SizeBoxH(Responsive.height * 1),
          PaymentMethodChoosingListTile(
            isDarkModeOn: isDarkModeOn,
            image: AppImages.cartPaypalImage,
            isSelected: true,
            title: "Paypal",
            onTap: () {},
            isFromReturn: false,
          ),
          SizeBoxH(Responsive.height * 2),
          CommonButton(
            text: "Continue",
            isDarkMode: isDarkModeOn,
            ontap: () {
              context.pushReplacement(AppRouter.foodOrderSuccessScreen);
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
    this.isSelected = false,
    required this.onTap,
    required this.isFromReturn,
  });

  final bool isDarkModeOn;
  final String title;
  final String image;
  final bool isSelected;
  final void Function() onTap;
  final bool isFromReturn;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: CommonTextWidget(
        align: TextAlign.start,
        color: isDarkModeOn ? AppConstants.white : AppConstants.black,
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
                backgroundColor:
                    isDarkModeOn ? AppConstants.black : AppConstants.white,
                radius: 10,
                child: CircleAvatar(
                  backgroundColor: isDarkModeOn
                      ? isSelected
                          ? AppConstants.black
                          : AppConstants.commonGold
                      : isSelected
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
                  )),
            ),
    );
  }
}

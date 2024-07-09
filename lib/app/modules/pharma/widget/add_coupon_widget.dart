import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/modules/pharma/product/cart/model/get_coupons_model.dart';
import 'package:sophwe_newmodule/app/modules/pharma/product/cart/view_model/pharma_cart_provider.dart';
import 'package:sophwe_newmodule/app/modules/widgets/common_widgets.dart';

import '../../../helpers/extentions.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../product/cart/model/get_cart_model.dart';

class AddCouponWidget extends StatelessWidget {
  const AddCouponWidget({
    super.key,
    required this.isDarkModeOn,
    this.couponsList,
    this.cartProvider,
    required this.cartId,
    required this.successCallback,
  });

  final bool isDarkModeOn;
  final List<Coupon>? couponsList;
  final PharmaCartProvider? cartProvider;
  final String cartId;
  final Function(GetCartModel getCartModel) successCallback;

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
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
                    CommonTextWidget(
                      text: "Coupons",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                    ),
                    const SizeBoxH(10),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: couponsList?.length ?? 0,
                      separatorBuilder: (context, index) => const SizeBoxH(10),
                      itemBuilder: (context, index) {
                        final couponsData = couponsList?[
                            (couponsList?.length ?? 0) - 1 - index];
                        return Container(
                          padding: const EdgeInsets.all(16),
                          width: Responsive.width * 80,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                isDarkModeOn
                                    ? 'assets/images/coupon_dk.png'
                                    : 'assets/images/coupon_lg.png',
                              ),
                              fit: BoxFit.fill,
                            ),
                            //  color: white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: isDarkModeOn
                                    ? AppConstants.black10
                                    : const Color(0xFFEDF2FF),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/coupon.png',
                                          color: isDarkModeOn
                                              ? const Color(0xffC1AE97)
                                              : const Color(0xFF33705B),
                                        ),
                                        const SizeBoxV(6),
                                        Text(
                                          'Coupons & Offers',
                                          style: TextStyle(
                                            color: isDarkModeOn
                                                ? AppConstants.white
                                                : Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'Roboto Flex',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    CommonInkwell(
                                      onTap: () {
                                        if (couponsData?.isAvailable == true) {
                                          cartProvider?.applyCouponFn(
                                            ctx: context,
                                            cartId: cartId,
                                            couponId: couponsData?.id ?? '',
                                            successCallback: successCallback,
                                            couponName: couponsData?.name ?? '',
                                          );
                                        }
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          bottom: Responsive.width * 4,
                                          left: Responsive.width * 4,
                                          top: Responsive.width * 4,
                                          right: Responsive.width * 4,
                                        ),
                                        child: Text(
                                          'Apply',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            color: isDarkModeOn
                                                ? couponsData?.isAvailable ==
                                                        true
                                                    ? const Color(0xffC1AE97)
                                                    : const Color(0xffC1AE97)
                                                        .withOpacity(0.3)
                                                : couponsData?.isAvailable ==
                                                        true
                                                    ? const Color(0xFF33705B)
                                                    : const Color(0xFF33705B)
                                                        .withOpacity(0.3),
                                            fontSize: 16,
                                            fontFamily: 'Roboto Flex',
                                            fontWeight: FontWeight.w500,
                                            height: 0.10,
                                            letterSpacing: 0.56,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizeBoxH(6),
                                const Divider(
                                  thickness: 0.5,
                                  color: Color(0xFFA9B6D7),
                                ),
                                const SizeBoxH(10),
                                Padding(
                                  padding: const EdgeInsets.only(left: 27.0),
                                  child: Text(
                                    '${couponsData?.discount}% off On min. purchase of ${couponsData?.minPrice} ${couponsData?.currency}',
                                    style: TextStyle(
                                      color: isDarkModeOn
                                          ? AppConstants.white
                                          : AppConstants.black,
                                      fontSize: 13,
                                      fontFamily: 'Roboto Flex',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.52,
                                    ),
                                  ),
                                ),
                                const SizeBoxH(10),
                                Padding(
                                  padding: const EdgeInsets.only(left: 27.0),
                                  child: Text(
                                    'Code : ${couponsData?.name} ',
                                    style: TextStyle(
                                      color: isDarkModeOn
                                          ? AppConstants.white
                                          : AppConstants.black,
                                      fontSize: 12,
                                      fontFamily: 'Roboto Flex',
                                      fontWeight: FontWeight.w400,
                                      height: 0.11,
                                      letterSpacing: 0.48,
                                    ),
                                  ),
                                ),
                                const SizeBoxH(10),
                                Padding(
                                  padding: const EdgeInsets.only(left: 27.0),
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Expiry: ',
                                          style: TextStyle(
                                            color: isDarkModeOn
                                                ? AppConstants.white
                                                : AppConstants.black,
                                            fontSize: 12,
                                            fontFamily: 'Roboto Flex',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.48,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              "${cartProvider?.formatCouponExpiryDate(
                                            couponsData?.validity?.endDate ??
                                                DateTime.now(),
                                          )}",
                                          style: TextStyle(
                                            color: isDarkModeOn
                                                ? AppConstants.commonGold
                                                : AppConstants.darkBlue,
                                            fontSize: 12,
                                            fontFamily: 'Roboto Flex',
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.48,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
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
        decoration: BoxDecoration(
          color: AppConstants.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppConstants.black10),
        ),
        padding: const EdgeInsets.all(13),
        child: Selector<PharmaCartProvider, String>(
          selector: (p0, p1) => p1.appliedCouponName,
          builder: (context, value, child) => Row(
            children: [
              Image.asset(
                AppImages.ticketDiscount,
                height: 25,
                color: isDarkModeOn
                    ? AppConstants.commonGold
                    : AppConstants.darkBlue,
              ),
              const SizeBoxV(10),
              CommonTextWidget(
                color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                text: value == "" ? "Apply voucher code" : value,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              const Spacer(),
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

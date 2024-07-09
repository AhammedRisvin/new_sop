import 'package:flutter/material.dart';
import 'package:sophwe_newmodule/app/helpers/extentions.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/modules/widgets/common_widgets.dart';

import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';

class FoodAddCouponWidget extends StatelessWidget {
  const FoodAddCouponWidget({
    super.key,
    required this.isDarkModeOn,
  });

  final bool isDarkModeOn;

  @override
  Widget build(BuildContext context) {
    return CommonTextFormField(
      bgColor: AppConstants.transparent,
      hintText: "Enter voucher code",
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.done,
      controller: TextEditingController(),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          AppImages.ticketDiscount,
          height: 10,
          color: isDarkModeOn ? AppConstants.commonGold : AppConstants.darkBlue,
        ),
      ),
      suffixIcon: IconButton(
        onPressed: () {
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
                        itemCount: 5,
                        separatorBuilder: (context, index) =>
                            const SizeBoxH(10),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            width: Responsive.width * 80,
                            decoration: ShapeDecoration(
                              // color: isDarkMode ? grey45 : white,
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
                                          // Clipboard.setData(ClipboardData(
                                          //     text: item.code.toString()));
                                          // Get.snackbar(
                                          //   item.code.toString(),
                                          //   'Copied to Clipboard',
                                          //   colorText: Colors.white,
                                          //   backgroundColor: Colors.black45,
                                          // );
                                        },
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/couponCopy.png',
                                              color: isDarkModeOn
                                                  ? const Color(0xffC1AE97)
                                                  : const Color(0xFF33705B),
                                              height: 25,
                                            ),
                                            const SizeBoxV(6),
                                            Text(
                                              'Copy',
                                              style: TextStyle(
                                                color: isDarkModeOn
                                                    ? const Color(0xffC1AE97)
                                                    : const Color(0xFF33705B),
                                                fontSize: 14,
                                                fontFamily: 'Roboto Flex',
                                                fontWeight: FontWeight.w500,
                                                height: 0.10,
                                                letterSpacing: 0.56,
                                              ),
                                            ),
                                          ],
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
                                      'On min. purchase of AED 00',
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
                                      'Code : ',
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
                                            text: "formattedDate",
                                            style: TextStyle(
                                              color: isDarkModeOn
                                                  ? AppConstants.white
                                                  : AppConstants.black,
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
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: isDarkModeOn ? AppConstants.commonGold : AppConstants.darkBlue,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/home%20screen/view%20model/theme_provider.dart';

import '../../../helpers/extentions.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../widgets/common_widgets.dart';
import '../view model/auth_provider.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, _) {
        return Scaffold(
          backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
          body: Consumer<AuthProvider>(
            builder: (context, provider, child) => Container(
              width: Responsive.width * 100,
              height: Responsive.height * 100,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizeBoxH(60),
                  Image.asset(
                    AppImages.loginNameLogo,
                    color: isDarkModeOn
                        ? AppConstants.commonGold
                        : AppConstants.darkBlue,
                    height: Responsive.height * 9,
                  ),
                  const SizeBoxH(60),
                  Padding(
                    padding: EdgeInsets.only(right: Responsive.width * 6),
                    child: Image.asset(
                      AppImages.verifyOtp,
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      height: Responsive.height * 3.5,
                    ),
                  ),
                  const SizeBoxH(10),
                  CommonTextWidget(
                    color: isDarkModeOn
                        ? AppConstants.white
                        : AppConstants.tInactive,
                    text: "Please enter the code we sent you to email",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizeBoxH(25),
                  Center(
                    child: Pinput(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      length: 6,
                      focusedPinTheme: PinTheme(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppConstants.darkBlue.withOpacity(0.1),
                          border: Border.all(
                            color: AppConstants.darkBlue.withOpacity(.4),
                          ),
                        ),
                      ),
                      defaultPinTheme: PinTheme(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          // color: AppConstants.darkBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppConstants.black.withOpacity(.1),
                          ),
                        ),
                      ),
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      onCompleted: (pin) {
                        provider.otpController = pin;
                      },
                      errorPinTheme: PinTheme(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: AppConstants.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppConstants.red.withOpacity(.4),
                          ),
                        ),
                      ),
                      errorText: 'Entered pin is incorrect',
                      errorTextStyle: const TextStyle(
                        color: AppConstants.red,
                        fontSize: 12,
                      ),
                      onTapOutside: (_) {
                        FocusScope.of(context).unfocus();
                      },
                      pinAnimationType: PinAnimationType.fade,
                      submittedPinTheme: PinTheme(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.green.withOpacity(.4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizeBoxH(30),
                  CommonButton(
                    ontap: () {
                      provider.verifyOtp(context: context); //524509
                    },
                    height: Responsive.height * 6,
                    text: "Verify",
                    isDarkMode: isDarkModeOn,
                  ),
                  const SizeBoxH(30),
                  CommonTextWidget(
                    color: isDarkModeOn
                        ? AppConstants.white
                        : AppConstants.tInactive,
                    text: "Didn't Receive OTP ?",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  TextButton(
                    onPressed: () {
                      provider.resendOtpFn(context: context);
                    },
                    child: CommonTextWidget(
                      color: isDarkModeOn
                          ? AppConstants.commonGold
                          : AppConstants.darkBlue,
                      text: "Resend Code",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

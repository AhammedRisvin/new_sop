import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../helpers/extentions.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../widgets/common_widgets.dart';

class FoodConfirmationWidget extends StatelessWidget {
  final String title;
  final String message;
  final void Function() onTap;
  final bool isDarkModeOn;
  final String buttonText;
  const FoodConfirmationWidget({
    super.key,
    required this.title,
    required this.message,
    required this.onTap,
    required this.isDarkModeOn,
    this.buttonText = "Remove",
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      content: Container(
        height: Responsive.height * 16.4,
        // width: Responsive.width * 100,
        decoration: BoxDecoration(
          color: isDarkModeOn ? AppConstants.black : AppConstants.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextWidget(
              align: TextAlign.start,
              text: title,
              color: isDarkModeOn ? AppConstants.white : AppConstants.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              // letterSpacing: 1.5,
            ),
            CommonTextWidget(
              text: message,
              color: isDarkModeOn ? AppConstants.white : AppConstants.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              align: TextAlign.start,
            ),
            const SizeBoxH(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: AlertDialogButtonWidget(
                    onTap: () {
                      context.pop();
                    },
                    text: "Cancel",
                    buttonBgColor: AppConstants.white,
                    buttonBorderColor: AppConstants.darkBlue,
                    textColor: AppConstants.darkBlue,
                    isDarkModeOn: isDarkModeOn,
                  ),
                ),
                Expanded(
                  child: AlertDialogButtonWidget(
                    onTap: onTap,
                    text: buttonText,
                    buttonBgColor: AppConstants.red,
                    buttonBorderColor: AppConstants.red,
                    textColor: AppConstants.white,
                    isDarkModeOn: isDarkModeOn,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AlertDialogButtonWidget extends StatelessWidget {
  final void Function() onTap;
  final Color buttonBgColor;
  final Color buttonBorderColor;
  final Color textColor;
  final String text;
  final bool isDarkModeOn;
  const AlertDialogButtonWidget({
    super.key,
    required this.onTap,
    required this.buttonBgColor,
    required this.buttonBorderColor,
    required this.textColor,
    required this.text,
    required this.isDarkModeOn,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Container(
        height: Responsive.height * 5,
        width: Responsive.width * 30,
        decoration: BoxDecoration(
          color: buttonBgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: buttonBorderColor,
            width: 1,
          ),
        ),
        child: Center(
          child: CommonTextWidget(
            color: textColor,
            text: text,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

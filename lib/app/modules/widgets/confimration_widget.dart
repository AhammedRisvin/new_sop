import 'package:flutter/material.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/modules/widgets/common_widgets.dart';

import '../../helpers/extentions.dart';
import '../../utils/app_constants.dart';

class ConfirmationWidget extends StatelessWidget {
  final String title;
  final String message;
  final void Function() onTap;
  final void Function() onCancel;
  final bool isDarkModeOn;
  final String buttonText;
  const ConfirmationWidget({
    super.key,
    required this.title,
    required this.message,
    required this.onTap,
    required this.isDarkModeOn,
    this.buttonText = "Remove",
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        height: Responsive.height * 23,
        width: Responsive.width * 100,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDarkModeOn ? AppConstants.black : AppConstants.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              fontSize: 14,
              fontWeight: FontWeight.w400,
              align: TextAlign.start,
            ),
            const SizeBoxH(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AlertDialogButtonWidget(
                  onTap: onCancel,
                  text: "Cancel",
                  buttonBgColor: isDarkModeOn
                      ? AppConstants.commonGold
                      : AppConstants.darkBlue,
                  buttonBorderColor: isDarkModeOn
                      ? AppConstants.commonGold
                      : AppConstants.darkBlue,
                  textColor:
                      isDarkModeOn ? AppConstants.black : AppConstants.white,
                  isDarkModeOn: isDarkModeOn,
                ),
                AlertDialogButtonWidget(
                  onTap: onTap,
                  text: buttonText,
                  buttonBgColor: AppConstants.red,
                  buttonBorderColor: AppConstants.red,
                  textColor: AppConstants.white,
                  isDarkModeOn: isDarkModeOn,
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
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

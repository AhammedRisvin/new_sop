import 'package:flutter/material.dart';

import '../../../utils/app_constants.dart';
import '../../widgets/common_widgets.dart';

class RowTextWidget extends StatelessWidget {
  final String leftText;
  final String rightText;
  final double fontSize;
  final bool isFromTotalPrice;
  final bool isDarkModeOn;
  const RowTextWidget({
    super.key,
    required this.leftText,
    required this.rightText,
    this.fontSize = 14,
    this.isFromTotalPrice = false,
    required this.isDarkModeOn,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonTextWidget(
          color: isFromTotalPrice
              ? isDarkModeOn
                  ? AppConstants.commonGold
                  : AppConstants.darkBlue
              : isDarkModeOn
                  ? AppConstants.white
                  : AppConstants.black,
          fontSize: isFromTotalPrice ? 18 : fontSize,
          text: leftText,
          fontWeight: isFromTotalPrice ? FontWeight.w700 : FontWeight.w500,
        ),
        CommonTextWidget(
          color: isFromTotalPrice
              ? isDarkModeOn
                  ? AppConstants.commonGold
                  : AppConstants.darkBlue
              : isDarkModeOn
                  ? AppConstants.white
                  : AppConstants.black,
          fontSize: isFromTotalPrice ? 18 : fontSize,
          text: rightText,
          fontWeight: isFromTotalPrice ? FontWeight.w700 : FontWeight.w500,
        ),
      ],
    );
  }
}

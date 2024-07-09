import 'package:flutter/material.dart';

import '../../../utils/app_constants.dart';
import '../../widgets/common_widgets.dart';

class CartAmountListingWidget extends StatelessWidget {
  const CartAmountListingWidget({
    super.key,
    required this.isDarkModeOn,
    required this.title,
    required this.amount,
  });

  final bool isDarkModeOn;
  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonTextWidget(
          color: isDarkModeOn ? AppConstants.white : AppConstants.black,
          text: title,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        CommonTextWidget(
          color: isDarkModeOn ? AppConstants.white : AppConstants.black,
          text: amount,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}

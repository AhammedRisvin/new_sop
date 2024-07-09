import 'package:flutter/material.dart';
import 'package:sophwe_newmodule/app/modules/pharma/address/view_model/address_provider.dart';

import '../../../../utils/app_constants.dart';
import '../../../widgets/common_widgets.dart';

class HomeOrWorkWidget extends StatelessWidget {
  const HomeOrWorkWidget({
    super.key,
    required this.isDarkModeOn,
    required this.text,
    this.onTap,
    required this.provider,
  });

  final bool isDarkModeOn;
  final String text;
  final void Function()? onTap;
  final PharmaAddressProvider provider;

  @override
  Widget build(BuildContext context) {
    final isSelected = provider.addressType == text;
    return CommonInkwell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color:
                isDarkModeOn ? AppConstants.commonGold : AppConstants.darkBlue,
          ),
          color: isDarkModeOn
              ? isSelected
                  ? AppConstants.commonGold
                  : AppConstants.transparent
              : isSelected
                  ? AppConstants.darkBlue
                  : AppConstants.transparent,
        ),
        child: Center(
          child: CommonTextWidget(
            color: isDarkModeOn
                ? isSelected
                    ? AppConstants.black
                    : AppConstants.white
                : isSelected
                    ? AppConstants.white
                    : AppConstants.black,
            text: text,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

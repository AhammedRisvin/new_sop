import 'package:flutter/material.dart';

import '../../../../../helpers/extentions.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../widgets/common_widgets.dart';

class ReminderDoseSelectingWidget extends StatelessWidget {
  const ReminderDoseSelectingWidget({
    super.key,
    required this.isDarkModeOn,
    required this.hintText,
    this.onTap,
  });

  final bool isDarkModeOn;
  final String hintText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Container(
        width: Responsive.width * 100,
        height: Responsive.height * 6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppConstants.black10,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: CommonTextWidget(
            color:
                isDarkModeOn ? AppConstants.tInactive : AppConstants.tInactive,
            text: hintText,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

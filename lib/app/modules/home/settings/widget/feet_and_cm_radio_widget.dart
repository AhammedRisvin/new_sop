import 'package:flutter/material.dart';

import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../widgets/common_widgets.dart';

class FeetAndCmWidget extends StatelessWidget {
  const FeetAndCmWidget({
    super.key,
    required this.isDarkModeOn,
    required this.title,
    required this.isSelected,
    required this.onSelect,
  });

  final bool isDarkModeOn;
  final String title;
  final bool isSelected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onSelect,
      child: Row(
        children: [
          CircleAvatar(
            radius: 10,
            backgroundColor:
                isDarkModeOn ? AppConstants.commonGold : AppConstants.darkBlue,
            child: CircleAvatar(
              radius: 8,
              backgroundColor:
                  isDarkModeOn ? AppConstants.black : AppConstants.white,
              child: CircleAvatar(
                radius: 7,
                backgroundColor: isDarkModeOn
                    ? isSelected
                        ? AppConstants.commonGold
                        : AppConstants.black
                    : isSelected
                        ? AppConstants.darkBlue
                        : AppConstants.white,
              ),
            ),
          ),
          const SizeBoxV(5),
          CommonTextWidget(
            color: isDarkModeOn ? AppConstants.white : AppConstants.black,
            text: title,
            fontSize: 14,
            letterSpacing: -0.1,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}

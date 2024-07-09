import 'package:flutter/material.dart';

import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_images.dart';
import '../../../../widgets/common_widgets.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({
    super.key,
    required this.isDarkModeOn,
    this.onSelected,
  });

  final bool isDarkModeOn;
  final Function(String)? onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: '&price=1',
          child: CommonTextWidget(
            color: isDarkModeOn ? AppConstants.black : AppConstants.white,
            text: 'Low to High',
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        PopupMenuItem<String>(
          value: '&price=-1',
          child: CommonTextWidget(
            color: isDarkModeOn ? AppConstants.black : AppConstants.white,
            text: 'High to Low',
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        PopupMenuItem<String>(
          value: '&popularity=true',
          child: CommonTextWidget(
            color: isDarkModeOn ? AppConstants.black : AppConstants.white,
            text: 'Popularity',
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
      icon: Image.asset(
        AppImages.filterIcon,
        height: 20,
        color: isDarkModeOn ? AppConstants.commonGold : AppConstants.darkBlue,
      ),
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: isDarkModeOn ? AppConstants.commonGold : AppConstants.darkBlue,
    );
  }
}

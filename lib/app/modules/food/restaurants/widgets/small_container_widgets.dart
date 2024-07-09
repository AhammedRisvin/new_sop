import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/extentions.dart';
import '../../../../utils/app_constants.dart';
import '../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../widgets/common_widgets.dart';

class SmallContainerWidgets extends StatelessWidget {
  final String? text;
  final bool isCategory;
  final bool isSelected;

  // final double? radius;
  // final double? horizontal;
  // final double? vertical;
  // final double? width;
  const SmallContainerWidgets(
      {this.isSelected = false,
      this.isCategory = false,
      //   this.width,
      // this.horizontal,
      // this.vertical,
      // this.radius,
      this.text,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
        selector: (_, value) => value.isDarkModeOn,
        builder: (context, isDarkModeOn, _) {
          return Container(
            width: Responsive.width * 22,
            decoration: BoxDecoration(
                color:
                    isDarkModeOn ? const Color(0xff343434) : AppConstants.white,
                borderRadius: BorderRadius.circular(isCategory ? 10 : 6)),
            padding: EdgeInsets.symmetric(
                horizontal: isCategory ? 14 : 11, vertical: isCategory ? 7 : 6),
            child: CommonTextWidget(
              color: isDarkModeOn ? AppConstants.white : AppConstants.black,
              text: text ?? 'Take away',
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          );
        });
  }
}

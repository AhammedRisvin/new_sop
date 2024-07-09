import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/app_constants.dart';
import '../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../widgets/common_widgets.dart';

class StarReviewContainer extends StatelessWidget {
  final Color? color;
  final EdgeInsetsGeometry? padding;
  const StarReviewContainer({super.key, this.color, this.padding});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
        selector: (_, value) => value.isDarkModeOn,
        builder: (context, isDarkModeOn, _) {
          return Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
            padding: padding ??
                const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: const Row(
              children: [
                Icon(
                  Icons.star,
                  color: AppConstants.darkPrimaryColor,
                  size: 18,
                ),
                CommonTextWidget(
                  color: AppConstants.white,
                  text: '4.2',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          );
        });
  }
}

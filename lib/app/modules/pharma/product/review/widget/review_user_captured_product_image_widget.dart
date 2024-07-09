import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/app_constants.dart';
import '../../../home/home screen/view model/theme_provider.dart';

class ReviewUserCaptureProductiveWidget extends StatelessWidget {
  final String? reviewImage;
  const ReviewUserCaptureProductiveWidget({super.key, this.reviewImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
          color: context.watch<ThemeProvider>().isDarkModeOn == true
              ? AppConstants.black10
              : const Color(0xFFF9F9FB),
          borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: Image.network(fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/404erroe.png',
            fit: BoxFit.fill,
          );
        }, reviewImage ?? ""),
      ),
    );
  }
}

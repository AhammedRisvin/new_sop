import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/home%20screen/view%20model/theme_provider.dart';
import 'package:sophwe_newmodule/app/modules/widgets/common_widgets.dart';

import '../../helpers/extentions.dart';
import '../../utils/app_constants.dart';

class EmptyScreenWidget extends StatelessWidget {
  final String text;
  final String image;
  final double? height;
  final bool isFromServerError;
  final void Function()? ontap;
  const EmptyScreenWidget({
    super.key,
    required this.text,
    required this.image,
    required this.height,
    this.isFromServerError = false,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (context, provider) => provider.isDarkModeOn,
      builder: (context, isDarkModeOn, child) => Container(
        color: isDarkModeOn ? AppConstants.black : AppConstants.white,
        height: height,
        width: Responsive.width * 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: Responsive.height * 25,
              width: Responsive.width * 25,
            ),
            CommonTextWidget(
              color: AppConstants.tInactive,
              text: text,
              align: TextAlign.center,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
              wordSpacing: 0.5,
            ),
            const SizeBoxH(20),
            isFromServerError
                ? CommonButton(
                    ontap: ontap,
                    height: Responsive.height * 6,
                    width: Responsive.width * 80,
                    text: "Retry",
                    isDarkMode: isDarkModeOn,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

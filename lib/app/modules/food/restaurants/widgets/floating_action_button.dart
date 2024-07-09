import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/extentions.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../widgets/common_widgets.dart';

class FloatingActionButtonWidgets extends StatelessWidget {
  const FloatingActionButtonWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
        selector: (_, value) => value.isDarkModeOn,
        builder: (context, isDarkModeOn, _) {
          return CustomPopup(
            backgroundColor:
                isDarkModeOn ? const Color(0xff333333) : AppConstants.white,
            content: Container(
              width: Responsive.width * 40,
              height: Responsive.height * 30,
              decoration: BoxDecoration(
                color:
                    isDarkModeOn ? const Color(0xff333333) : AppConstants.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Scrollbar(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonTextWidget(
                            color: index == 0
                                ? isDarkModeOn
                                    ? AppConstants.darkPrimaryColor
                                    : AppConstants.darkBlue
                                : isDarkModeOn
                                    ? AppConstants.white
                                    : AppConstants.black,
                            text: 'Recomended  ',
                            fontSize: index == 0 ? 16 : 16,
                            fontWeight:
                                index == 0 ? FontWeight.w700 : FontWeight.w400,
                          ),
                          SizeBoxV(Responsive.width * 5),
                          CommonTextWidget(
                            color: index == 0
                                ? isDarkModeOn
                                    ? AppConstants.darkPrimaryColor
                                    : AppConstants.darkBlue
                                : isDarkModeOn
                                    ? AppConstants.white
                                    : AppConstants.black,
                            text: '8',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          SizeBoxV(Responsive.width * 1)
                        ],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizeBoxH(Responsive.height * 1),
                    itemCount: 10),
              ),
            ),
            child: Container(
              width: Responsive.width * 14,
              height: Responsive.height * 7,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppConstants.darkBlue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.butonImage),
                  CommonTextWidget(
                    color:
                        isDarkModeOn ? AppConstants.black : AppConstants.white,
                    text: 'MENU',
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

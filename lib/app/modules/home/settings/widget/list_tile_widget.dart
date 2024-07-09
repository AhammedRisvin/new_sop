import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';

import '../../../../helpers/extentions.dart';
import '../../../../utils/app_constants.dart';
import '../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../widgets/common_widgets.dart';

class SettingsCommonListTileWidget extends StatelessWidget {
  const SettingsCommonListTileWidget({
    super.key,
    required this.isDarkModeOn,
    this.isFromDarkMode = false,
    this.isShowLeadingIcon = true,
    required this.ontap,
    required this.image,
    required this.title,
    this.height = 12,
  });

  final bool isDarkModeOn;
  final bool isFromDarkMode;
  final bool isShowLeadingIcon;
  final void Function() ontap;
  final String image;
  final String title;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: ontap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizeBoxH(height),
          Row(
            children: [
              isShowLeadingIcon
                  ? Image.asset(
                      image,
                      height: 24,
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                    )
                  : const SizedBox.shrink(),
              SizedBox(
                width: Responsive.width * 2,
              ),
              SizedBox(
                child: CommonTextWidget(
                  align: TextAlign.start,
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                  text: title,
                  fontSize: 14,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              isFromDarkMode
                  ? Transform.scale(
                      scale: 0.85,
                      child: Switch(
                        value: isDarkModeOn,
                        onChanged: (value) {
                          Provider.of<ThemeProvider>(context, listen: false)
                              .updateTheme();
                        },
                        activeTrackColor: isDarkModeOn
                            ? AppConstants.commonGold
                            : AppConstants.darkBlue,
                        inactiveTrackColor: AppConstants.black10,
                        inactiveThumbColor: AppConstants.white,
                      ),
                    )
                  : Icon(
                      Icons.arrow_forward_ios,
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      size: 16,
                    )
            ],
          ),
        ],
      ),
    );
  }
}

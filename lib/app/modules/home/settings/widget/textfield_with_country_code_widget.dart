import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../helpers/extentions.dart';
import '../../../../utils/app_constants.dart';
import '../../../widgets/common_widgets.dart';
import '../profile_edit/view_model/profile_edit_provider.dart';

class TextFieldWithCountryCodeWidget extends StatelessWidget {
  const TextFieldWithCountryCodeWidget({
    super.key,
    required TextEditingController phoneController,
    required this.isDarkModeOn,
    required this.provider,
  }) : _phoneController = phoneController;

  final TextEditingController _phoneController;
  final bool isDarkModeOn;
  final ProfileEditProvider provider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CountryListPick(
          theme: CountryTheme(
            isShowFlag: false,
            isShowTitle: false,
            isShowCode: true,
            isDownIcon: true,
            showEnglishName: true,
          ),
          initialSelection: provider.countryCodeCtrl,
          onChanged: (CountryCode? code) {
            provider.updateCountryCode(
              code?.dialCode ?? 'AE',
            );
          },
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: AppConstants.darkBlue,
              statusBarIconBrightness: Brightness.light,
            ),
            backgroundColor: AppConstants.darkBlue,
            title: Text(
              'Choose Country',
              style: TextStyle(
                color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                fontSize: 16,
              ),
            ),
          ),
          pickerBuilder: (context, CountryCode? code) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppConstants.black10,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  CommonTextWidget(
                    text: "Country Code",
                    color:
                        isDarkModeOn ? AppConstants.white : AppConstants.black,
                    fontSize: 8,
                  ),
                  Row(
                    children: [
                      CommonTextWidget(
                        text: code?.dialCode ?? "+971",
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: isDarkModeOn
                            ? AppConstants.commonGold
                            : AppConstants.darkBlue,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        Expanded(
          child: Container(
            height: Responsive.height * 6,
            margin: EdgeInsets.only(
              left: Responsive.width * 2,
            ),
            decoration: BoxDecoration(
              color: isDarkModeOn
                  ? AppConstants.transparent
                  : AppConstants.transparent,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: AppConstants.transparent,
              ),
            ),
            child: CommonTextFormField(
              bgColor: AppConstants.transparent,
              hintTextColor: AppConstants.black40,
              hintText: "",
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              controller: _phoneController,
              maxLength: provider.maxLength,
              color: isDarkModeOn ? AppConstants.white : AppConstants.black,
              borderColor:
                  isDarkModeOn ? AppConstants.white : AppConstants.black10,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../helpers/extentions.dart';
import '../../../../utils/app_constants.dart';
import '../../../widgets/common_widgets.dart';
import '../view_model/address_provider.dart';

class FoodCountryCodeWithPhoneFieldWidget extends StatelessWidget {
  const FoodCountryCodeWithPhoneFieldWidget({
    super.key,
    required TextEditingController phoneController,
    required this.provider,
    this.validator,
  }) : _phoneController = phoneController;

  final TextEditingController _phoneController;
  final FoodAddressProvider provider;
  final String? Function(String?)? validator;

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
              code?.dialCode ?? '+917',
            );
          },
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: AppConstants.darkBlue,
              statusBarIconBrightness: Brightness.light,
            ),
            backgroundColor: AppConstants.darkBlue,
            title: const Text(
              'Choose Country',
              style: TextStyle(
                color: AppConstants.white,
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
                  const CommonTextWidget(
                    text: "Country Code",
                    color: AppConstants.black,
                    fontSize: 8,
                  ),
                  Row(
                    children: [
                      CommonTextWidget(
                        text: code?.dialCode ?? "+971",
                        color: AppConstants.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: AppConstants.darkBlue,
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
              color: AppConstants.white,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: AppConstants.transparent,
              ),
            ),
            child: CommonTextFormField(
              bgColor: AppConstants.white,
              hintTextColor: AppConstants.black40,
              hintText: "phone Number",
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              controller: _phoneController,
              maxLength: provider.maxLength,
              validator: validator,
            ),
          ),
        ),
      ],
    );
  }
}

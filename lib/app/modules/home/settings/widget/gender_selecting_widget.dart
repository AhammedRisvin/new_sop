import 'package:flutter/material.dart';

import '../../../../helpers/extentions.dart';
import '../../../../utils/app_constants.dart';
import '../profile_edit/view_model/profile_edit_provider.dart';

class GenderSelectingWidget extends StatelessWidget {
  const GenderSelectingWidget({
    super.key,
    required this.isDarkModeOn,
    required this.provider,
  });

  final bool isDarkModeOn;
  final ProfileEditProvider provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppConstants.black10,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      height: Responsive.height * 6,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          value: provider.selectedGender,
          onChanged: (String? newValue) {
            provider.updateSelectedGender(newValue!);
          },
          icon: const Icon(
            Icons.keyboard_arrow_down_outlined,
          ),
          items: <String>[
            'Male',
            'Female',
            'Other',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                  fontSize: 14,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

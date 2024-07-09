import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_constants.dart';
import '../../pharma/home/home screen/view model/theme_provider.dart';
import '../../widgets/common_widgets.dart';

class Searchwidgets extends StatelessWidget {
  const Searchwidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
        selector: (_, value) => value.isDarkModeOn,
        builder: (context, isDarkModeOn, _) {
          return Container(
            decoration: BoxDecoration(
                color:
                    isDarkModeOn ? AppConstants.darkGrey : AppConstants.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x21000000), // Equivalent to #00000021
                    offset: Offset(0, 0),
                    blurRadius: 3,
                  ),
                ]),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CommonTextFormField(
              bgColor:
                  isDarkModeOn ? AppConstants.darkGrey : AppConstants.white,
              controller: TextEditingController(),
              hintText: 'Search Product',
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.search,
              prefixIcon: const Icon(
                Icons.search_outlined,
                color: AppConstants.black40,
              ),
              suffixIcon: const Icon(
                Icons.mic_none_outlined,
                color: AppConstants.black40,
              ),
              noBordr: true,
            ),
          );
        });
  }
}

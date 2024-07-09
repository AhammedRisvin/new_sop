import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/extentions.dart';
import '../../../utils/app_constants.dart';
import '../../pharma/home/home screen/view model/theme_provider.dart';
import '../../widgets/common_widgets.dart';

class CommonAppBarWidgets extends StatelessWidget {
  final String title;
  const CommonAppBarWidgets({this.title = 'All Dishes', super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
        selector: (_, value) => value.isDarkModeOn,
        builder: (context, isDarkModeOn, _) {
          return AppBar(
            backgroundColor:
                isDarkModeOn ? AppConstants.black : AppConstants.white,
            title: Row(
              children: [
                CommonTextWidget(
                  text: title,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                ),
                Switch(
                  value: isDarkModeOn,
                  onChanged: (value) {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .updateTheme();
                  },
                ),
              ],
            ),
            leadingWidth: Responsive.width * 10,
            leading: CommonInkwell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(Icons.arrow_back_ios,
                    color:
                        isDarkModeOn ? AppConstants.white : AppConstants.black),
              ),
            ),
          );
        });
  }
}

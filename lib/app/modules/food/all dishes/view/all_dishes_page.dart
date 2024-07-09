import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/extentions.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/modules/food/widgets/searchwidgets.dart';
import 'package:sophwe_newmodule/app/modules/widgets/common_widgets.dart';
import 'package:sophwe_newmodule/app/utils/app_constants.dart';

import '../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/toppicscard.dart';

class AllDishesScreen extends StatelessWidget {
  const AllDishesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (_, value) => value.isDarkModeOn,
      builder: (context, isDarkModeOn, _) {
        return Scaffold(
          backgroundColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          appBar: PreferredSize(
            preferredSize: Size(Responsive.width * 100, Responsive.height * 12),
            child: const Column(
              children: [
                CommonAppBarWidgets(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Searchwidgets(),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizeBoxH(Responsive.height * 2),
                  CommonTextWidget(
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      text: 'All Dishes',
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  SizeBoxH(Responsive.height * 2),
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: 8,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 4 / 4.8,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return const ToppicscardWdgets();
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

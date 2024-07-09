import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';

import '../../../../helpers/extentions.dart';
import '../../../../utils/app_constants.dart';
import '../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../widgets/common_widgets.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/order_and_review_product_card.dart';

class FoodOrderHistoryScreen extends StatelessWidget {
  const FoodOrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, _) {
        return Scaffold(
          backgroundColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          appBar: PreferredSize(
            preferredSize: Size(Responsive.width * 100, Responsive.height * 6),
            child: const CommonAppBarWidgets(title: 'Order History'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return const OrderAndReviewCardWidgets(
                          isOrder: true,
                          isFavorite: true,
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizeBoxH(Responsive.height * 3),
                      itemCount: 5),
                  SizeBoxH(Responsive.height * 1),
                  CommonTextWidget(
                    color:
                        isDarkModeOn ? AppConstants.white : AppConstants.black,
                    text: "Yesterday",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return const OrderAndReviewCardWidgets(
                          isOrder: true,
                          isFavorite: true,
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizeBoxH(Responsive.height * 3),
                      itemCount: 5),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

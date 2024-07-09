import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/app_router.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/home%20screen/view%20model/theme_provider.dart';
import 'package:sophwe_newmodule/app/utils/app_constants.dart';
import 'package:sophwe_newmodule/app/utils/app_images.dart';

import '../../../../helpers/extentions.dart';
import '../../../../helpers/size_box.dart';
import '../../../widgets/common_widgets.dart';

class FoodOrderSuccessScreen extends StatefulWidget {
  const FoodOrderSuccessScreen({
    super.key,
  });

  @override
  State<FoodOrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<FoodOrderSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, child) => Scaffold(
        backgroundColor: isDarkModeOn ? AppConstants.black : AppConstants.white,
        body: Container(
          height: Responsive.height * 100,
          width: Responsive.width * 100,
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizeBoxH(Responsive.height * 12),
              CommonTextWidget(
                color: isDarkModeOn
                    ? AppConstants.commonGold
                    : AppConstants.darkBlue,
                text: "Order Success",
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              Image.asset(
                AppImages.orderSuccessImage,
                height: Responsive.height * 40,
                width: Responsive.width * 80,
              ),
              CommonTextWidget(
                color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                text: " Thank you! \n Ahmed, We have received your order ",
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              SizeBoxH(Responsive.height * 3),
              Center(
                child: SizedBox(
                  width: Responsive.width * 70,
                  child: CommonTextWidget(
                    color:
                        isDarkModeOn ? AppConstants.white : AppConstants.black,
                    text:
                        "Ywe might contact you for tracking and confirming your order ",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 24,
                  ),
                ),
              ),
              SizeBoxH(Responsive.height * 4),
              CommonButton(
                text: "View order",
                isDarkMode: isDarkModeOn,
                height: Responsive.height * 6,
                ontap: () {
                  context.push(AppRouter.foodOrderHistoryScreen);
                },
              ),
              SizeBoxH(Responsive.height * 1),
              TextButton(
                onPressed: () {
                  // context.pushNamed(AppRouter.tab);
                },
                child: CommonTextWidget(
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                  text: "Continue shopping",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/home%20screen/view%20model/theme_provider.dart';
import 'package:sophwe_newmodule/app/modules/pharma/product/order%20history/view_model/order_history_provider.dart';
import 'package:sophwe_newmodule/app/utils/app_constants.dart';

import '../../../helpers/app_router.dart';
import '../../../helpers/extentions.dart';
import '../../../helpers/size_box.dart';
import '../../widgets/common_widgets.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({
    super.key,
  });

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/orderSuccess.png",
                height: Responsive.height * 30,
              ),
              SizeBoxH(Responsive.height * 2),
              CommonTextWidget(
                color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                text: "  Order placed Successfully ",
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              SizeBoxH(Responsive.height * 2),
              CommonTextWidget(
                color: isDarkModeOn ? AppConstants.white : AppConstants.black60,
                text:
                    "Your items has been placed and is on it’s way to being processed",
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              SizeBoxH(Responsive.height * 4),
              CommonButton(
                text: "Track order",
                isDarkMode: isDarkModeOn,
                height: Responsive.height * 6,
                ontap: () {
                  context.pushReplacementNamed(AppRouter.orderHistoryScreen);
                  context.read<OrderHistoryProvider>().historyFilterStatus =
                      "Placed";
                },
              ),
              SizeBoxH(Responsive.height * 1),
              TextButton(
                onPressed: () {
                  context.pushNamed(AppRouter.mainBottomNav);
                },
                child: CommonTextWidget(
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                  text: " Back to Home",
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

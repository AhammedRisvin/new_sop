import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/modules/widgets/common_widgets.dart';

import '../../../../../helpers/app_router.dart';
import '../../../../../helpers/extentions.dart';
import '../../../../../helpers/size_box.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_images.dart';
import '../../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../widgets/add_on_widgets.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/row_and_text_widgets.dart';
import '../../widgets/order_history_widgets.dart';

class FoodOrderHistoryDetailsScreen extends StatefulWidget {
  const FoodOrderHistoryDetailsScreen({
    super.key,
  });

  @override
  State<FoodOrderHistoryDetailsScreen> createState() =>
      _OrderHistoryDetailsScreenState();
}

class _OrderHistoryDetailsScreenState
    extends State<FoodOrderHistoryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, _) => Scaffold(
        backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(Responsive.width * 100, Responsive.height * 6),
          child: const CommonAppBarWidgets(title: 'Order Details'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FoodOrderHistoryProductWidget(
                isDarkModeOn: isDarkModeOn,
              ),
              SizeBoxH(Responsive.height * 6),
              FoodRowTextWidget(
                leftText: "Discountable amount",
                rightText: "76.98 AED",
                isDarkModeOn: isDarkModeOn,
              ),
              SizeBoxH(Responsive.height * 2),
              FoodRowTextWidget(
                leftText: "Payable",
                rightText: "76.98 AED",
                isDarkModeOn: isDarkModeOn,
              ),
              SizeBoxH(Responsive.height * 2),
              FoodRowTextWidget(
                leftText: "Total amount",
                rightText: "76.98 AED",
                isFromTotalPrice: true,
                isDarkModeOn: isDarkModeOn,
              ),
              SizeBoxH(Responsive.height * 1),
              const AddOnWdgets(),
              Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  width: Responsive.width * 100,
                  // height: Responsive.height * 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDarkModeOn
                          ? AppConstants.black10
                          : AppConstants.black10,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextWidget(
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black,
                        text: 'Order Status',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      SizeBoxH(Responsive.height * 1),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return StepperWidget(
                            text: "Delivered",
                            date: DateTime.now(),
                            subText: "Your order has been delivered",
                            length: 2,
                            index: 0,
                            isDarkModeOn: isDarkModeOn,
                          );
                        },
                      ),
                    ],
                  )),
              SizeBoxH(Responsive.height * 2),
              CommonInkwell(
                onTap: () {
                  context.push(AppRouter.foodAddReviewScreen);
                },
                child: Container(
                  width: Responsive.width * 100,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppConstants.black10,
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        AppImages.addReviewIcon,
                        height: Responsive.height * 4,
                      ),
                      const SizeBoxV(20),
                      CommonTextWidget(
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black,
                        fontSize: 16,
                        text: "Add a Review",
                        fontWeight: FontWeight.w600,
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black,
                        size: 18,
                      )
                    ],
                  ),
                ),
              ),
              SizeBoxH(Responsive.height * 2),
            ],
          ),
        ),
      ),
    );
  }
}

class StepperWidget extends StatelessWidget {
  final String? text;
  final DateTime? date;
  final String? subText;
  final int length, index;
  final bool isDarkModeOn;
  const StepperWidget({
    this.date,
    this.subText,
    this.text,
    super.key,
    required this.length,
    required this.index,
    required this.isDarkModeOn,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const CircleAvatar(
              radius: 15,
              backgroundColor: Color(0xff28A745),
              child: Icon(
                Icons.check,
                color: AppConstants.white,
                size: 20,
              ),
            ),
            Visibility(
              visible: length != index + 1,
              child: SizedBox(
                height: Responsive.height * 6,
                child: const VerticalDivider(
                  color: Color(0xff28A745),
                  thickness: 6,
                ),
              ),
            ),
          ],
        ),
        SizeBoxV(Responsive.width * 2),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color:
                        isDarkModeOn ? AppConstants.white : AppConstants.black,
                  ),
                  children: <TextSpan>[
                    const TextSpan(text: "Ordered "),
                    TextSpan(
                      text: 'Aug 5th Sat, 2023 , 05:05 PM',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: isDarkModeOn
                              ? AppConstants.white
                              : const Color(0xff8391A1)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/extentions.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/utils/app_images.dart';

import '../../../../utils/app_constants.dart';
import '../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../widgets/common_widgets.dart';
import '../view_model/review_add_provider.dart';

class FoodAddReviewScreen extends StatelessWidget {
  const FoodAddReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
        selector: (_, value) => value.isDarkModeOn,
        builder: (context, isDarkModeOn, _) {
          return Scaffold(
            backgroundColor:
                isDarkModeOn ? AppConstants.black : AppConstants.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizeBoxH(Responsive.height * 6),
                    CommonInkwell(
                      onTap: () {
                        context.pop();
                      },
                      child: Icon(Icons.arrow_back_ios,
                          color: isDarkModeOn
                              ? AppConstants.white
                              : AppConstants.black),
                    ),
                    SizeBoxH(Responsive.height * 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.deliveryboyimage,
                        ),
                      ],
                    ),
                    SizeBoxH(Responsive.height * 3),
                    Center(
                      child: CommonTextWidget(
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black,
                        fontSize: 20,
                        text: "What could’ve been better?",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizeBoxH(Responsive.height * 2),
                    Consumer<ReviewAddProvider>(
                      builder: (context, obj, _) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: RatingBar.builder(
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                unratedColor: AppConstants.uselctedStarGrey,
                                updateOnDrag: true,
                                itemSize: 32,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Color(0xffFF9F06)),
                                onRatingUpdate: (rating) {
                                  obj.ratingLengthFun(value: rating);
                                },
                              ),
                            ),
                            SizeBoxH(Responsive.height * 3),
                            CommonTextWidget(
                              color: isDarkModeOn
                                  ? AppConstants.white
                                  : AppConstants.black,
                              text: obj.ratinglenght == 1
                                  ? "Very Poor"
                                  : obj.ratinglenght == 2
                                      ? "Poor"
                                      : obj.ratinglenght == 3
                                          ? "Okay"
                                          : obj.ratinglenght == 4
                                              ? "Good"
                                              : "Very Good",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizeBoxH(16),
                            Wrap(
                              direction: Axis.horizontal,

                              spacing: 8.0, // spacing between adjacent chips
                              runSpacing:
                                  10.0, // spacing between lines of chips

                              children: obj.reviewsList.map((item) {
                                return OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                          color: isDarkModeOn
                                              ? AppConstants.white
                                              : AppConstants.black),
                                      backgroundColor: isDarkModeOn
                                          ? AppConstants.black
                                          : AppConstants.white,
                                    ),
                                    child: CommonTextWidget(
                                      text: item,
                                      color: isDarkModeOn
                                          ? AppConstants.white
                                          : AppConstants.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ));
                              }).toList(),
                            ),
                          ],
                        );
                      },
                    ),
                    SizeBoxH(Responsive.height * 4),
                    CommonTextWidget(
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      text: "Any more notes?",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    SizeBoxH(Responsive.height * 1),
                    CommonTextFormField(
                      bgColor: isDarkModeOn
                          ? AppConstants.darkGrey
                          : AppConstants.white,
                      hintText: 'Type something',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.unspecified,
                      controller: TextEditingController(),
                      maxLine: 6,
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      borderColor: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black10,
                    ),
                    SizeBoxH(Responsive.height * 2),
                    CommonButton(
                        ontap: () {},
                        height: Responsive.height * 5.5,
                        text: 'Submit',
                        isDarkMode: isDarkModeOn),
                    SizeBoxH(Responsive.height * 2),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

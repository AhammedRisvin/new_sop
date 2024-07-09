import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/extentions.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../widgets/common_widgets.dart';
import '../../widgets/order_and_review_product_card.dart';

class FoodReviewScreen extends StatelessWidget {
  const FoodReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, _) => Scaffold(
        backgroundColor: isDarkModeOn ? AppConstants.black : AppConstants.white,
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 1.6,
                child: Stack(
                  children: [
                    Container(
                      height: Responsive.height * 100,
                      width: Responsive.width * 100,
                      color: const Color(0xffEAEAEA),
                      child: Column(
                        children: [
                          CachedImageWidget(
                            imageUrl:
                                "https://t4.ftcdn.net/jpg/04/95/28/65/240_F_495286577_rpsT2Shmr6g81hOhGXALhxWOfx1vOQBa.jpg",
                            width: Responsive.width * 100,
                            height: Responsive.height * 48,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 35,
                      left: 1,
                      right: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: isDarkModeOn
                                  ? AppConstants.white
                                  : AppConstants.black,
                            ),
                          ),
                          Row(
                            children: [
                              Switch(
                                value: isDarkModeOn,
                                onChanged: (value) {
                                  Provider.of<ThemeProvider>(context,
                                          listen: false)
                                      .updateTheme();
                                },
                              ),
                              CommonInkwell(
                                onTap: () {},
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: AppConstants.white,
                                  child: Icon(Icons.favorite_border,
                                      color: AppConstants.black, size: 25),
                                ),
                              ),
                              SizeBoxV(Responsive.width * 3),
                              const CircleAvatar(
                                radius: 20,
                                backgroundColor: AppConstants.white,
                                child: Icon(Icons.share,
                                    color: AppConstants.black, size: 25),
                              ),
                              SizeBoxV(Responsive.width * 3),
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: Responsive.height * 40,
                      child: Container(
                        width: Responsive.width * 100,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: isDarkModeOn
                              ? AppConstants.black
                              : AppConstants.white,
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonTextWidget(
                                  color: isDarkModeOn
                                      ? AppConstants.white
                                      : AppConstants.black,
                                  text: "Based on 1666 rating",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: AppConstants.yellow,
                                      size: 16,
                                    ),
                                    CommonTextWidget(
                                      color: isDarkModeOn
                                          ? AppConstants.white
                                          : AppConstants.black,
                                      text: "4.7 ",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ],
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

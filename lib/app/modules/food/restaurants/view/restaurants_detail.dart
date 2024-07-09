import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/extentions.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../widgets/common_widgets.dart';
import '../widgets/floating_action_button.dart';
import '../widgets/list_of_categorys.dart';
import '../widgets/small_container_widgets.dart';
import '../widgets/star_and_review_widgets.dart';

class RestaurantsDetailScreen extends StatefulWidget {
  const RestaurantsDetailScreen({super.key});

  @override
  State<RestaurantsDetailScreen> createState() =>
      _RestaurantsDetailScreenState();
}

class _RestaurantsDetailScreenState extends State<RestaurantsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (_, value) => value.isDarkModeOn,
      builder: (context, isDarkModeOn, _) {
        return Scaffold(
          backgroundColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndDocked,
          floatingActionButton: const FloatingActionButtonWidgets(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Responsive.height * 80,
                  child: Stack(
                    children: [
                      CachedImageWidget(
                        imageUrl:
                            'https://t4.ftcdn.net/jpg/04/95/28/65/240_F_495286577_rpsT2Shmr6g81hOhGXALhxWOfx1vOQBa.jpg',
                        height: Responsive.height * 37,
                        width: Responsive.width * 100,
                      ),
                      Positioned(
                        top: Responsive.height * 5,
                        left: 20,
                        child: CommonInkwell(
                          onTap: () {
                            context.pop();
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: AppConstants.white,
                          ),
                        ),
                      ),
                      Positioned(
                        top: Responsive.height * 5,
                        right: 20,
                        child: Switch(
                          value: isDarkModeOn,
                          onChanged: (value) {
                            Provider.of<ThemeProvider>(context, listen: false)
                                .updateTheme();
                          },
                        ),
                      ),
                      Positioned(
                        top: Responsive.height * 29,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          width: Responsive.width * 90,
                          decoration: BoxDecoration(
                            color: isDarkModeOn
                                ? const Color(0xff161616)
                                : AppConstants.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isDarkModeOn
                                    ? const Color(0x64646440)
                                    : const Color(0x29000000),
                                offset: const Offset(0, 1),
                                blurRadius: 4,
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: CommonTextWidget(
                                          color: isDarkModeOn
                                              ? AppConstants.darkPrimaryColor
                                              : AppConstants.darkBlue,
                                          text: 'Yummy pasta Arabian',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          overFlow: TextOverflow.ellipsis,
                                          align: TextAlign.start,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            AppImages.fireImg,
                                            width: 20,
                                            height: 20,
                                          ),
                                          CommonTextWidget(
                                            color: isDarkModeOn
                                                ? AppConstants.white
                                                : AppConstants.black,
                                            text: '15-20 mins',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            overFlow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizeBoxH(Responsive.height * 0.5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: CommonTextWidget(
                                          color: isDarkModeOn
                                              ? AppConstants.white
                                              : AppConstants.black,
                                          text:
                                              'Fast food , Pizza , Burgersssssssssssssssssssssssssssssssssssssssssss',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          overFlow: TextOverflow.ellipsis,
                                          align: TextAlign.start,
                                        ),
                                      ),
                                      StarReviewContainer(
                                        color: isDarkModeOn
                                            ? const Color(0xff343434)
                                            : AppConstants.darkBlue,
                                      ),
                                    ],
                                  ),
                                  SizeBoxH(Responsive.height * 0.5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: isDarkModeOn
                                                ? const Color(0xffFF0000)
                                                : AppConstants.darkBlue,
                                          ),
                                          CommonTextWidget(
                                            color: isDarkModeOn
                                                ? AppConstants.white
                                                : AppConstants.black,
                                            text: 'Manjery',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                      const CommonTextWidget(
                                        color: AppConstants.black,
                                        text: '(100+reviews)',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                  SizeBoxH(Responsive.height * 1),
                                  CommonTextWidget(
                                    color: isDarkModeOn
                                        ? AppConstants.white
                                        : AppConstants.black,
                                    text: 'The Restaurants Offers',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizeBoxH(Responsive.height * 1.3),
                                  Row(
                                    children: [
                                      const SmallContainerWidgets(),
                                      SizeBoxV(Responsive.width * 3),
                                      const SmallContainerWidgets(
                                        text: 'Eat inside',
                                      ),
                                      SizeBoxV(Responsive.width * 3),
                                      const SmallContainerWidgets(
                                        text: 'Delivery',
                                      ),
                                      SizeBoxV(Responsive.width * 8),
                                    ],
                                  ),
                                  SizeBoxH(Responsive.height * 2.2),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.phone_in_talk,
                                            color: isDarkModeOn
                                                ? AppConstants.white
                                                : AppConstants.black,
                                            size: 15,
                                          ),
                                          SizeBoxV(Responsive.width * 1.5),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CommonTextWidget(
                                                color: isDarkModeOn
                                                    ? AppConstants.white
                                                    : AppConstants.black,
                                                text: 'Phone Number',
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              SizeBoxH(Responsive.height * 0.5),
                                              CommonTextWidget(
                                                color: isDarkModeOn
                                                    ? AppConstants.white
                                                    : AppConstants.black,
                                                text: '8592884671',
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.schedule,
                                            color: isDarkModeOn
                                                ? AppConstants.white
                                                : AppConstants.black,
                                            size: 15,
                                          ),
                                          CommonTextWidget(
                                            color: isDarkModeOn
                                                ? AppConstants.white
                                                : AppConstants.black,
                                            text: 'Open - 10 AM  close  12 PM',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizeBoxH(Responsive.height * 1.8),
                                  CommonTextWidget(
                                    color: isDarkModeOn
                                        ? AppConstants.white
                                        : AppConstants.black,
                                    text: 'Description',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              Container(
                                width: Responsive.width * 100,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(22)),
                                    color: isDarkModeOn
                                        ? const Color(0xff272626)
                                        : AppConstants.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: isDarkModeOn
                                            ? const Color(0x40000000)
                                            : AppConstants.white,
                                        offset: const Offset(0, 2),
                                        blurRadius: 13,
                                        spreadRadius: 0,
                                      ),
                                    ]),
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, bottom: 23),
                                child: CommonTextWidget(
                                  color: isDarkModeOn
                                      ? AppConstants.white
                                      : AppConstants.black,
                                  text:
                                      'Welcome to Farza, where we celebrate the beuty of the bounty of nature in every dish.. Nestled in the hear t of [Location], our vegetable-focused restaurant is a haven for those seeking fresh, vibrant, and wholesome',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  align: TextAlign.start,
                                ),
                              ),
                              SizeBoxH(Responsive.height * 1),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(AppImages.deliveryIcon),
                                  CommonTextWidget(
                                    color: isDarkModeOn
                                        ? AppConstants.white
                                        : AppConstants.black,
                                    text: ' | 2 Km free Delivery on your order',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    align: TextAlign.start,
                                  ),
                                  SizeBoxV(Responsive.width * 2),
                                  Icon(
                                    Icons.schedule,
                                    color: isDarkModeOn
                                        ? AppConstants.white
                                        : AppConstants.black,
                                    size: 15,
                                  ),
                                  CommonTextWidget(
                                    color: isDarkModeOn
                                        ? AppConstants.white
                                        : AppConstants.darkPrimaryColor,
                                    text: ' 15-30 min',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    align: TextAlign.start,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const ListOfCategorysWidgets()
              ],
            ),
          ),
        );
      },
    );
  }
}

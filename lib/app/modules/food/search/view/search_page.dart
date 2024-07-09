import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/extentions.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../widgets/common_widgets.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/searchwidgets.dart';
import '../view_model/food_search_provider.dart';

class SearchPageScreen extends StatelessWidget {
  const SearchPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
        selector: (_, value) => value.isDarkModeOn,
        builder: (context, isDarkModeOn, _) {
          return Scaffold(
            backgroundColor:
                isDarkModeOn ? AppConstants.black : AppConstants.white,
            appBar: PreferredSize(
              preferredSize:
                  Size(Responsive.width * 100, Responsive.height * 6),
              child: const CommonAppBarWidgets(title: 'Diet Food'),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Searchwidgets(),
                    SizeBoxH(Responsive.height * 2),
                    CommonTextWidget(
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      text: "Recent Search",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    SizeBoxH(Responsive.height * 2),
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: List.generate(
                        6,
                        (index) => Container(
                          decoration: BoxDecoration(
                            color: isDarkModeOn
                                ? AppConstants.darkGrey
                                : AppConstants.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(
                                    0x26000000), // Equivalent to #00000026
                                offset: Offset(0, 0),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                          child: FittedBox(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.history,
                                  color: isDarkModeOn
                                      ? AppConstants.white
                                      : AppConstants.black,
                                  size: 25,
                                ),
                                SizeBoxV(Responsive.width * 2),
                                CommonTextWidget(
                                  color: isDarkModeOn
                                      ? AppConstants.white
                                      : AppConstants.black,
                                  text: context
                                      .read<Foodsearchprovider>()
                                      .resentSearch[index],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizeBoxH(Responsive.height * 2),
                    CommonTextWidget(
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      text: "Recent Search",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    SizeBoxH(Responsive.height * 2),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: 4,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: isDarkModeOn
                                ? AppConstants.black
                                : AppConstants.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(
                                    0x26000000), // Equivalent to #00000026
                                offset: Offset(0, 0),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                // width: Responsive.width * 30,
                                // height: Responsive.height * 15,
                                decoration: BoxDecoration(
                                  color: isDarkModeOn
                                      ? AppConstants.darkGrey
                                      : AppConstants.lightGrey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(14),
                                child: CachedImageWidget(
                                  imageUrl:
                                      'https://t4.ftcdn.net/jpg/04/95/28/65/240_F_495286577_rpsT2Shmr6g81hOhGXALhxWOfx1vOQBa.jpg',
                                  height: Responsive.height * 8,
                                  width: Responsive.width * 18,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                ),
                              ),
                              SizeBoxV(Responsive.width * 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CommonTextWidget(
                                      color: isDarkModeOn
                                          ? AppConstants.white
                                          : AppConstants.black,
                                      text:
                                          'Special salad fruitdssssssssssssssssssssssssssss',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      overFlow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    SizeBoxH(Responsive.width * 1),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Color(0xffFFD600),
                                        ),
                                        CommonTextWidget(
                                          color: isDarkModeOn
                                              ? AppConstants.white
                                              : AppConstants.black,
                                          text: '4.2',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        CommonTextWidget(
                                          color: isDarkModeOn
                                              ? AppConstants.white
                                              : AppConstants.black,
                                          text: '(100+)',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        )
                                      ],
                                    ),
                                    SizeBoxH(Responsive.height * 1),
                                    Row(
                                      children: [
                                        CommonTextWidget(
                                          color: isDarkModeOn
                                              ? AppConstants.darkPrimaryColor
                                              : AppConstants.darkBlue,
                                          text: 'AED 57.75',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizeBoxH(Responsive.height * 2),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

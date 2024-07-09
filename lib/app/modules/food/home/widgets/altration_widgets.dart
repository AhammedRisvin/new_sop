import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/extentions.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../widgets/common_widgets.dart';
import '../view_model/food_home.dart';

class AltrationWidgets extends StatelessWidget {
  const AltrationWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
        selector: (_, value) => value.isDarkModeOn,
        builder: (context, isDarkModeOn, _) {
          return Consumer<FoodHomeProvider>(builder: (context, obj, _) {
            return SizedBox(
              height: Responsive.height * 5,
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return
                        // index == 1
                        //     ? Consumer<FoodHomeProvider>(
                        //         builder: (context, obj, _) {
                        //         return DropdownButtonHideUnderline(
                        //           child: DropdownButton2<String>(
                        //             isExpanded: true,
                        //             hint: const Row(
                        //               children: [
                        //                 CommonTextWidget(
                        //                   text: 'Sort',
                        //                   color: AppConstants.white,
                        //                   fontSize: 12,
                        //                   fontWeight: FontWeight.w500,
                        //                 )
                        //               ],
                        //             ),
                        //             items: obj.sortItems
                        //                 .map((String item) =>
                        //                     DropdownMenuItem<String>(
                        //                       value: item,
                        //                       child: Row(
                        //                         mainAxisAlignment:
                        //                             MainAxisAlignment.spaceBetween,
                        //                         children: [
                        //                           Text(
                        //                             item,
                        //                             style: const TextStyle(
                        //                               fontSize: 14,
                        //                               fontWeight: FontWeight.bold,
                        //                               color: Colors.white,
                        //                             ),
                        //                             overflow: TextOverflow.ellipsis,
                        //                           ),
                        //                           Icon(
                        //                             Icons.radio_button_on,
                        //                             color: isDarkModeOn
                        //                                 ? AppConstants
                        //                                     .darkPrimaryColor
                        //                                 : AppConstants.darkBlue,
                        //                           )
                        //                         ],
                        //                       ),
                        //                     ))
                        //                 .toList(),
                        //             value: obj.sortSelectedValue,
                        //             onChanged: (value) {
                        //               obj.sortSelectedValueFnc(value: value);
                        //             },
                        //             buttonStyleData: ButtonStyleData(
                        //               height: 50,
                        //               width: Responsive.width * 30,
                        //               padding: const EdgeInsets.only(
                        //                   left: 14, right: 14),
                        //               decoration: BoxDecoration(
                        //                 borderRadius: const BorderRadius.all(
                        //                     Radius.circular(20)),
                        //                 color: isDarkModeOn
                        //                     ? const Color(0xff333333)
                        //                     : AppConstants.white,
                        //                 boxShadow: const [
                        //                   BoxShadow(
                        //                     color: Color(
                        //                         0x24000000), // Equivalent to #00000024
                        //                     offset: Offset(0, 0),
                        //                     blurRadius: 4,
                        //                   ),
                        //                 ],
                        //               ),
                        //               elevation: 2,
                        //             ),
                        //             style: TextStyle(
                        //               color: isDarkModeOn
                        //                   ? AppConstants.white
                        //                   : AppConstants.darkBlue,
                        //               fontFamily: GoogleFonts.inter().fontFamily,
                        //               fontSize: 12,
                        //               fontWeight: FontWeight.w400,
                        //             ),
                        //             iconStyleData: IconStyleData(
                        //               icon: const Icon(
                        //                 Icons.keyboard_arrow_down,
                        //               ),
                        //               iconSize: 20,
                        //               iconEnabledColor: isDarkModeOn
                        //                   ? AppConstants.darkPrimaryColor
                        //                   : AppConstants.darkBlue,
                        //               iconDisabledColor: isDarkModeOn
                        //                   ? AppConstants.darkPrimaryColor
                        //                   : AppConstants.darkBlue,
                        //             ),
                        //             dropdownStyleData: DropdownStyleData(
                        //               maxHeight: 200,
                        //               width: 200,
                        //               decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(14),
                        //                 color: const Color(0xff333333),
                        //               ),
                        //               offset: const Offset(-20, 0),
                        //               scrollbarTheme: ScrollbarThemeData(
                        //                 radius: const Radius.circular(40),
                        //                 thickness: WidgetStateProperty.all(6),
                        //                 thumbVisibility:
                        //                     WidgetStateProperty.all(true),
                        //               ),
                        //             ),
                        //             menuItemStyleData: const MenuItemStyleData(
                        //               height: 40,
                        //               padding: EdgeInsets.only(left: 14, right: 14),
                        //             ),
                        //           ),
                        //         );
                        //       })
                        //     :
                        CommonInkwell(
                      onTap: () {
                        index == 0 ? _showModalBottomSheet(context) : null;
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 6),
                        decoration: BoxDecoration(
                          color: isDarkModeOn
                              ? const Color(0xff333333)
                              : AppConstants.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color:
                                  Color(0x24000000), // Equivalent to #00000024
                              offset: Offset(0, 0),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            index == 1
                                ? Image.asset(
                                    AppImages.deliveryIcon,
                                    width: 30,
                                    height: 40,
                                  )
                                : index == 3
                                    ? const Icon(
                                        Icons.star,
                                        color: AppConstants.darkYellow,
                                      )
                                    : const SizedBox.shrink(),
                            CommonTextWidget(
                              color: isDarkModeOn
                                  ? AppConstants.white
                                  : AppConstants.darkBlue,
                              text: obj.filterList[index],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            SizeBoxV(Responsive.width * 1),
                            index == 0
                                ? Icon(
                                    Icons.tune,
                                    color: isDarkModeOn
                                        ? AppConstants.darkPrimaryColor
                                        : AppConstants.darkBlue,
                                  )
                                : const SizedBox.shrink()
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      SizeBoxV(Responsive.width * 5),
                  itemCount: 3),
            );
          });
        });
  }
}

void _showModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Selector<ThemeProvider, bool>(
        selector: (_, value) => value.isDarkModeOn,
        builder: (context, isDarkModeOn, _) {
          return Container(
            height: Responsive.height * 48,
            decoration: BoxDecoration(
              color: isDarkModeOn ? AppConstants.black : AppConstants.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Consumer<FoodHomeProvider>(
              builder: (context, obj, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizeBoxH(Responsive.height * 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonTextWidget(
                            color: isDarkModeOn
                                ? AppConstants.white
                                : AppConstants.black,
                            text: 'Filter',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          Icon(
                            Icons.close,
                            color: isDarkModeOn
                                ? AppConstants.white
                                : AppConstants.black,
                          )
                        ],
                      ),
                    ),
                    SizeBoxH(Responsive.height * 2),
                    SizedBox(
                      height: Responsive.height * 5,
                      child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemBuilder: (context, index) {
                            return CommonInkwell(
                              onTap: () {
                                print('my index $index');
                                obj.filterCurrentIndexFnc(index: index);
                              },
                              child: Container(
                                  width: Responsive.width * 30,
                                  height: Responsive.height * 5,
                                  decoration: BoxDecoration(
                                    color: isDarkModeOn
                                        ? obj.filterCurrentIndex == index
                                            ? AppConstants.darkPrimaryColor
                                            : AppConstants.darkGrey
                                        : obj.filterCurrentIndex == index
                                            ? AppConstants.lightPrimaryColor
                                            : AppConstants.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(
                                            0x1F000000), // Equivalent to #0000001F
                                        offset: Offset(0, 0),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: CommonTextWidget(
                                      color: isDarkModeOn
                                          ? obj.filterCurrentIndex == index
                                              ? AppConstants.white
                                              : AppConstants.white
                                          : obj.filterCurrentIndex == index
                                              ? AppConstants.white
                                              : AppConstants.black,
                                      text: obj.filterListBottomSheet[index],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizeBoxV(Responsive.width * 5),
                          itemCount: 4),
                    ),
                    SizeBoxH(Responsive.height * 2),
                    obj.filterCurrentIndex == 0
                        ? SortWidgets(isDarkModeOn: isDarkModeOn)
                        : obj.filterCurrentIndex == 1
                            ? RatingWidgets(isDarkModeOn: isDarkModeOn)
                            : obj.filterCurrentIndex == 2
                                ? VegOrNonVegWidgets(
                                    isDarkModeOn: isDarkModeOn,
                                  )
                                : DeliveryTimeWidgets(
                                    isDarkModeOn: isDarkModeOn,
                                  )
                  ],
                );
              },
            ),
          );
        },
      );
    },
  );
}

class SortWidgets extends StatelessWidget {
  final bool isDarkModeOn;
  const SortWidgets({required this.isDarkModeOn, super.key});

  get radio_button_on => null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Consumer<FoodHomeProvider>(builder: (context, obj, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextWidget(
              color: isDarkModeOn ? AppConstants.white : AppConstants.black,
              text: 'Sort By',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            SizeBoxH(Responsive.height * 1.5),
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      CommonInkwell(
                        onTap: () => obj.sortCurrentIndexFnc(index: index),
                        child: Icon(
                            obj.sortCurrentIndex == index
                                ? Icons.radio_button_on
                                : Icons.radio_button_off,
                            color: isDarkModeOn
                                ? AppConstants.darkPrimaryColor
                                : AppConstants.lightPrimaryColor),
                      ),
                      SizeBoxV(Responsive.width * 2),
                      CommonTextWidget(
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black,
                        text: obj.sortList[index],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) =>
                    SizeBoxH(Responsive.height * 3),
                itemCount: 4),
            SizeBoxH(Responsive.height * 3),
            FiltterButton(
              isDarkModeOn: isDarkModeOn,
            )
          ],
        );
      }),
    );
  }
}

class VegOrNonVegWidgets extends StatelessWidget {
  final bool isDarkModeOn;
  const VegOrNonVegWidgets({super.key, required this.isDarkModeOn});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Consumer<FoodHomeProvider>(builder: (context, obj, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextWidget(
              color: isDarkModeOn ? AppConstants.white : AppConstants.black,
              text: 'Sort By',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            SizeBoxH(Responsive.height * 1.5),
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      CommonInkwell(
                        onTap: () => obj.sortCurrentIndexFnc(index: index),
                        child: Icon(
                            obj.sortCurrentIndex == index
                                ? Icons.radio_button_on
                                : Icons.radio_button_off,
                            color: isDarkModeOn
                                ? AppConstants.darkPrimaryColor
                                : AppConstants.lightPrimaryColor),
                      ),
                      SizeBoxV(Responsive.width * 2),
                      CommonTextWidget(
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black,
                        text: obj.vegNonList[index],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) =>
                    SizeBoxH(Responsive.height * 3),
                itemCount: 2),
            SizeBoxH(Responsive.height * 3),
            FiltterButton(
              isDarkModeOn: isDarkModeOn,
            )
          ],
        );
      }),
    );
  }
}

class DeliveryTimeWidgets extends StatelessWidget {
  final bool isDarkModeOn;
  const DeliveryTimeWidgets({super.key, required this.isDarkModeOn});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Consumer<FoodHomeProvider>(builder: (context, obj, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextWidget(
              color: isDarkModeOn ? AppConstants.white : AppConstants.black,
              text: 'Sort By',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            SizeBoxH(Responsive.height * 1.5),
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      CommonInkwell(
                        onTap: () => obj.sortCurrentIndexFnc(index: index),
                        child: Icon(
                            obj.sortCurrentIndex == index
                                ? Icons.radio_button_on
                                : Icons.radio_button_off,
                            color: isDarkModeOn
                                ? AppConstants.darkPrimaryColor
                                : AppConstants.lightPrimaryColor),
                      ),
                      SizeBoxV(Responsive.width * 2),
                      CommonTextWidget(
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black,
                        text: obj.vegNonList[index],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) =>
                    SizeBoxH(Responsive.height * 3),
                itemCount: 2),
            SizeBoxH(Responsive.height * 3),
            FiltterButton(
              isDarkModeOn: isDarkModeOn,
            )
          ],
        );
      }),
    );
  }
}

class FiltterButton extends StatelessWidget {
  final bool isDarkModeOn;
  const FiltterButton({super.key, required this.isDarkModeOn});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonButton(
          ontap: () {},
          height: Responsive.height * 5.5,
          text: 'Clear Filters',
          isDarkMode: isDarkModeOn,
          width: Responsive.width * 42,
          bgColor: isDarkModeOn ? AppConstants.darkGrey : AppConstants.white,
          textColor: isDarkModeOn
              ? AppConstants.darkPrimaryColor
              : AppConstants.lightPrimaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          borderColor: isDarkModeOn
              ? AppConstants.darkPrimaryColor
              : AppConstants.lightPrimaryColor,
          isFromRedButton: true,
        ),
        CommonButton(
          ontap: () {},
          height: Responsive.height * 5.5,
          text: 'Apply',
          isDarkMode: isDarkModeOn,
          width: Responsive.width * 42,
          textColor: isDarkModeOn ? AppConstants.white : AppConstants.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        )
      ],
    );
  }
}

class RatingWidgets extends StatelessWidget {
  final bool isDarkModeOn;
  const RatingWidgets({super.key, required this.isDarkModeOn});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Consumer<FoodHomeProvider>(builder: (context, obj, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextWidget(
              color: isDarkModeOn ? AppConstants.white : AppConstants.black,
              text: 'Filter By',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            SizeBoxH(Responsive.height * 1.5),
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.values[1],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        checkColor: AppConstants.white,
                        activeColor: isDarkModeOn
                            ? AppConstants.darkPrimaryColor
                            : AppConstants.lightPrimaryColor,
                        value:
                            obj.ratingIndex == index ? obj.ratingValue : false,
                        onChanged: (value) {
                          obj.ratingValueFnc(index: index);
                        },
                      ),
                      Row(
                        children: [
                          Icon(Icons.star,
                              color: isDarkModeOn
                                  ? AppConstants.darkYellow
                                  : AppConstants.darkYellow),
                          CommonTextWidget(
                            color: isDarkModeOn
                                ? AppConstants.white
                                : AppConstants.black,
                            text: 'Rating 4.0',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      )
                    ],
                  );
                },
                separatorBuilder: (context, index) =>
                    SizeBoxH(Responsive.height * 2),
                itemCount: 3),
            SizeBoxH(Responsive.height * 3),
            FiltterButton(
              isDarkModeOn: isDarkModeOn,
            )
          ],
        );
      }),
    );
  }
}

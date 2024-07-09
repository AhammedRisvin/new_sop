import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/extentions.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../pharma/home/home screen/view model/theme_provider.dart';
import '../../widgets/common_widgets.dart';
import '../restaurants/widgets/product_image_widgets.dart';

class ToppicscardWdgets extends StatelessWidget {
  final bool? reviewRight;
  const ToppicscardWdgets({super.key, this.reviewRight});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
        selector: (_, value) => value.isDarkModeOn,
        builder: (context, isDarkModeOn, _) {
          return CommonInkwell(
            onTap: () {},
            child: Column(
              children: [
                ProductImageContainer(
                  reviewRight: reviewRight ?? false,
                ),
                Container(
                  width: Responsive.width * 45,
                  decoration: BoxDecoration(
                    color: isDarkModeOn
                        ? const Color(0xff141313)
                        : AppConstants.white,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x21000000),
                        offset: Offset(0, 0),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextWidget(
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black,
                        text:
                            'Chicken curry & riceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        overFlow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizeBoxH(Responsive.height * 1),
                      CommonTextWidget(
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black,
                        text:
                            'Spicy ghee rice and chicken curry dddddddddddddddddddddddddddddddddd',
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        overFlow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizeBoxH(Responsive.height * 1.5),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: isDarkModeOn
                                    ? const Color(0xff272626)
                                    : AppConstants.darkBlue,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 5, left: 6, right: 9),
                            child: CommonTextWidget(
                              color: isDarkModeOn
                                  ? AppConstants.darkPrimaryColor
                                  : AppConstants.white,
                              text: 'AED 57.75',
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizeBoxV(Responsive.width * 2),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: AppConstants.darkPrimaryColor,
                                size: 16,
                              ),
                              CommonTextWidget(
                                color: isDarkModeOn
                                    ? AppConstants.white
                                    : AppConstants.black,
                                text: '4.2 (100)+',
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

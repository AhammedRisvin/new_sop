import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/modules/food/cart/view_model/cart_provider.dart';

import '../../../helpers/extentions.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../pharma/home/home screen/view model/theme_provider.dart';
import '../../widgets/common_widgets.dart';
import '../cart/model/cart_model.dart';

class AddOnWdgets extends StatelessWidget {
  final bool isCart;
  final AddOn? addOn;
  final int? index;

  const AddOnWdgets({this.isCart = false, super.key, this.addOn, this.index});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  clipBehavior: Clip.hardEdge,
                  child: CachedImageWidget(
                      imageUrl: addOn?.addOnImage ?? "",
                      height: isCart
                          ? Responsive.height * 5
                          : Responsive.height * 7.5,
                      width: isCart
                          ? Responsive.width * 10
                          : Responsive.width * 15),
                ),
                SizeBoxV(Responsive.width * 4),
                CommonTextWidget(
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                  text: addOn?.addOnName ?? '',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            Row(
              children: [
                CommonTextWidget(
                  color: isDarkModeOn
                      ? AppConstants.darkPrimaryColor
                      : AppConstants.darkBlue,
                  text: '${addOn?.addOnPrice ?? ''}',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
                SizeBoxV(Responsive.width * 4),
                Consumer<FoodCartProvider>(builder: (context, obj, _) {
                  return Checkbox(
                    fillColor: const WidgetStatePropertyAll(Color(0xff272626)),
                    checkColor: AppConstants.white,
                    splashRadius: 5,
                    value: index == obj.addOnCurrentIndex ? obj.istrue : false,
                    onChanged: (value) {
                      obj.addOnTrueOrFalse(index: index, value: value);
                    },
                  );
                })
              ],
            )
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/app_router.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/modules/home/home/model/get_home_data_model.dart';
import 'package:sophwe_newmodule/app/utils/prefferences.dart';

import '../../../../../helpers/extentions.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../widgets/common_widgets.dart';
import '../view model/home_provider.dart';

class CommonProductListingWidget extends StatelessWidget {
  final bool isDarkModeOn;
  final Function() onTap;
  final bool isFromListView;
  final double width;
  final LatestProduct? data;
  const CommonProductListingWidget({
    super.key,
    required this.isDarkModeOn,
    required this.onTap,
    this.isFromListView = false,
    this.width = 100,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: isFromListView ? width : null,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isDarkModeOn
                  ? AppConstants.bgDarkContainer
                  : AppConstants.white,
              boxShadow: [
                BoxShadow(
                  color: isDarkModeOn
                      ? AppConstants.black.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizeBoxH(5),
                CachedImageWidget(
                  imageUrl: data?.images?.first ??
                      "https://t4.ftcdn.net/jpg/04/95/28/65/240_F_495286577_rpsT2Shmr6g81hOhGXALhxWOfx1vOQBa.jpg",
                  height: isFromListView
                      ? Responsive.height * 14
                      : Responsive.height * 16,
                  width: Responsive.width * 100,
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizeBoxH(10),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextWidget(
                        align: TextAlign.start,
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black,
                        text: data?.productName ?? "",
                        fontSize: 16,
                        maxLines: 1,
                        overFlow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizeBoxH(5),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextWidget(
                        align: TextAlign.start,
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black,
                        text: data?.description ?? "",
                        fontSize: 11,
                        maxLines: 1,
                        overFlow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizeBoxH(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CommonTextWidget(
                        align: TextAlign.start,
                        color: isDarkModeOn
                            ? AppConstants.commonGold
                            : AppConstants.darkBlue,
                        text: "${data?.price} ${data?.currency}",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppConstants.yellow,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        CommonTextWidget(
                          color: isDarkModeOn
                              ? AppConstants.white
                              : AppConstants.black,
                          text: data?.ratings?.average?.toStringAsFixed(1) ??
                              "0.0",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: Responsive.width * 4,
            top: Responsive.height * 2.2,
            child: Consumer<PharmaHomeProvider>(
              builder: (context, value, child) {
                final isSignedIn = AppPref.isSignedIn;
                return CommonInkwell(
                  onTap: () {
                    if (isSignedIn) {
                      value.addToWishListFn(data?.id ?? "", context);
                    } else {
                      context.pushReplacementNamed(AppRouter.login);
                    }
                  },
                  child: data?.wishlist == true
                      ? Icon(
                          Icons.favorite_outlined,
                          size: 22,
                          color: isDarkModeOn
                              ? AppConstants.commonGold
                              : AppConstants.darkBlue,
                        )
                      : Icon(
                          Icons.favorite_border,
                          size: 22,
                          color: isDarkModeOn
                              ? AppConstants.commonGold
                              : AppConstants.darkBlue,
                        ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

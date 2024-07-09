import 'package:flutter/material.dart';
import 'package:sophwe_newmodule/app/modules/home/home/model/get_home_data_model.dart';

import '../../../../helpers/extentions.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../widgets/common_widgets.dart';

class RestaurantToExploreProductWidget extends StatelessWidget {
  const RestaurantToExploreProductWidget({
    super.key,
    required this.isDarkModeOn,
    this.data,
  });

  final bool isDarkModeOn;
  final RestaurentDatum? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 10,
      ),
      width: Responsive.width * 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppConstants.black10,
        ),
      ),
      child: Column(
        children: [
          CachedImageWidget(
            imageUrl: data?.image ??
                "https://t4.ftcdn.net/jpg/04/95/28/65/240_F_495286577_rpsT2Shmr6g81hOhGXALhxWOfx1vOQBa.jpg",
            height: Responsive.height * 12,
            width: Responsive.width * 100,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CommonTextWidget(
                        align: TextAlign.start,
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black,
                        text: data?.name ?? "",
                        fontSize: 12,
                        maxLines: 2,
                        overFlow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppConstants.darkYellow,
                          size: 12,
                        ),
                        const SizeBoxV(3),
                        CommonTextWidget(
                          color: isDarkModeOn
                              ? AppConstants.white
                              : AppConstants.black,
                          text: data?.ratings?.toStringAsFixed(2) ?? '0.00',
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_outlined,
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      size: 12,
                    ),
                    const SizeBoxV(5),
                    CommonTextWidget(
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      text: '15 to 30 mins',
                      fontSize: 10,
                      letterSpacing: -0.2,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
                SizeBoxH(Responsive.width * 1.0),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextWidget(
                        align: TextAlign.start,
                        color: isDarkModeOn
                            ? AppConstants.commonGold
                            : AppConstants.darkBlue,
                        text: 'Beverages, Shakes ,Arabian, Burgers',
                        fontSize: 10,
                        maxLines: 2,
                        overFlow: TextOverflow.ellipsis,
                        letterSpacing: -0.3,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                SizeBoxH(Responsive.width * 1.0),
                Row(
                  children: [
                    Icon(
                      Icons.add_location_outlined,
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      size: 15,
                    ),
                    const SizeBoxV(5),
                    CommonTextWidget(
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      text: 'Areekod Locality 1.4 Km',
                      fontSize: 10,
                      letterSpacing: -0.2,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                const Spacer(),
                CommonButton(
                  ontap: () {},
                  height: Responsive.height * 3.2,
                  text: "Order now",
                  fontSize: 10,
                  borderRadius: BorderRadius.circular(5),
                  isDarkMode: isDarkModeOn,
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}

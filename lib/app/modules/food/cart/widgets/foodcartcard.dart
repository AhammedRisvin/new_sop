import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/modules/food/cart/view_model/cart_provider.dart';

import '../../../../helpers/extentions.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../widgets/common_widgets.dart';
import '../model/cart_model.dart';
import 'food_remove_show_dialog.dart';

class FoodCartAndFavouriteListingWidget extends StatelessWidget {
  final bool isDarkModeOn;
  final bool isFromCart;
  final Function()? onTap;
  final Cart? cart;
  final String? currency;
  const FoodCartAndFavouriteListingWidget({
    super.key,
    required this.isDarkModeOn,
    this.isFromCart = false,
    required this.onTap,
    this.cart,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppConstants.black10,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CachedImageWidget(
            imageUrl: cart?.images ?? "",
            height: Responsive.height * 12,
            width: Responsive.height * 12,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizeBoxV(10),
          Expanded(
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
                      text: cart?.productName ?? '',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return FoodConfirmationWidget(
                              title: "Remove Item?",
                              message:
                                  "Are you sure yow want to remove this item?",
                              onTap: () {
                                Provider.of<FoodCartProvider>(context,
                                        listen: false)
                                    .getCartRemove(
                                  productId: cart?.productId ?? '',
                                  context: context,
                                  cartfn: onTap ?? () {},
                                );
                              },
                              isDarkModeOn: isDarkModeOn,
                            );
                          },
                        );
                      },
                      icon: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 12,
                        child: Icon(
                          Icons.delete,
                          color: isDarkModeOn
                              ? AppConstants.white
                              : AppConstants.white,
                          size: 12,
                        ),
                      ),
                    )
                  ],
                ),
                CommonTextWidget(
                  align: TextAlign.start,
                  color: isDarkModeOn
                      ? AppConstants.tInactive
                      : AppConstants.tInactive,
                  text: '${cart?.pricePerItem ?? ''}',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  maxLines: 4,
                  overFlow: TextOverflow.ellipsis,
                ),
                const SizeBoxH(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextWidget(
                      color: isDarkModeOn
                          ? AppConstants.commonGold
                          : AppConstants.darkBlue.withOpacity(0.3),
                      text:
                          "${cart?.quantity ?? ''}X${cart?.pricePerItem ?? ''}==${cart?.totalPrice ?? ''} ${currency ?? ''}",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    Consumer<FoodCartProvider>(builder: (context, obj, _) {
                      return Row(
                        children: [
                          CommonInkwell(
                            onTap: () {
                              obj.getCartDecrement(
                                  productId: cart?.productId ?? '',
                                  context: context,
                                  cartfn: onTap ?? () {});
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: AppConstants.transparent,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: AppConstants.darkBlue,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.remove,
                                  color: isDarkModeOn
                                      ? AppConstants.commonGold
                                      : AppConstants.darkBlue,
                                ),
                              ),
                            ),
                          ),
                          const SizeBoxV(10),
                          CommonTextWidget(
                            color: isDarkModeOn
                                ? AppConstants.commonGold
                                : AppConstants.darkBlue,
                            text: '${cart?.quantity ?? ''}',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizeBoxV(10),
                          CommonInkwell(
                            onTap: () {
                              obj.getCartIncrement(
                                  productId: cart?.productId ?? '',
                                  context: context,
                                  cartfn: onTap ?? () {});
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: AppConstants.darkBlue,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: AppConstants.darkBlue,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: isDarkModeOn
                                      ? AppConstants.commonGold
                                      : AppConstants.white,
                                ),
                              ),
                            ),
                          ),
                          const SizeBoxV(10),
                        ],
                      );
                    }),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

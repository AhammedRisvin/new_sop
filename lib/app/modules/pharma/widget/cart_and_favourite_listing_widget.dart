import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/modules/home/home/model/get_home_data_model.dart';
import 'package:sophwe_newmodule/app/modules/pharma/product/cart/view_model/pharma_cart_provider.dart';

import '../../../helpers/extentions.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/confimration_widget.dart';
import '../product/favourites/view_model/favourites_provider.dart';

class CartAndFavouriteListingWidget extends StatelessWidget {
  final bool isDarkModeOn;
  final bool isFromCart;
  final Function()? onTap;
  final LatestProduct? productData;
  final Function() successCallback;
  const CartAndFavouriteListingWidget({
    super.key,
    required this.isDarkModeOn,
    this.isFromCart = false,
    required this.onTap,
    this.productData,
    required this.successCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PharmaCartProvider>(
      builder: (context, provider, child) => CommonInkwell(
        onTap: onTap,
        child: Container(
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
                imageUrl: productData?.images?.first ?? "",
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
                        Expanded(
                          child: CommonTextWidget(
                            align: TextAlign.start,
                            color: isDarkModeOn
                                ? AppConstants.white
                                : AppConstants.black,
                            text: productData?.productName ?? "",
                            maxLines: 2,
                            overFlow: TextOverflow.ellipsis,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        isFromCart
                            ? IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ConfirmationWidget(
                                        title: "Remove Item?",
                                        message:
                                            "Are you sure yow want to remove this item?",
                                        onTap: () {
                                          provider.removeFromCartFn(
                                            ctx: context,
                                            productId:
                                                productData?.productId ?? "",
                                            sizeId: productData?.sizeId ?? "",
                                            successCallback: successCallback,
                                          );
                                        },
                                        onCancel: () {
                                          context.pop();
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
                            : IconButton(
                                onPressed: () {
                                  Provider.of<PharmaFavouritesProvider>(context,
                                          listen: false)
                                      .removeFromFavouritesFn(
                                    productId: productData?.id ?? "",
                                    ctx: context,
                                  );
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color: isDarkModeOn
                                      ? AppConstants.commonGold
                                      : AppConstants.darkBlue,
                                ),
                              ),
                      ],
                    ),
                    CommonTextWidget(
                      align: TextAlign.start,
                      color: isDarkModeOn
                          ? isFromCart
                              ? AppConstants.white
                              : AppConstants.tInactive
                          : isFromCart
                              ? AppConstants.black
                              : AppConstants.tInactive,
                      text: isFromCart
                          ? "Size : ${productData?.size?.capitalizeFirstLetter()}"
                          : productData?.description ?? "",
                      fontSize: isFromCart ? 14 : 12,
                      fontWeight:
                          isFromCart ? FontWeight.w600 : FontWeight.w500,
                      maxLines: 4,
                      overFlow: TextOverflow.ellipsis,
                    ),
                    const SizeBoxH(10),
                    isFromCart
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CommonTextWidget(
                                  align: TextAlign.start,
                                  color: isDarkModeOn
                                      ? AppConstants.commonGold
                                      : AppConstants.darkBlue,
                                  maxLines: 2,
                                  text: (productData?.quantity ?? 0) > 1
                                      ? "${productData?.pricePerItem?.toStringAsFixed(2)}x${productData?.quantity.toString()} = ${productData?.price?.toStringAsFixed(2)} ${productData?.currency}"
                                      : "${productData?.pricePerItem?.toStringAsFixed(2)} ${productData?.currency}",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                children: [
                                  CommonInkwell(
                                    onTap: () {
                                      if (productData?.quantity != 1) {
                                        provider.quantityDecrementFn(
                                          productId:
                                              productData?.productId ?? "",
                                          selectedSizeId:
                                              productData?.sizeId ?? "",
                                          successCallback: successCallback,
                                        );
                                      }
                                    },
                                    child: Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        color: AppConstants.transparent,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: isDarkModeOn
                                              ? AppConstants.commonGold
                                              : AppConstants.darkBlue,
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: CommonTextWidget(
                                      color: isDarkModeOn
                                          ? AppConstants.commonGold
                                          : AppConstants.darkBlue,
                                      text: productData?.quantity.toString() ??
                                          '',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  CommonInkwell(
                                    onTap: () {
                                      provider.quantityIncrementFn(
                                        productId: productData?.productId ?? "",
                                        selectedSizeId:
                                            productData?.sizeId ?? "",
                                        quantity:
                                            productData?.quantity?.toInt() ?? 0,
                                        totalQuantity: productData
                                                ?.availableQuantity
                                                ?.toInt() ??
                                            0,
                                        context: context,
                                        successCallback: successCallback,
                                      );
                                    },
                                    child: Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        color: AppConstants.transparent,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: isDarkModeOn
                                              ? AppConstants.commonGold
                                              : AppConstants.darkBlue,
                                        ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          color: isDarkModeOn
                                              ? AppConstants.commonGold
                                              : AppConstants.darkBlue,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizeBoxV(10),
                                ],
                              ),
                            ],
                          )
                        : CommonTextWidget(
                            color: isDarkModeOn
                                ? AppConstants.commonGold
                                : AppConstants.darkBlue,
                            text:
                                "${productData?.price?.toStringAsFixed(2)} ${productData?.currency}",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
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

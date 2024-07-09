import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/app_router.dart';
import 'package:sophwe_newmodule/app/helpers/extentions.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/modules/pharma/product/cart/view_model/pharma_cart_provider.dart';
import 'package:sophwe_newmodule/app/modules/widgets/empty_screen.dart';
import 'package:sophwe_newmodule/app/utils/app_images.dart';

import '../../../../../backend/pharmacy/urls.dart';
import '../../../../../backend/server_client_services.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/enums.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../address/view_model/address_provider.dart';
import '../../../home/home screen/view model/theme_provider.dart';
import '../../../widget/add_coupon_widget.dart';
import '../../../widget/address_widget.dart';
import '../../../widget/cart_and_favourite_listing_widget.dart';
import '../../../widget/cart_price_listing_widget.dart';
import '../../../widget/payment_method_choosing_widget.dart';
import '../model/get_cart_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

PharmaCartProvider? provider;
PharmaAddressProvider? addressProvider;

class _CartScreenState extends State<CartScreen> {
  StreamController<GetCartModel> cartStreamController =
      StreamController<GetCartModel>();
  @override
  void initState() {
    super.initState();
    addressProvider = context.read<PharmaAddressProvider>();
    addressProvider?.getPharmaAddressFn();
    getPharmaCartFn();
    provider = context.read<PharmaCartProvider>();
  }

  Future<void> getPharmaCartFn() async {
    try {
      List response = await ServerClient.get(
        Urls.getPharmaCartUrl,
      );
      if (response.first >= 200 && response.first < 300) {
        final getCartModel = GetCartModel.fromJson(response.last);
        cartStreamController.add(getCartModel);
        provider?.getCouponsFn(cartId: getCartModel.cartData!.id ?? "");
      } else {
        cartStreamController.add(GetCartModel());
      }
    } catch (e) {
      cartStreamController.add(GetCartModel());
      debugPrint("Error in getPharmaCartFn: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, _) => Selector<PharmaCartProvider, bool>(
          selector: (p0, p1) => p1.isLoading,
          builder: (context, value, child) {
            return Stack(
              children: [
                Scaffold(
                  backgroundColor:
                      isDarkModeOn ? AppConstants.black : AppConstants.white,
                  appBar: AppBar(
                    surfaceTintColor:
                        isDarkModeOn ? AppConstants.black : AppConstants.white,
                    title: CommonTextWidget(
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      text: "Cart",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    backgroundColor:
                        isDarkModeOn ? AppConstants.black : AppConstants.white,
                    leading: IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black,
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: StreamBuilder<GetCartModel>(
                      stream: cartStreamController.stream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                            height: Responsive.height * 80,
                            width: Responsive.width * 100,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: AppConstants.darkBlue,
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return EmptyScreenWidget(
                            text: "Server is Busy, Try again later",
                            image: AppImages.serverMaintenanceImage,
                            height: Responsive.height * 80,
                            isFromServerError: true,
                            ontap: () {
                              getPharmaCartFn();
                            },
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data?.cartData?.cart?.isEmpty == true) {
                          return EmptyScreenWidget(
                            text: "Cart is empty ",
                            image: AppImages.emptyCartImage,
                            height: Responsive.height * 80,
                          );
                        } else {
                          return Consumer<PharmaAddressProvider>(
                            builder: (context, value, child) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      snapshot.data?.cartData?.cart?.length ??
                                          0,
                                  itemBuilder: (context, index) {
                                    final productData =
                                        snapshot.data?.cartData?.cart?[index];
                                    return CartAndFavouriteListingWidget(
                                      isDarkModeOn: isDarkModeOn,
                                      isFromCart: true,
                                      onTap: () {},
                                      productData: productData,
                                      successCallback: () {
                                        getPharmaCartFn();
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizeBoxH(10);
                                  },
                                ),
                                const SizeBoxH(20),
                                value.getAddressModel.shippingAddress
                                            ?.isEmpty ==
                                        true
                                    ? CommonInkwell(
                                        onTap: () {
                                          context.pushNamed(
                                              AppRouter.addAddressScreen,
                                              queryParameters: {
                                                "isEdit": "false",
                                                "addressId": "",
                                              });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                                color: AppConstants.black10),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add_location_alt_outlined,
                                                color: isDarkModeOn
                                                    ? AppConstants.commonGold
                                                    : AppConstants.darkBlue,
                                              ),
                                              const SizeBoxV(10),
                                              CommonTextWidget(
                                                color: isDarkModeOn
                                                    ? AppConstants.commonGold
                                                    : AppConstants.darkBlue,
                                                text: "Add Address",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : value.status ==
                                            PharmaAddressStatus.loading
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              color: isDarkModeOn
                                                  ? AppConstants.commonGold
                                                  : AppConstants.darkBlue,
                                            ),
                                          )
                                        : value.status ==
                                                PharmaAddressStatus.loaded
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CommonTextWidget(
                                                    color: isDarkModeOn
                                                        ? AppConstants.white
                                                        : AppConstants.black,
                                                    text: "Saved Address",
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  const SizeBoxH(10),
                                                  AddressWidget(
                                                    isDarkModeOn: isDarkModeOn,
                                                    addressData: value
                                                        .sortedAddresses?[0],
                                                    addressLength: value
                                                            .getAddressModel
                                                            .shippingAddress
                                                            ?.length ??
                                                        0,
                                                    isSelected: false,
                                                  ),
                                                ],
                                              )
                                            : const SizedBox.shrink(),
                                const SizeBoxH(20),
                                Consumer<PharmaCartProvider>(
                                  builder: (context, provider, child) =>
                                      Visibility(
                                    visible: provider.getCouponsModel.coupons
                                            ?.isNotEmpty ??
                                        false,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CommonTextWidget(
                                          color: isDarkModeOn
                                              ? AppConstants.white
                                              : AppConstants.black,
                                          text: "Save on your order",
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        const SizeBoxH(10),
                                        AddCouponWidget(
                                          isDarkModeOn: isDarkModeOn,
                                          couponsList:
                                              provider.getCouponsModel.coupons,
                                          cartProvider: provider,
                                          cartId:
                                              snapshot.data?.cartData?.id ?? "",
                                          successCallback:
                                              (GetCartModel getCartModel) {
                                            cartStreamController
                                                .add(getCartModel);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizeBoxH(20),
                                CommonTextWidget(
                                  color: isDarkModeOn
                                      ? AppConstants.white
                                      : AppConstants.black,
                                  text: "Payment summary",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                const SizeBoxH(20),
                                CartAmountListingWidget(
                                  isDarkModeOn: isDarkModeOn,
                                  amount:
                                      "${snapshot.data?.cartData?.totalDiscount?.toStringAsFixed(2)} ${snapshot.data?.currency}",
                                  title: "Discountable amount",
                                ),
                                const SizeBoxH(20),
                                CartAmountListingWidget(
                                  isDarkModeOn: isDarkModeOn,
                                  amount:
                                      "${snapshot.data?.cartData?.shippingCharge?.toStringAsFixed(2)} ${snapshot.data?.currency}",
                                  title: "Delivery charge",
                                ),
                                const SizeBoxH(20),
                                CartAmountListingWidget(
                                  isDarkModeOn: isDarkModeOn,
                                  amount:
                                      "${snapshot.data?.cartData?.totalPrice?.toStringAsFixed(2)} ${snapshot.data?.currency}",
                                  title:
                                      "Price (${snapshot.data?.cartData?.cart?.length ?? 0}Item)",
                                ),
                                const SizeBoxH(20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CommonTextWidget(
                                      color: isDarkModeOn
                                          ? AppConstants.commonGold
                                          : AppConstants.darkBlue,
                                      text: "Total amount",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    CommonTextWidget(
                                      color: isDarkModeOn
                                          ? AppConstants.commonGold
                                          : AppConstants.darkBlue,
                                      text:
                                          "${snapshot.data?.cartData?.totalSubTotal?.toStringAsFixed(2)} ${snapshot.data?.currency}",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                const SizeBoxH(20),
                                CommonTextWidget(
                                  align: TextAlign.start,
                                  color: AppConstants.commonGold,
                                  text:
                                      "You'll Earn ${snapshot.data?.cartData?.loyalityPoint?.toStringAsFixed(2)} Loyalty Points for this Order",
                                  fontSize: 16,
                                  maxLines: 2,
                                  overFlow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w600,
                                ),
                                const SizeBoxH(20),
                                CommonButton(
                                  ontap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return PaymentMethodChoosingWidget(
                                            isDarkModeOn: isDarkModeOn,
                                            walletAmount:
                                                snapshot.data?.walletAmount ??
                                                    0,
                                            totalPrice: snapshot.data?.cartData
                                                    ?.totalSubTotal ??
                                                0,
                                            provider: provider,
                                            cartId:
                                                snapshot.data?.cartData?.id ??
                                                    '',
                                            discountableAmount: snapshot.data
                                                    ?.cartData?.totalDiscount ??
                                                0,
                                          );
                                        });
                                  },
                                  height: Responsive.height * 6,
                                  text: "Checkout",
                                  isDarkMode: isDarkModeOn,
                                ),
                                const SizeBoxH(20)
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: value,
                  child: Container(
                    color: Colors.grey.withOpacity(0.3),
                    height: Responsive.height * 100,
                    width: Responsive.width * 100,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }

  @override
  void dispose() {
    cartStreamController.close();
    super.dispose();
  }
}

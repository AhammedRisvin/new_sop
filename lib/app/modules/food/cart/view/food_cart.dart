import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sophwe_newmodule/app/modules/food/address/view_model/address_provider.dart';

import '../../../../backend/food/food_server_client_services.dart';
import '../../../../backend/food/urls.dart';
import '../../../../helpers/extentions.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../widgets/common_widgets.dart';
import '../../address/widgets/food_address_widgets.dart';
import '../../widgets/add_on_widgets.dart';
import '../model/cart_model.dart';
import '../widgets/food_coupen_widgets.dart';
import '../widgets/food_payment_sheet.dart';
import '../widgets/foodcartcard.dart';

class FoodCartScreen extends StatefulWidget {
  const FoodCartScreen({super.key});

  @override
  State<FoodCartScreen> createState() => _FoodCartScreenState();
}

class _FoodCartScreenState extends State<FoodCartScreen> {
  StreamController<FoodCartModel> streamCartController = StreamController();
  Future getFoodCartFnc() async {
    try {
      final response = await FoodServerClient.get(FoodUrls.getFoodCarturl);

      if (response.first >= 200 && response.first < 300) {
        final foodCartModel = FoodCartModel.fromJson(response.last);

        streamCartController.add(foodCartModel);
      } else {
        streamCartController.add(FoodCartModel());
        // ignore: use_build_context_synchronously
        toast(context,
            title: response.last, backgroundColor: Colors.red, duration: 2);
      }
    } catch (e) {
      streamCartController.add(FoodCartModel());
      // ignore: use_build_context_synchronously
      toast(context,
          title: 'something have proplem',
          backgroundColor: Colors.red,
          duration: 2);
    }
  }

  @override
  void initState() {
    getFoodCartFnc();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    streamCartController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, _) => Scaffold(
        backgroundColor: isDarkModeOn ? AppConstants.black : AppConstants.white,
        appBar: AppBar(
          surfaceTintColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          title: CommonTextWidget(
            color: isDarkModeOn ? AppConstants.white : AppConstants.black,
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
              color: isDarkModeOn ? AppConstants.white : AppConstants.black,
            ),
          ),
          actions: [
            Switch(
              value: isDarkModeOn,
              onChanged: (value) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .updateTheme();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<FoodCartModel>(
                  stream: streamCartController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                          child: Text('Error while fetching data from server'));
                    }
                    if (!snapshot.hasData) {
                      return const Text('data');
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data?.cartData?.cart?.length ?? 0,
                          itemBuilder: (context, index) {
                            return FoodCartAndFavouriteListingWidget(
                              isDarkModeOn: isDarkModeOn,
                              isFromCart: true,
                              onTap: () {
                                getFoodCartFnc();
                              },
                              cart: snapshot.data?.cartData?.cart?[index],
                              currency: snapshot.data?.currency,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizeBoxH(10);
                          },
                        ),
                        const SizeBoxH(20),
                        CommonTextWidget(
                          color: isDarkModeOn
                              ? AppConstants.white
                              : AppConstants.black,
                          text: "Add on",
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizeBoxH(10),
                        ListView.separated(
                          itemCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) =>
                              SizeBoxH(Responsive.height * 1),
                          itemBuilder: (context, index) {
                            return const AddOnWdgets(
                              isCart: true,
                            );
                          },
                        ),
                        const SizeBoxH(20),
                        CommonTextWidget(
                          color: isDarkModeOn
                              ? AppConstants.white
                              : AppConstants.black,
                          text: "Saved Address",
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizeBoxH(20),
                        Consumer<FoodAddressProvider>(
                            builder: (context, obj, _) {
                          return FoodAddressWidget(
                            isDarkModeOn: isDarkModeOn,
                            isSelected: false,
                            addressData: obj.foodAddressModel
                                .shippingAddress?[obj.selectedAddressIndex],
                          );
                        }),
                        const SizeBoxH(20),
                        CommonTextWidget(
                          color: isDarkModeOn
                              ? AppConstants.white
                              : AppConstants.black,
                          text: "Save on your order",
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizeBoxH(10),
                        FoodAddCouponWidget(
                          isDarkModeOn: isDarkModeOn,
                        ),
                        const SizeBoxH(20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTextWidget(
                              color: isDarkModeOn
                                  ? AppConstants.white
                                  : AppConstants.black,
                              text: "Payment summary",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizeBoxH(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonTextWidget(
                                  color: isDarkModeOn
                                      ? AppConstants.white
                                      : AppConstants.black,
                                  text: "Discountable amount",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                CommonTextWidget(
                                  color: isDarkModeOn
                                      ? AppConstants.white
                                      : AppConstants.black,
                                  text:
                                      '${snapshot.data?.currency ?? ''} ${snapshot.data?.cartData?.totalDiscount ?? ''}',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                            const SizeBoxH(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonTextWidget(
                                  color: isDarkModeOn
                                      ? AppConstants.white
                                      : AppConstants.black,
                                  text: "Payable",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                CommonTextWidget(
                                  color: isDarkModeOn
                                      ? AppConstants.white
                                      : AppConstants.black,
                                  text:
                                      '${snapshot.data?.currency ?? ''} ${snapshot.data?.cartData?.totalSubTotal ?? ''}',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                            const SizeBoxH(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      '${snapshot.data?.currency ?? ''} ${snapshot.data?.cartData?.totalPrice ?? ''}',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizeBoxH(40),
                        CommonButton(
                          ontap: () {
                            // context.push(AppRouter.orderHistoryScreen);
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return FoodPaymentMethodChoosingWidget(
                                    isDarkModeOn: isDarkModeOn,
                                  );
                                });
                          },
                          height: Responsive.height * 6,
                          text: "Checkout",
                          isDarkMode: isDarkModeOn,
                        ),
                        const SizeBoxH(20)
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodCartAndFavouriteListingShimmer extends StatelessWidget {
  final bool isDarkModeOn;
  const FoodCartAndFavouriteListingShimmer(
      {super.key, required this.isDarkModeOn});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: isDarkModeOn ? Colors.grey[700]! : Colors.grey[300]!,
      highlightColor: isDarkModeOn ? Colors.grey[500]! : Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[300]!,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              height: Responsive.height * 12,
              width: Responsive.height * 12,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizeBoxV(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 16,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 12,
                    width: 100,
                    color: Colors.grey,
                  ),
                  const SizeBoxH(10),
                  Container(
                    height: 16,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                  const SizeBoxH(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 16,
                        width: 50,
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            color: Colors.grey,
                          ),
                          const SizeBoxV(10),
                          Container(
                            height: 16,
                            width: 20,
                            color: Colors.grey,
                          ),
                          const SizeBoxV(10),
                          Container(
                            height: 25,
                            width: 25,
                            color: Colors.grey,
                          ),
                          const SizeBoxV(10),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

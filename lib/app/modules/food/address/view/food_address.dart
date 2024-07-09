import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/app_router.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';

import '../../../../utils/app_constants.dart';
import '../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../widgets/common_widgets.dart';
import '../view_model/address_provider.dart';
import '../widgets/food_address_widgets.dart';

class FoodAddressScreen extends StatefulWidget {
  const FoodAddressScreen({super.key});

  @override
  State<FoodAddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<FoodAddressScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FoodAddressProvider>().getAllAddressFnc(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, _) => WillPopScope(
        onWillPop: () {
          if (context.read<FoodAddressProvider>().selectedAddressIndex == -1) {
            toast(context, title: "Please select address");
          } else {
            context.pop();
          }
          return Future.value(false);
        },
        child: Scaffold(
          backgroundColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          appBar: AppBar(
            surfaceTintColor:
                isDarkModeOn ? AppConstants.black : AppConstants.white,
            title: CommonTextWidget(
              color: isDarkModeOn ? AppConstants.white : AppConstants.black,
              text: "Address",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            backgroundColor:
                isDarkModeOn ? AppConstants.black : AppConstants.white,
            leading: IconButton(
              onPressed: () {
                if (context.read<FoodAddressProvider>().selectedAddressIndex ==
                    -1) {
                  toast(context, title: "Please select address");
                } else {
                  context.pop();
                }
              },
              icon: Icon(
                Icons.arrow_back,
                color: isDarkModeOn ? AppConstants.white : AppConstants.black,
              ),
            ),
            actions: [
              CommonInkwell(
                onTap: () {
                  context.push(AppRouter.foodAddaddresscreen);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isDarkModeOn
                          ? AppConstants.commonGold
                          : AppConstants.darkBlue,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonTextWidget(
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black,
                        text: "Add New Address",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      Icon(
                        Icons.add,
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: const ScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextWidget(
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                  text: "Saved Address",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizeBoxH(20),
                Consumer<FoodAddressProvider>(builder: (context, obj, child) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return FoodAddressWidget(
                        isDarkModeOn: isDarkModeOn,
                        isAddressScreen: true,
                        addressData:
                            obj.foodAddressModel.shippingAddress?[index],
                        isSelected:
                            obj.selectedAddressIndex == index ? true : false,
                        onTap: () {
                          obj.updateSelectedAddressIndex(index: index);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const SizeBoxH(15),
                    itemCount:
                        obj.foodAddressModel.shippingAddress?.length ?? 0,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

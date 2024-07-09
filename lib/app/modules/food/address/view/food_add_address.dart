import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/modules/food/address/view_model/address_provider.dart';

import '../../../../helpers/extentions.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../widgets/common_widgets.dart';
import '../widgets/food_phone_widget.dart';

class FoodAddAddressScreen extends StatefulWidget {
  final String? addressId;
  const FoodAddAddressScreen({super.key, this.addressId});

  @override
  State<FoodAddAddressScreen> createState() => _FoodAddAddressScreenState();
}

class _FoodAddAddressScreenState extends State<FoodAddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    log('adressId: ${widget.addressId.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      // ignore: deprecated_member_use
      builder: (context, isDarkModeOn, _) => WillPopScope(
        onWillPop: () {
          context.pop();
          context.read<FoodAddressProvider>().clearFnc();
          context.read<FoodAddressProvider>().updateIsEdit(isEdit: false);
          return Future.value(true);
        },
        child: Scaffold(
          backgroundColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          appBar: AppBar(
            title: CommonTextWidget(
              color: isDarkModeOn ? AppConstants.white : AppConstants.black,
              text: "Add New Address",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            backgroundColor:
                isDarkModeOn ? AppConstants.black : AppConstants.white,
            leading: IconButton(
              onPressed: () {
                context.pop();
                context.read<FoodAddressProvider>().clearFnc();
                context.read<FoodAddressProvider>().updateIsEdit(isEdit: false);
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
            child: Consumer<FoodAddressProvider>(builder: (context, obj, _) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextWidget(
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      text: "Personal Details",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizeBoxH(20),
                    CommonTextFormField(
                      bgColor: AppConstants.transparent,
                      hintText: "Full Name",
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      controller: obj.foodAddresNameControll,
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizeBoxH(20),
                    FoodCountryCodeWithPhoneFieldWidget(
                      phoneController: obj.foodAddresPhoneNumberControll,
                      provider: obj,
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    const SizeBoxH(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Responsive.width * 42,
                          child: CommonTextFormField(
                            bgColor: AppConstants.transparent,
                            hintText: "Country",
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            controller: obj.foodAddresCountryControll,
                            validator: (p0) {
                              if (p0 == null || p0.isEmpty) {
                                return 'Please enter your country';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: Responsive.width * 42,
                          child: CommonTextFormField(
                            bgColor: AppConstants.transparent,
                            hintText: "City",
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            controller: obj.foodAddresCityControll,
                            validator: (p0) {
                              if (p0 == null || p0.isEmpty) {
                                return 'Please enter your city';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizeBoxH(20),
                    CommonTextFormField(
                        bgColor: AppConstants.transparent,
                        hintText: "Street Address",
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        controller: obj.foodAddresStreetAddressControll,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Please enter your street address';
                          }
                          return null;
                        }),
                    const SizeBoxH(20),
                    CommonTextFormField(
                      bgColor: AppConstants.transparent,
                      hintText: "Zip Code",
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      controller: obj.foodAddresZipCodeControll,
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Please enter your zip code';
                        }
                        return null;
                      },
                    ),
                    const SizeBoxH(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CommonInkwell(
                              onTap: () {
                                obj.updateAddressType(value: "Home");
                              },
                              child: Container(
                                width: 40,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isDarkModeOn
                                        ? AppConstants.commonGold
                                        : AppConstants.darkBlue,
                                  ),
                                  color: obj.addressType == 'Home'
                                      ? isDarkModeOn
                                          ? AppConstants.commonGold
                                          : AppConstants.darkBlue
                                      : isDarkModeOn
                                          ? AppConstants.transparent
                                          : AppConstants.transparent,
                                ),
                                child: Center(
                                  child: CommonTextWidget(
                                    color: obj.addressType == 'Home'
                                        ? isDarkModeOn
                                            ? AppConstants.black
                                            : AppConstants.white
                                        : isDarkModeOn
                                            ? AppConstants.white
                                            : AppConstants.black,
                                    text: "Home",
                                    fontSize: 8,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const SizeBoxV(10),
                            CommonInkwell(
                              onTap: () {
                                obj.updateAddressType(value: "Work");
                              },
                              child: Container(
                                width: 40,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isDarkModeOn
                                        ? AppConstants.commonGold
                                        : AppConstants.darkBlue,
                                  ),
                                  color: obj.addressType == 'Work'
                                      ? isDarkModeOn
                                          ? AppConstants.commonGold
                                          : AppConstants.darkBlue
                                      : isDarkModeOn
                                          ? AppConstants.transparent
                                          : AppConstants.transparent,
                                ),
                                child: Center(
                                  child: CommonTextWidget(
                                    color: obj.addressType == 'Work'
                                        ? isDarkModeOn
                                            ? AppConstants.black
                                            : AppConstants.white
                                        : isDarkModeOn
                                            ? AppConstants.white
                                            : AppConstants.black,
                                    text: "Work",
                                    fontSize: 8,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: obj.isSetDefault,
                              onChanged: (value) {
                                obj.updateIsSetDefault();
                              },
                              activeColor: isDarkModeOn
                                  ? AppConstants.commonGold
                                  : AppConstants.darkBlue,
                              checkColor: isDarkModeOn
                                  ? AppConstants.black
                                  : AppConstants.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            CommonTextWidget(
                              color: isDarkModeOn
                                  ? AppConstants.white
                                  : AppConstants.black,
                              text: "Set as default",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizeBoxH(20),
                    CommonButton(
                      ontap: () {
                        if (_formKey.currentState!.validate()) {
                          if (obj.addressType == 'Home' ||
                              obj.addressType == 'Work') {
                            if (obj.isEditAddress) {
                              obj.editAddressFnc(
                                  context: context,
                                  addressId: widget.addressId ?? "");
                            } else {
                              obj.addAddressFnc(
                                context: context,
                              );
                            }
                          } else {
                            toast(context,
                                backgroundColor: Colors.red,
                                title: "Please select address type");
                          }
                        }
                      },
                      height: Responsive.height * 6,
                      text: "Save",
                      isDarkMode: isDarkModeOn,
                    ),
                    const SizeBoxH(20)
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

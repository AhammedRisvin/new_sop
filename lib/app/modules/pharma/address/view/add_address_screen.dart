import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/extentions.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/modules/pharma/address/view_model/address_provider.dart';

import '../../../../utils/app_constants.dart';
import '../../../widgets/common_widgets.dart';
import '../../home/home screen/view model/theme_provider.dart';
import '../widget/home_or_work_widget.dart';
import '../widget/phone_widget.dart';

class AddAddressScreen extends StatefulWidget {
  final String isEdit;
  final String addressId;
  final String fullName;
  final String phoneNumber;
  final String address;
  final String city;
  final String state;
  final String pincode;
  final String dialCodeShipping;
  final String isDefault;
  final String addressType;

  const AddAddressScreen({
    super.key,
    required this.isEdit,
    required this.addressId,
    required this.fullName,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
    required this.dialCodeShipping,
    required this.isDefault,
    required this.addressType,
  });

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final TextEditingController _fullNameCntrlr = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryCntrlr = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _streetAddressCntrlr = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  PharmaAddressProvider? provider;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    provider = context.read<PharmaAddressProvider>();
    if (widget.isEdit == "true") {
      _fullNameCntrlr.text = widget.fullName;
      _phoneController.text = widget.phoneNumber;
      _countryCntrlr.text = widget.state;
      _cityController.text = widget.city;
      _streetAddressCntrlr.text = widget.address;
      _zipCodeController.text = widget.pincode;
      provider?.countryCodeCtrl = widget.dialCodeShipping;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        provider?.setAddressType(widget.addressType);
        provider?.isDefault = widget.isDefault == "true" ? true : false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, _) => Scaffold(
        backgroundColor: isDarkModeOn ? AppConstants.black : AppConstants.white,
        appBar: AppBar(
          title: CommonTextWidget(
            color: isDarkModeOn ? AppConstants.white : AppConstants.black,
            text: widget.isEdit == "true" ? "Edit Address" : "Add New Address",
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
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Consumer<PharmaAddressProvider>(
              builder: (context, provider, child) {
                final isDefaultTapped = provider.isDefault;
                return Column(
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
                      controller: _fullNameCntrlr,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      borderColor: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black10,
                    ),
                    const SizeBoxH(20),
                    CountryCodeWithPhoneFieldWidget(
                      isDarkModeOn: isDarkModeOn,
                      phoneController: _phoneController,
                      provider: provider,
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
                            color: isDarkModeOn
                                ? AppConstants.white
                                : AppConstants.black,
                            borderColor: isDarkModeOn
                                ? AppConstants.white
                                : AppConstants.black10,
                            textInputAction: TextInputAction.next,
                            controller: _countryCntrlr,
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
                            controller: _cityController,
                            color: isDarkModeOn
                                ? AppConstants.white
                                : AppConstants.black,
                            borderColor: isDarkModeOn
                                ? AppConstants.white
                                : AppConstants.black10,
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
                      controller: _streetAddressCntrlr,
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      borderColor: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black10,
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Please enter your street address';
                        }
                        return null;
                      },
                    ),
                    const SizeBoxH(20),
                    CommonTextFormField(
                      bgColor: AppConstants.transparent,
                      hintText: "Zip Code",
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      controller: _zipCodeController,
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      borderColor: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black10,
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
                            HomeOrWorkWidget(
                              isDarkModeOn: isDarkModeOn,
                              text: "Home",
                              onTap: () {
                                provider.setAddressType("Home");
                              },
                              provider: provider,
                            ),
                            const SizeBoxV(10),
                            HomeOrWorkWidget(
                              isDarkModeOn: isDarkModeOn,
                              text: "Work",
                              onTap: () {
                                provider.setAddressType("Work");
                              },
                              provider: provider,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 1,
                              child: Checkbox(
                                value: provider.isDefault,
                                onChanged: (value) {
                                  provider.toggleDefaultStatus();
                                },
                                activeColor: isDarkModeOn
                                    ? isDefaultTapped
                                        ? AppConstants.commonGold
                                        : AppConstants.transparent
                                    : isDefaultTapped
                                        ? AppConstants.darkBlue
                                        : AppConstants.transparent,
                                checkColor: isDarkModeOn
                                    ? isDefaultTapped
                                        ? AppConstants.black
                                        : AppConstants.transparent
                                    : isDefaultTapped
                                        ? AppConstants.white
                                        : AppConstants.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide(
                                      color: isDarkModeOn
                                          ? isDefaultTapped
                                              ? AppConstants.darkBlue
                                              : AppConstants.white
                                          : isDefaultTapped
                                              ? AppConstants.commonGold
                                              : AppConstants.black,
                                    )),
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
                        widget.isEdit == "true"
                            ? provider.editAddressFn(
                                ctx: context,
                                address: _streetAddressCntrlr.text,
                                city: _cityController.text,
                                pincode: _zipCodeController.text,
                                state: _countryCntrlr.text,
                                name: _fullNameCntrlr.text,
                                phone: _phoneController.text,
                                addressId: widget.addressId,
                                clear: () {
                                  _fullNameCntrlr.clear();
                                  _phoneController.clear();
                                  _countryCntrlr.clear();
                                  _cityController.clear();
                                  _streetAddressCntrlr.clear();
                                  _zipCodeController.clear();
                                })
                            : provider.addAddressFn(
                                ctx: context,
                                address: _streetAddressCntrlr.text,
                                city: _cityController.text,
                                pincode: _zipCodeController.text,
                                state: _countryCntrlr.text,
                                name: _fullNameCntrlr.text,
                                phone: _phoneController.text,
                                clear: () {
                                  _fullNameCntrlr.clear();
                                  _phoneController.clear();
                                  _countryCntrlr.clear();
                                  _cityController.clear();
                                  _streetAddressCntrlr.clear();
                                  _zipCodeController.clear();
                                });
                      },
                      height: Responsive.height * 6,
                      text: "Save",
                      isDarkMode: isDarkModeOn,
                    ),
                    const SizeBoxH(20)
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fullNameCntrlr.dispose();
    _phoneController.dispose();
    _countryCntrlr.dispose();
    _cityController.dispose();
    _streetAddressCntrlr.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }
}

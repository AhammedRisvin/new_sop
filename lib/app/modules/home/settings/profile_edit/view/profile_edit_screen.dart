import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';

import '../../../../../helpers/extentions.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../../widgets/common_widgets.dart';
import '../../widget/feet_and_cm_radio_widget.dart';
import '../../widget/gender_selecting_widget.dart';
import '../../widget/textfield_with_country_code_widget.dart';
import '../view_model/profile_edit_provider.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({
    super.key,
    required this.userName,
    this.profileImage,
    this.phoneNumber,
    this.dialCode,
    this.height,
    this.weight,
    this.dateOfBirth,
    this.unit,
    this.gender,
    required this.isEdit,
  });

  final String userName;
  final String? profileImage;
  final String? phoneNumber;
  final String? dialCode;
  final String? height;
  final String? weight;
  final String? dateOfBirth;
  final String? unit;
  final String? gender;
  final String isEdit;

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

ProfileEditProvider? provider;

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  void initState() {
    super.initState();
    log("ProfileEditScreen: ${widget.isEdit}");
    provider = context.read<ProfileEditProvider>();
    _nameController.text = widget.userName;
    provider?.imageUrlForUpload = widget.profileImage ?? "empty";
    if (widget.isEdit == "True") {
      _phoneController.text = widget.phoneNumber ?? "";
      _heightController.text = widget.height ?? '';
      _weightController.text = widget.weight ?? '';
      provider?.selectedDate = widget.dateOfBirth ?? "";
      provider?.selectedUnit = widget.unit ?? "feet";
    }
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, child) => Scaffold(
        backgroundColor: isDarkModeOn ? AppConstants.black : AppConstants.white,
        appBar: AppBar(
          backgroundColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          surfaceTintColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          title: CommonTextWidget(
            color: isDarkModeOn ? AppConstants.white : AppConstants.black,
            text: "Profile Edit",
            fontSize: 14,
            letterSpacing: 0.5,
            fontWeight: FontWeight.w500,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: isDarkModeOn ? AppConstants.white : AppConstants.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<ProfileEditProvider>(
            builder: (context, provider, child) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                if (widget.isEdit == true) {
                  provider.updateCountryCode(widget.dialCode ?? "+971");
                  provider.updateSelectedGender(widget.gender ?? "Male");
                }
              });
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        CommonInkwell(
                          onTap: () {
                            provider.uploadImage(context: context);
                          },
                          child: provider.thumbnailImage == null ||
                                  provider.thumbnailImage!.path.isEmpty
                              ? CachedImageWidget(
                                  imageUrl: widget.profileImage ??
                                      "assets/images/defaultProfPic.png",
                                  height: Responsive.height * 10,
                                  width: Responsive.height * 10,
                                  borderRadius: BorderRadius.circular(100),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(
                                    provider.thumbnailImage ?? File(""),
                                    height: Responsive.height * 10,
                                    width: Responsive.height * 10,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        const SizeBoxH(10),
                        CommonTextWidget(
                          color: isDarkModeOn
                              ? AppConstants.white
                              : AppConstants.black,
                          text: "Change Profile Picture",
                          fontSize: 12,
                          letterSpacing: -0.1,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  const SizeBoxH(30),
                  CommonTextWidget(
                    color:
                        isDarkModeOn ? AppConstants.white : AppConstants.black,
                    text: "Full name",
                    fontSize: 14,
                    letterSpacing: -0.1,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizeBoxH(10),
                  CommonTextFormField(
                    bgColor: AppConstants.transparent,
                    hintText: "",
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    controller: _nameController,
                    color:
                        isDarkModeOn ? AppConstants.white : AppConstants.black,
                    borderColor: isDarkModeOn
                        ? AppConstants.white
                        : AppConstants.black10,
                  ),
                  const SizeBoxH(10),
                  CommonTextWidget(
                    color:
                        isDarkModeOn ? AppConstants.white : AppConstants.black,
                    text: "Phone number",
                    fontSize: 14,
                    letterSpacing: -0.1,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizeBoxH(4),
                  TextFieldWithCountryCodeWidget(
                    phoneController: _phoneController,
                    isDarkModeOn: isDarkModeOn,
                    provider: provider,
                  ),
                  const SizeBoxH(10),
                  CommonTextWidget(
                    color:
                        isDarkModeOn ? AppConstants.white : AppConstants.black,
                    text: "Gender",
                    fontSize: 14,
                    letterSpacing: -0.1,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizeBoxH(4),
                  GenderSelectingWidget(
                    isDarkModeOn: isDarkModeOn,
                    provider: provider,
                  ),
                  const SizeBoxH(10),
                  CommonTextWidget(
                    color:
                        isDarkModeOn ? AppConstants.white : AppConstants.black,
                    text: "Date of Birth",
                    fontSize: 14,
                    letterSpacing: -0.1,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizeBoxH(10),
                  CommonInkwell(
                    onTap: () {
                      provider.selectDate(context);
                    },
                    child: Container(
                      height: Responsive.height * 6,
                      width: Responsive.width * 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppConstants.black10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          CommonTextWidget(
                            color: isDarkModeOn
                                ? provider.selectedDate == ""
                                    ? AppConstants.black40
                                    : AppConstants.white
                                : provider.selectedDate == ""
                                    ? AppConstants.black40
                                    : AppConstants.black,
                            text: provider.selectedDate == ""
                                ? "Select Date"
                                : provider.selectedDate,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          const Spacer(),
                          Image.asset(
                            "assets/icons/calenderIcon.png",
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizeBoxH(15),
                  CommonTextWidget(
                    color:
                        isDarkModeOn ? AppConstants.white : AppConstants.black,
                    text: "Height (In feet / Cm)",
                    fontSize: 12,
                    letterSpacing: -0.1,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizeBoxH(15),
                  Row(
                    children: [
                      SizedBox(
                        width: Responsive.width * 43,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                FeetAndCmWidget(
                                  isDarkModeOn: isDarkModeOn,
                                  title: "feet",
                                  isSelected: provider.selectedUnit == "feet",
                                  onSelect: () {
                                    provider.onSelect("feet");
                                  },
                                ),
                                const SizeBoxV(10),
                                FeetAndCmWidget(
                                  isDarkModeOn: isDarkModeOn,
                                  title: "Cm",
                                  isSelected: provider.selectedUnit == "Cm",
                                  onSelect: () {
                                    provider.onSelect("Cm");
                                  },
                                ),
                              ],
                            ),
                            const SizeBoxH(10),
                            CommonTextFormField(
                              bgColor: AppConstants.transparent,
                              hintText: "",
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              controller: _heightController,
                              color: isDarkModeOn
                                  ? AppConstants.white
                                  : AppConstants.black,
                              borderColor: isDarkModeOn
                                  ? AppConstants.white
                                  : AppConstants.black10,
                            )
                          ],
                        ),
                      ),
                      const SizeBoxV(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTextWidget(
                              color: isDarkModeOn
                                  ? AppConstants.white
                                  : AppConstants.black,
                              text: "Weight (In Kg)",
                              fontSize: 12,
                              letterSpacing: -0.1,
                              fontWeight: FontWeight.w500,
                            ),
                            const SizeBoxH(10),
                            CommonTextFormField(
                              bgColor: AppConstants.transparent,
                              hintText: "",
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              controller: _weightController,
                              color: isDarkModeOn
                                  ? AppConstants.white
                                  : AppConstants.black,
                              borderColor: isDarkModeOn
                                  ? AppConstants.white
                                  : AppConstants.black10,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizeBoxH(30),
                  CommonButton(
                    ontap: () {
                      provider.updateProfileFn(
                          name: _nameController.text,
                          phone: _phoneController.text,
                          heigh: _heightController.text,
                          weight: _weightController.text,
                          context: context,
                          clear: () {
                            _nameController.clear();
                            _phoneController.clear();
                            _heightController.clear();
                            _weightController.clear();
                          });
                    },
                    height: Responsive.height * 6,
                    text: "Update Profile",
                    isDarkMode: isDarkModeOn,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

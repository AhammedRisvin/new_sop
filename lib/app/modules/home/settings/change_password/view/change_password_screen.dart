import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/extentions.dart';
import '../../../../../helpers/size_box.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../../widgets/common_widgets.dart';
import '../view_model/change_password_provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
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
            text: "Change Password",
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<ChangePasswordProvider>(
            builder: (context, provider, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizeBoxH(20),
                CommonTextWidget(
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                  text: "Current Password",
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
                  controller: _currentPasswordController,
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                  borderColor:
                      isDarkModeOn ? AppConstants.white : AppConstants.black10,
                ),
                const SizeBoxH(10),
                CommonTextWidget(
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                  text: "New Password",
                  fontSize: 14,
                  letterSpacing: -0.1,
                  fontWeight: FontWeight.w500,
                ),
                const SizeBoxH(10),
                CommonTextFormField(
                    bgColor: AppConstants.transparent,
                    hintText: "",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: _newPasswordController,
                    obscureText: provider.isPasswordVisible,
                    color:
                        isDarkModeOn ? AppConstants.white : AppConstants.black,
                    borderColor: isDarkModeOn
                        ? AppConstants.white
                        : AppConstants.black10,
                    maxLine: 1,
                    suffixIcon: IconButton(
                      onPressed: () {
                        provider.togglePasswordVisibility();
                      },
                      icon: Icon(
                        provider.isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black,
                      ),
                    )),
                const SizeBoxH(10),
                CommonTextWidget(
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                  text: "confirm Password",
                  fontSize: 14,
                  letterSpacing: -0.1,
                  fontWeight: FontWeight.w500,
                ),
                const SizeBoxH(10),
                CommonTextFormField(
                    bgColor: AppConstants.transparent,
                    hintText: "",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: _confirmPasswordController,
                    color:
                        isDarkModeOn ? AppConstants.white : AppConstants.black,
                    borderColor: isDarkModeOn
                        ? AppConstants.white
                        : AppConstants.black10,
                    obscureText: provider.isConfirmPasswordVisible,
                    maxLine: 1,
                    suffixIcon: IconButton(
                      onPressed: () {
                        provider.toggleConfirmPasswordVisibility();
                      },
                      icon: Icon(
                        provider.isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black,
                      ),
                    )),
                const SizeBoxH(30),
                CommonButton(
                  ontap: () {
                    provider.changePasswordFn(
                      context: context,
                      oldPassword: _currentPasswordController.text,
                      newPassword: _newPasswordController.text,
                      confirmPassword: _confirmPasswordController.text,
                      clear: () {
                        _currentPasswordController.clear();
                        _newPasswordController.clear();
                        _confirmPasswordController.clear();
                      },
                    );
                  },
                  height: Responsive.height * 6,
                  text: "Update Password",
                  isDarkMode: isDarkModeOn,
                  fontSize: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

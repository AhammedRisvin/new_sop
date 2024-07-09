import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/app_router.dart';
import 'package:sophwe_newmodule/app/helpers/extentions.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/modules/auth/view%20model/auth_provider.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/home%20screen/view%20model/theme_provider.dart';
import 'package:sophwe_newmodule/app/modules/widgets/common_widgets.dart';
import 'package:sophwe_newmodule/app/utils/app_constants.dart';
import 'package:sophwe_newmodule/app/utils/app_images.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordCntrlr = TextEditingController();
  final TextEditingController confirmPasswordCntrlr = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordCntrlr.dispose();
    confirmPasswordCntrlr.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (_, value) => value.isDarkModeOn,
      builder: (_, isDarkModeOn, __) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          appBar: AppBar(
            surfaceTintColor:
                isDarkModeOn ? AppConstants.black : AppConstants.white,
            backgroundColor:
                isDarkModeOn ? AppConstants.black : AppConstants.white,
            actions: [
              TextButton(
                onPressed: () {
                  context.pushNamed(AppRouter.mainBottomNav);
                },
                child: CommonTextWidget(
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                  text: "SKIP",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
            automaticallyImplyLeading: false,
          ),
          body: Consumer<AuthProvider>(
            builder: (context, provider, child) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: Responsive.width * 3),
                        child: Image.asset(
                          AppImages.loginNameLogo,
                          color: isDarkModeOn
                              ? AppConstants.commonGold
                              : AppConstants.darkBlue,
                          height: Responsive.height * 7.5,
                        ),
                      ),
                      const SizeBoxH(40),
                      CommonTextWidget(
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black,
                        text: provider.isSignUpTapped
                            ? "Lets Get Started !"
                            : "Welcome back",
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                      CommonTextWidget(
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.tInactive,
                        text: provider.isSignUpTapped
                            ? "Please sign Up  to Continue"
                            : "Please sign in in to your account",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.4,
                      ),
                      if (provider.isSignUpTapped) ...[
                        const SizeBoxH(18),
                        CommonInkwell(
                          onTap: () {
                            provider.uploadImage(context: context);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: (provider.thumbnailImage != null
                                ? Image.file(
                                    provider.thumbnailImage!,
                                    height: Responsive.height * 10,
                                    width: Responsive.height * 10,
                                    fit: BoxFit.cover,
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "assets/icons/addProfileImageIcon.png",
                                      height: Responsive.height * 10,
                                      width: Responsive.height * 10,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                          ),
                        ),
                        const SizeBoxH(20),
                        CommonTextFormField(
                          bgColor: AppConstants.transparent,
                          controller: fullNameController,
                          hintText: "Full name",
                          contentPadding: EdgeInsets.symmetric(
                            vertical: Responsive.height * 1.8,
                            horizontal: 10,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          radius: 10,
                          color: isDarkModeOn
                              ? AppConstants.white
                              : AppConstants.black,
                          borderColor: isDarkModeOn
                              ? AppConstants.white
                              : AppConstants.black10,
                        ),
                      ],
                      const SizeBoxH(14),
                      CommonTextFormField(
                        bgColor: AppConstants.transparent,
                        controller: emailController,
                        hintText: "Email",
                        contentPadding: EdgeInsets.symmetric(
                          vertical: Responsive.height * 2,
                          horizontal: 10,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        radius: 10,
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black,
                        borderColor: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black10,
                      ),
                      const SizeBoxH(14),
                      CommonTextFormField(
                        bgColor: AppConstants.transparent,
                        controller: passwordCntrlr,
                        hintText: "Password",
                        contentPadding: EdgeInsets.symmetric(
                          vertical: Responsive.height * 2,
                          horizontal: 10,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        radius: 10,
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black,
                        borderColor: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black10,
                        suffixIcon: IconButton(
                          onPressed: () {
                            provider.updateVisibility();
                          },
                          icon: provider.toggleVisibility
                              ? Image.asset(
                                  "assets/images/vidibility.png",
                                  height: 18,
                                  color: AppConstants.darkBlue,
                                )
                              : Image.asset(
                                  "assets/images/vidibilityOff.png",
                                  height: 18,
                                  color: AppConstants.darkBlue,
                                ),
                        ),
                        obscureText: provider.toggleVisibility,
                        maxLine: 1,
                      ),
                      const SizeBoxH(14),
                      if (provider.isSignUpTapped) ...[
                        CommonTextFormField(
                          bgColor: AppConstants.transparent,
                          controller: confirmPasswordCntrlr,
                          hintText: "Confirm Password",
                          contentPadding: EdgeInsets.symmetric(
                            vertical: Responsive.height * 1.8,
                            horizontal: 10,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          radius: 10,
                          color: isDarkModeOn
                              ? AppConstants.white
                              : AppConstants.black,
                          borderColor: isDarkModeOn
                              ? AppConstants.white
                              : AppConstants.black10,
                          suffixIcon: IconButton(
                            onPressed: () {
                              provider.updateConfirmPasswordVisibility();
                            },
                            icon: provider.toggleConfirmPasswordVisibility
                                ? Image.asset(
                                    "assets/images/vidibility.png",
                                    height: 18,
                                    color: AppConstants.darkBlue,
                                  )
                                : Image.asset(
                                    "assets/images/vidibilityOff.png",
                                    height: 18,
                                    color: AppConstants.darkBlue,
                                  ),
                          ),
                          obscureText: provider.toggleConfirmPasswordVisibility,
                          maxLine: 1,
                        ),
                        const SizeBoxH(18),
                      ],
                      CommonButton(
                        ontap: () {
                          // context.pushNamed(AppRouter.mainBottomNav);
                          provider.isSignUpTapped
                              ? provider.signUpFn(
                                  context: context,
                                  email: emailController.text,
                                  password: passwordCntrlr.text,
                                  confirmPassword: confirmPasswordCntrlr.text,
                                  fullName: fullNameController.text,
                                  clear: () {
                                    emailController.clear();
                                    passwordCntrlr.clear();
                                    confirmPasswordCntrlr.clear();
                                    fullNameController.clear();
                                  },
                                )
                              : provider.signInFn(
                                  context: context,
                                  email: emailController.text,
                                  password: passwordCntrlr.text,
                                );
                          FocusScope.of(context).unfocus();
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        height: Responsive.height * 5.7,
                        text: provider.isSignUpTapped ? "Sign Up" : "Sign in",
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        isDarkMode: isDarkModeOn,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CommonTextWidget(
                            color: isDarkModeOn
                                ? AppConstants.white
                                : AppConstants.black,
                            text: provider.isSignUpTapped
                                ? "Do you have an account ?"
                                : "Don`t have an account ?",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.5,
                          ),
                          TextButton(
                            onPressed: () {
                              provider.updateSignUpTapped();
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: CommonTextWidget(
                                color: isDarkModeOn
                                    ? AppConstants.commonGold
                                    : AppConstants.darkBlue,
                                text: provider.isSignUpTapped
                                    ? "Sign In"
                                    : "Register",
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

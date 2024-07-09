// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sophwe_newmodule/app/helpers/app_router.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/modules/home/settings/main/view_model/settings_provider.dart';
import 'package:sophwe_newmodule/app/utils/app_images.dart';
import 'package:sophwe_newmodule/app/utils/enums.dart';

import '../../../../../utils/app_constants.dart';
import '../../../../../utils/prefferences.dart';
import '../../../../bottom_navigation_bar/view model/main_bottom_navigation_provider.dart';
import '../../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../../widgets/confimration_widget.dart';
import '../../widget/list_tile_widget.dart';
import '../../widget/profile_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSignedIn = false;
  @override
  void initState() {
    super.initState();

    isSignedIn = AppPref.isSignedIn;
    context.read<SettingsProvider>().getProfileDataFn();
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
          automaticallyImplyLeading: false,
          title: CommonTextWidget(
            color: isDarkModeOn ? AppConstants.white : AppConstants.black,
            text: "Settings",
            fontSize: 18,
            letterSpacing: 0.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Consumer<SettingsProvider>(
            builder: (context, provider, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                provider.getProfileStatus == GetProfileStatus.loading
                    ? const Align(
                        alignment: Alignment.centerLeft,
                        child: CircularProgressIndicator(),
                      )
                    : provider.getProfileStatus == GetProfileStatus.success
                        ? ProfileWidget(
                            isDarkModeOn: isDarkModeOn,
                            data: provider.getProfileData.profileData,
                          )
                        : const SizedBox.shrink(),
                const SizeBoxH(15),
                CommonTextWidget(
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                  text: "Account",
                  fontSize: 14,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w600,
                ),
                SettingsCommonListTileWidget(
                  isDarkModeOn: isDarkModeOn,
                  ontap: () {
                    if (isSignedIn) {
                      final isEdit =
                          provider.getProfileData.profileData?.phoneNumber ==
                                  null
                              ? "False"
                              : "True";
                      context.pushNamed(AppRouter.profileEditScreen,
                          queryParameters: {
                            "userName":
                                provider.getProfileData.profileData?.name,
                            "profileImage": provider
                                .getProfileData.profileData?.profileImage,
                            "phoneNumber": provider
                                .getProfileData.profileData?.phoneNumber,
                            "height": provider
                                .getProfileData.profileData?.height?.height
                                .toString(),
                            "weight": provider
                                .getProfileData.profileData?.weight
                                .toString(),
                            "dateOfBirth": provider.formatDateOfBirth(
                              provider.getProfileData.profileData
                                      ?.dateOfBirth ??
                                  DateTime.now(),
                            ),
                            "unit": provider
                                .getProfileData.profileData?.height?.unit,
                            "dialCode":
                                provider.getProfileData.profileData?.dialCode,
                            "gender":
                                provider.getProfileData.profileData?.gender,
                            "isEdit": isEdit
                          });
                    } else {
                      toast(context,
                          title: "Please login to edit profile",
                          backgroundColor: Colors.red);
                    }
                  },
                  image: AppImages.settingProfileIcon,
                  title: "Profile edit",
                ),
                SettingsCommonListTileWidget(
                  isDarkModeOn: isDarkModeOn,
                  isFromDarkMode: true,
                  ontap: () {},
                  image: AppImages.settingDarkModeIcon,
                  title: "Dark mode",
                ),
                SettingsCommonListTileWidget(
                  isDarkModeOn: isDarkModeOn,
                  ontap: () {
                    if (isSignedIn) {
                      context.pushNamed(AppRouter.reminderScreen);
                    } else {
                      toast(context,
                          title: "Please login to access reminder screen",
                          backgroundColor: Colors.red);
                    }
                  },
                  image: AppImages.settingReminderIcon,
                  title: "Reminder",
                ),
                const SizeBoxH(10),
                SettingsCommonListTileWidget(
                  isDarkModeOn: isDarkModeOn,
                  ontap: () {
                    if (isSignedIn) {
                      context.pushNamed(AppRouter.walletScreen);
                    } else {
                      toast(context,
                          title: "Please login to access wallet screen",
                          backgroundColor: Colors.red);
                    }
                  },
                  image: AppImages.settingReminderIcon,
                  title: "Wallet",
                ),
                const SizeBoxH(15),
                // CommonTextWidget(
                //   color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                //   text: "Security",
                //   fontSize: 14,
                //   letterSpacing: 0.5,
                //   fontWeight: FontWeight.w600,
                // ),
                SettingsCommonListTileWidget(
                  isDarkModeOn: isDarkModeOn,
                  ontap: () {
                    if (isSignedIn) {
                      context.pushNamed(AppRouter.changePasswordScreen);
                    } else {
                      toast(context,
                          title: "Please login to change password",
                          backgroundColor: Colors.red);
                    }
                  },
                  image: AppImages.settingsPasswordImage,
                  title: "Change Password",
                ),
                const SizeBoxH(30),
                // CommonTextWidget(
                //   color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                //   text: "Support & About",
                //   fontSize: 14,
                //   letterSpacing: 0.5,
                //   fontWeight: FontWeight.w600,
                // ),
                // SettingsCommonListTileWidget(
                //   isDarkModeOn: isDarkModeOn,
                //   ontap: () {},
                //   image: AppImages.settingsPasswordImage,
                //   title: "Terms & Conditions",
                //   isShowLeadingIcon: false,
                //   height: 25,
                // ),
                // SettingsCommonListTileWidget(
                //   isDarkModeOn: isDarkModeOn,
                //   ontap: () {},
                //   image: AppImages.settingsPasswordImage,
                //   title: "Privacy Policy",
                //   isShowLeadingIcon: false,
                //   height: 25,
                // ),
                // SettingsCommonListTileWidget(
                //   isDarkModeOn: isDarkModeOn,
                //   ontap: () {},
                //   image: AppImages.settingsPasswordImage,
                //   title: "About Us",
                //   isShowLeadingIcon: false,
                //   height: 25,
                // ),
                const SizeBoxH(10),
                TextButton(
                  onPressed: () {
                    if (isSignedIn) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ConfirmationWidget(
                            title: "DELETE",
                            message:
                                "Are you sure you want to delete the account?",
                            onTap: () {
                              context.pop();

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return ConfirmationWidget(
                                    title: "DELETE ACCOUNT",
                                    message:
                                        "Your account will be permanently deleted after 5 working days.",
                                    onTap: () async {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.clear();
                                      context
                                          .read<MainBottomNavigationProvider>()
                                          .bottomNavIndex = 0;
                                      context.goNamed(AppRouter.initial);
                                    },
                                    buttonText: "Ok",
                                    onCancel: () {
                                      context.pop();
                                    },
                                    isDarkModeOn: isDarkModeOn,
                                  );
                                },
                              );
                            },
                            buttonText: "Delete",
                            onCancel: () {
                              context.pop();
                            },
                            isDarkModeOn: isDarkModeOn,
                          );
                        },
                      );
                    } else {
                      toast(context,
                          title: "Please login to delete account",
                          backgroundColor: Colors.red);
                    }
                  },
                  child: const CommonTextWidget(
                    color: Color(0xffE8391C),
                    text: "Delete Account",
                    fontSize: 14,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ConfirmationWidget(
                            title: "Logout",
                            message: "Are you sure you want to Logout?",
                            buttonText: "Logout",
                            onTap: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.clear();
                              context
                                  .read<MainBottomNavigationProvider>()
                                  .bottomNavIndex = 0;
                              context.goNamed(AppRouter.initial);
                            },
                            onCancel: () {
                              context.pop();
                            },
                            isDarkModeOn: isDarkModeOn,
                          );
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/logoutIcon.png",
                          height: 24,
                        ),
                        const SizeBoxV(10),
                        const CommonTextWidget(
                          color: Color(0xffE8391C),
                          text: "Logout",
                          fontSize: 14,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

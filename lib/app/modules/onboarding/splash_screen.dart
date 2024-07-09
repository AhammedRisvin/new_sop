import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sophwe_newmodule/app/utils/app_constants.dart';

import '../../helpers/app_router.dart';
import '../../helpers/extentions.dart';
import '../../utils/app_images.dart';
import '../../utils/prefferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    changeScreen(context);
  }

  bool checkingButton = false;
  Future<void> changeScreen(BuildContext context) async {
    final check = await checking();
    await Future.delayed(
      const Duration(seconds: 4),
    );
    if (check) {
      if (AppPref.isSignedIn == true) {
        context.goNamed(AppRouter.mainBottomNav);
      } else {
        context.goNamed(AppRouter.login);
      }
    } else {
      context.goNamed(AppRouter.noInternet);
    }
  }

  Future<bool> checking() async {
    checkingButton = true;
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        checkingButton = false;
        return true;
      }
      checkingButton = false;
      return false;
    } on SocketException catch (_) {
      checkingButton = false;
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.darkBlue,
      body: Center(
        child: Image.asset(
          AppImages.splashLogo,
          height: Responsive.height * 100,
          fit: BoxFit.fill,
          width: Responsive.width * 100,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sophwe_newmodule/app/modules/widgets/common_widgets.dart';

import '../../../../../backend/server_client_services.dart';
import '../../../../../backend/settings_url/settings_url.dart';
import '../../../../../helpers/loading_overlay.dart';

class ChangePasswordProvider extends ChangeNotifier {
  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  bool isConfirmPasswordVisible = false;

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    notifyListeners();
  }

  Future<void> changePasswordFn({
    required BuildContext context,
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
    required Function() clear,
  }) async {
    LoadingOverlay.of(context).show();
    try {
      if (oldPassword.isEmpty ||
          newPassword.isEmpty ||
          confirmPassword.isEmpty) {
        toast(
          context,
          title: "Please fill all the fields",
          backgroundColor: Colors.red,
        );
        return;
      }
      if (newPassword != confirmPassword) {
        toast(
          context,
          title: "Password does not match",
          backgroundColor: Colors.red,
        );
        return;
      }
      if (oldPassword == newPassword) {
        toast(
          context,
          title: "Old password and new password should not be same",
          backgroundColor: Colors.red,
        );
        return;
      }
      var params = {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      };
      List response = await ServerClient.post(
        SettingsUrl.changePasswordUrl,
        data: params,
        post: true,
      );
      if (response.first >= 200 && response.first <= 300) {
        clear();
        context.pop();
        toast(
          context,
          title: "Password changed successfully",
          backgroundColor: Colors.green,
        );
      } else {
        toast(
          context,
          title: "Something went wrong",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      debugPrint("Error in changePasswordFn: $e");
    } finally {
      LoadingOverlay.of(context).hide();
      FocusScope.of(context).unfocus();
      notifyListeners();
    }
  }
}

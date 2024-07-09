import 'package:sophwe_newmodule/app/env.dart';

class SettingsUrl {
  static String baseUrl = Environments.baseUrl;

  static String changePasswordUrl = "${baseUrl}sophwe-user/change-password";
  static String getProfileUrl = "${baseUrl}sophwe-user/get-profile";
  static String updateProfileUrl = "${baseUrl}sophwe-user/edit-profile";
  static String getWalletHistoryUrl =
      "${baseUrl}sophwe-user/get-wallet-history?";
}

import 'package:flutter/material.dart';
import 'package:sophwe_newmodule/app/backend/server_client_services.dart';
import 'package:sophwe_newmodule/app/backend/settings_url/settings_url.dart';
import 'package:sophwe_newmodule/app/utils/enums.dart';

import '../model/get_profile_data.dart';

class SettingsProvider extends ChangeNotifier {
  GetProfileData getProfileData = GetProfileData();
  GetProfileStatus getProfileStatus = GetProfileStatus.initial;

  Future<void> getProfileDataFn() async {
    try {
      getProfileStatus = GetProfileStatus.loading;
      List response = await ServerClient.get(
        SettingsUrl.getProfileUrl,
      );
      if (response.first >= 200 && response.first < 300) {
        getProfileStatus = GetProfileStatus.success;
        getProfileData = GetProfileData.fromJson(response.last);
      } else {
        getProfileStatus = GetProfileStatus.error;
        getProfileData = GetProfileData();
      }
    } catch (e) {
      getProfileData = GetProfileData();
      getProfileStatus = GetProfileStatus.error;
      debugPrint("Error in getProfileDataApiFn: $e");
    } finally {
      notifyListeners();
    }
  }

  String formatDateOfBirth(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}

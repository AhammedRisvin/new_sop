import 'package:flutter/material.dart';

import '../../../../backend/home_urls/home_urls.dart';
import '../../../../backend/server_client_services.dart';
import '../../../../utils/enums.dart';
import '../model/get_home_data_model.dart';

class HomeProvider extends ChangeNotifier {
  void justUpdate() {
    notifyListeners();
  }
  // ------------API INTEGRATION---------------- //

  GetHomeDataModel model = GetHomeDataModel();
  GetHomeStatus status = GetHomeStatus.initial;

  Future<void> getHomeDataFn() async {
    try {
      status = GetHomeStatus.loading;
      model = GetHomeDataModel();
      notifyListeners();
      List response = await ServerClient.get(
        HomeUrls.getHomeDataUrl,
      );
      if (response.first >= 200 && response.first < 300) {
        model = GetHomeDataModel.fromJson(response.last);
        status = GetHomeStatus.loaded;
        notifyListeners();
      } else {
        status = GetHomeStatus.error;
        GetHomeDataModel();
      }
    } catch (e) {
      status = GetHomeStatus.error;
      debugPrint("Error in getHomeDataFn : $e");
    } finally {
      notifyListeners();
    }
  }
}

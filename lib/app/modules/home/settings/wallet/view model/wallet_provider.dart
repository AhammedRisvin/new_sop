import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../../../../../backend/server_client_services.dart';
import '../../../../../backend/settings_url/settings_url.dart';
import '../model/get_wallet_history_model.dart';

class WalletProvider extends ChangeNotifier {
  String selectedOption = 'all';
  GetWalletHistoryModel getWalletHistoryModel = GetWalletHistoryModel();
  int walletHistoryCurrentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;

  void setSelectedOption(String option) {
    if (selectedOption != option) {
      selectedOption = option;
      walletHistoryCurrentPage = 1;
      getWalletHistoryModel = GetWalletHistoryModel();
      hasMoreData = true;
      notifyListeners();
      getWalletHistoryFn();
    }
  }

  String formatDateTime(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(const Duration(days: 1));
    DateTime inputDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    String formattedTime = DateFormat('hh:mm a').format(dateTime);

    if (inputDate == today) {
      return "Today, $formattedTime";
    } else if (inputDate == yesterday) {
      return "Yesterday, $formattedTime";
    } else {
      return DateFormat('MMM dd, yyyy, hh:mm a').format(dateTime);
    }
  }

  Future<void> getWalletHistoryFn({int page = 0}) async {
    if (isLoading || !hasMoreData) return;

    isLoading = true;
    notifyListeners();

    try {
      String pageNum =
          page != 0 ? page.toString() : walletHistoryCurrentPage.toString();
      List response = await ServerClient.get(
        "${SettingsUrl.getWalletHistoryUrl}page=$pageNum&filter=$selectedOption",
      );
      if (response.first >= 200 && response.first < 300) {
        final model = GetWalletHistoryModel.fromJson(response.last);
        if (page != 0 || walletHistoryCurrentPage == 1) {
          getWalletHistoryModel = model;
        } else {
          getWalletHistoryModel.history?.addAll(model.history ?? []);
        }

        hasMoreData = model.history!.isNotEmpty;
        if (hasMoreData) walletHistoryCurrentPage++;
      } else {
        getWalletHistoryModel = GetWalletHistoryModel();
        hasMoreData = false;
      }
    } catch (e) {
      getWalletHistoryModel = GetWalletHistoryModel();
      hasMoreData = false;
      debugPrint("Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../backend/pharmacy/urls.dart';
import '../../../../../backend/server_client_services.dart';
import '../../../../../utils/enums.dart';
import '../model/pharma_order_history_dtails_model.dart';
import '../model/pharma_order_history_model.dart';

class OrderHistoryProvider extends ChangeNotifier {
  // -------------  LIST ORDER HISTORY FN STARTS  --------- //

  GetOrderHistoryModel getOrderHistoryModel = GetOrderHistoryModel();
  PharmaOrderHistoryStatus status = PharmaOrderHistoryStatus.loading;

  String historyFilterStatus = "Placed";

  Future<void> getPharmaOrderHistoryFn({
    required String deliveryStatus,
  }) async {
    try {
      historyFilterStatus = deliveryStatus;
      getOrderHistoryModel = GetOrderHistoryModel();
      status = PharmaOrderHistoryStatus.loading;
      List response = await ServerClient.get(
        Urls.getPharmaOrderHistoryUrl + deliveryStatus,
      );
      if (response.first >= 200 && response.first < 300) {
        getOrderHistoryModel = GetOrderHistoryModel.fromJson(response.last);
        status = PharmaOrderHistoryStatus.loaded;
        notifyListeners();
      } else {
        status = PharmaOrderHistoryStatus.error;
      }
    } catch (e) {
      status = PharmaOrderHistoryStatus.error;
      debugPrint('Get Review Error: $e');
    } finally {
      notifyListeners();
    }
  }

  // -------------  LIST ORDER HISTORY FN END  --------- //

  // -------------  LIST ORDER HISTORY FN STARTS  --------- //

  GetOrderHistoryDeatilsModel getOrderHistoryDeatilsModel =
      GetOrderHistoryDeatilsModel();
  PharmaOrderDetailsHistoryStatus orderHistoryDetailsStatus =
      PharmaOrderDetailsHistoryStatus.loading;

  Future<void> getPharmaOrderHistoryDetailsFn({
    required String sizeId,
    required String bookingId,
  }) async {
    try {
      getOrderHistoryDeatilsModel = GetOrderHistoryDeatilsModel();
      orderHistoryDetailsStatus = PharmaOrderDetailsHistoryStatus.loading;

      final body = {
        "sizeId": sizeId,
        "bookingId": bookingId,
      };
      List response = await ServerClient.post(
        Urls.getPharmaOrderDetailsHistoryUrl,
        data: body,
      );
      if (response.first >= 200 && response.first < 300) {
        getOrderHistoryDeatilsModel =
            GetOrderHistoryDeatilsModel.fromJson(response.last);
        orderHistoryDetailsStatus = PharmaOrderDetailsHistoryStatus.loaded;
        notifyListeners();
      } else {
        orderHistoryDetailsStatus = PharmaOrderDetailsHistoryStatus.error;
      }
    } catch (e) {
      orderHistoryDetailsStatus = PharmaOrderDetailsHistoryStatus.error;
      debugPrint('Get Review Error: $e');
    } finally {
      notifyListeners();
    }
  }

  // -------------  LIST ORDER HISTORY FN END  --------- //

  String formatDateTime(DateTime dateTime) {
    String ordinalDaySuffix(int day) {
      if (day >= 11 && day <= 13) {
        return 'th';
      }
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    String formattedDate = DateFormat("MMM d").format(dateTime);
    String dayWithSuffix = formattedDate.replaceFirst(
        RegExp(r'\d+'), '${dateTime.day}${ordinalDaySuffix(dateTime.day)}');
    String restOfDateTime = DateFormat("EEE, yyyy, hh:mm a").format(dateTime);

    return "$dayWithSuffix $restOfDateTime";
  }
}

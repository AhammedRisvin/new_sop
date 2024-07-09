// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/backend/pharmacy/urls.dart';
import 'package:sophwe_newmodule/app/backend/server_client_services.dart';
import 'package:sophwe_newmodule/app/helpers/loading_overlay.dart';
import 'package:sophwe_newmodule/app/modules/widgets/common_widgets.dart';
import 'package:sophwe_newmodule/app/modules/widgets/confimration_widget.dart';
import 'package:sophwe_newmodule/app/utils/app_constants.dart';

import '../../order history/view_model/order_history_provider.dart';

class PharmaOrderCancelProvider extends ChangeNotifier {
  List<String> cancellationReasons = [
    "Order Created by Mistake",
    "Item Would Not Arrived on Time",
    "Shipping Cost Too High",
    "Item Price Too High",
    "Found Cheaper Somewhere Else",
    "No Longer Needed",
    "Ordered Wrong Item",
    "Need to Change Shipping Address",
    "Need to Change Payment Method",
    "Other",
  ];

  String selectedReason = "";

  void setSelectedReason(String reason) {
    selectedReason = reason;
    notifyListeners();
  }

  // ------ RETURN PAYMENT FN START ----- //

  int selectedReturnMethodIndex = -1;

  void updateSelectedReturnMethodIndex(int index) {
    selectedReturnMethodIndex = index;
    notifyListeners();
  }

  // --------- CANCEL PRODUCT FN START ----- //

  Future<void> cancelProductFn({
    required String sizeId,
    required String productId,
    required String bookingId,
    required BuildContext ctx,
    required bool isFromWallet,
    required String fullName,
    required String accountNumber,
    required String iban,
    required String bankName,
    required Null Function() clear,
  }) async {
    try {
      LoadingOverlay.of(ctx).show();
      final body = isFromWallet
          ? {
              "bookingId": bookingId,
              "reason": selectedReason,
              "productId": productId,
              "sizeId": sizeId
            }
          : {
              "bookingId": bookingId,
              "reason": selectedReason,
              "productId": productId,
              "sizeId": sizeId,
              "fullName": fullName,
              "accountNumber": accountNumber,
              "iban": iban,
              "bankName": bankName,
            };
      List response = await ServerClient.post(
        Urls.getPharmaOrderCancelUrl + isFromWallet.toString(),
        data: body,
        post: true,
      );
      if (response.first >= 200 && response.first < 300) {
        selectedReason = "";
        selectedReturnMethodIndex = -1;
        clear();
        ctx
            .read<OrderHistoryProvider>()
            .getPharmaOrderHistoryFn(deliveryStatus: "?status=Cancelled");
        LoadingOverlay.of(ctx).hide();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(const Duration(milliseconds: 100), () {
            _showSuccessDialog(ctx, isFromWallet);
          });
        });
      } else {
        LoadingOverlay.of(ctx).hide();
        toast(
          ctx,
          title: response.last,
          backgroundColor: AppConstants.red,
        );
      }
    } catch (e) {
      debugPrint("Error in cancelProductFn: $e");

      LoadingOverlay.of(ctx).hide();
      toast(
        ctx,
        title: "An error occurred. Please try again.",
        backgroundColor: AppConstants.red,
      );
    } finally {
      LoadingOverlay.of(ctx).hide();
      notifyListeners();
    }
  }

  // --------- CANCEL PRODUCT FN END ----- //
  void _showSuccessDialog(BuildContext ctx, bool isFromWallet) {
    showDialog(
      context: ctx,
      builder: (context) {
        return ConfirmationWidget(
          title: "Item Cancelled",
          message: isFromWallet
              ? "Your item has been successfully cancelled"
              : "Your item has been successfully cancelled and your refund will be processed within 7 working days.",
          buttonText: "Ok",
          onTap: () {
            context.pop();
            context.pop();
            context.pop();
            context.pop();
          },
          onCancel: () {
            context.pop();
            context.pop();
            context.pop();
            context.pop();
          },
          isDarkModeOn: false,
        );
      },
    );
  }

  // ------ RETURN PAYMENT FN Start ----- //

  Future<void> returnProductFn({
    required String sizeId,
    required String productId,
    required String bookingId,
    required BuildContext ctx,
    required bool isFromWallet,
    required String fullName,
    required String accountNumber,
    required String iban,
    required String bankName,
    required Null Function() clear,
  }) async {
    try {
      LoadingOverlay.of(ctx).show();
      final body = isFromWallet
          ? {
              "bookingId": bookingId,
              "reason": selectedReason,
              "productId": productId,
              "sizeId": sizeId
            }
          : {
              "bookingId": bookingId,
              "reason": selectedReason,
              "productId": productId,
              "sizeId": sizeId,
              "fullName": fullName,
              "accountNumber": accountNumber,
              "iban": iban,
              "bankName": bankName,
            };
      List response = await ServerClient.post(
        Urls.getPharmaOrderReturnUrl + isFromWallet.toString(),
        data: body,
        post: true,
      );
      if (response.first >= 200 && response.first < 300) {
        selectedReason = "";
        selectedReturnMethodIndex = -1;
        clear();
        ctx
            .read<OrderHistoryProvider>()
            .getPharmaOrderHistoryFn(deliveryStatus: "?status=Returned");
        LoadingOverlay.of(ctx).hide();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(const Duration(milliseconds: 100), () {
            _showSuccessDialog(ctx, isFromWallet);
          });
        });
      } else {
        toast(
          ctx,
          title: response.last,
          backgroundColor: AppConstants.red,
        );
      }
    } catch (e) {
      debugPrint("Error in cancelProductFn: $e");
      toast(
        ctx,
        title: "An error occurred. Please try again.",
        backgroundColor: AppConstants.red,
      );
    } finally {
      LoadingOverlay.of(ctx).hide();
      notifyListeners();
    }
  }
  // ------ RETURN PAYMENT FN end ----- //
}

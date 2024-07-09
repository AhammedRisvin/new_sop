// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sophwe_newmodule/app/backend/loyalty/loyalty_url.dart';
import 'package:sophwe_newmodule/app/helpers/loading_overlay.dart';

import '../../../backend/server_client_services.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/enums.dart';
import '../../widgets/common_widgets.dart';
import '../model/get_loyalty_history.dart';
import '../model/get_loyalty_model.dart';

class LoyaltyProvider extends ChangeNotifier {
  List<String> numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];

  Selection _currentSelection = Selection.bronze;

  Selection get currentSelection => _currentSelection;

  void updateSelection(Selection selection) {
    _currentSelection = selection;
    notifyListeners();
  }

  bool isClaimedSelected = true;

  void selectClaimed() {
    isClaimedSelected = true;
    notifyListeners();
  }

  void selectEarn() {
    isClaimedSelected = false;
    notifyListeners();
  }

  Color getProgressIndicatorColor(String tier) {
    switch (tier) {
      case "bronze":
        return AppConstants.bronzeProgressIndicator;
      case "gold":
        return AppConstants.loyaltyGold;
      case "platinum":
        return AppConstants.loyaltyPlatinum;
      case "diamond":
        return AppConstants.loyaltyDiamond;
      default:
        return AppConstants.transparent;
    }
  }

  Widget buildTierText(String tier, bool isHighlighted) {
    return Padding(
      padding: EdgeInsets.only(
          left: tier == "Bronze" ? 8.0 : 0, right: tier == "Diamond" ? 8.0 : 0),
      child: CommonTextWidget(
        align: TextAlign.start,
        color: isHighlighted ? AppConstants.black : AppConstants.black40,
        text: tier,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget buildExpandedWidget(
    String imagePath,
    String title,
    bool isDarkModeOn,
    double height,
    Selection selection,
    List<String> benefits,
    num minPointsToUpgrade,
    String tierId,
  ) {
    bool isSelected = currentSelection == selection;
    Color backgroundColor =
        isSelected ? AppConstants.onTapColor : AppConstants.unTapColor;
    return CommonInkwell(
      onTap: () {
        updateSelection(
          selection,
        );
        updateTierDetails(
          benefits,
          minPointsToUpgrade,
          tierId,
        );
      },
      child: Column(
        children: [
          const SizeBoxH(10),
          CircleAvatar(
            radius: 30,
            backgroundColor: backgroundColor,
            child: Image.asset(
              imagePath,
              height: height,
            ),
          ),
          const SizeBoxH(5),
          CommonTextWidget(
            align: TextAlign.start,
            color: isDarkModeOn ? AppConstants.white : AppConstants.white,
            text: title,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  double getProgressValue(CurrentTierDetails? data) {
    switch (data?.name?.toLowerCase()) {
      case 'gold':
        return 0.4;
      case 'platinum':
        return 0.7;
      case 'diamond':
        return 1.0;
      default:
        return 0.25;
    }
  }

  List<String>? benefits = [];
  num minPointsToUpgradeToNextTier = 0;
  String selectedTierId = "";

  void updateTierDetails(List<String>? benefits, num points, String tierId) {
    this.benefits = benefits;
    minPointsToUpgradeToNextTier = points;
    selectedTierId = tierId;
    notifyListeners();
  }

  num convertedAmount = 0;

  void convertLoyaltyPoints({
    required String value,
    required num conversionRate,
    required num conversionLoyaltyPoints,
  }) {
    double pointsToClaim = value.isEmpty ? 0.0 : double.tryParse(value) ?? 0.0;
    convertedAmount =
        (pointsToClaim / conversionLoyaltyPoints) * conversionRate;
    notifyListeners();
  }

  //  ------------  API INTEGRATION START ------------ //

  //  ------------  GET LOYALTY API START ------------------ //
  GetLoyaltyStatus getLoyaltyStatus = GetLoyaltyStatus.initial;

  GetLoyaltyModel getLoyaltyModel = GetLoyaltyModel();

  Future<void> getLoyaltyDetailsFn() async {
    try {
      getLoyaltyStatus = GetLoyaltyStatus.loading;
      List response = await ServerClient.get(
        LoyaltyUrl.getLoyaltyUrl,
      );
      if (response.first >= 200 && response.first < 300) {
        getLoyaltyModel = GetLoyaltyModel.fromJson(response.last);
        updateTierDetails(
          getLoyaltyModel.tiers?[0].benefites,
          getLoyaltyModel.tiers?[0].minLoyalityPointForClaim ?? 0,
          getLoyaltyModel.tiers?[0].id ?? "",
        );
        getLoyaltyStatus = GetLoyaltyStatus.loaded;
        notifyListeners();
      } else {
        getLoyaltyStatus = GetLoyaltyStatus.error;
        getLoyaltyModel = GetLoyaltyModel();
        notifyListeners();
      }
    } catch (e) {
      getLoyaltyStatus = GetLoyaltyStatus.error;
      getLoyaltyModel = GetLoyaltyModel();
    } finally {
      log("getLoyaltyStatus $getLoyaltyStatus");
      notifyListeners();
    }
  }

  //  ------------  GET LOYALTY API END   ------------------ //

  //  ------------  UPGRADE TIER API START ------------------ //
  Future<void> upgradeTierFn({
    required BuildContext context,
  }) async {
    LoadingOverlay.of(context).show();
    try {
      var params = {
        "tierId": selectedTierId,
      };
      List response = await ServerClient.post(
        LoyaltyUrl.upgradeTierUrl,
        data: params,
      );
      if (response.first >= 200 && response.first < 300) {
        getLoyaltyDetailsFn();
        context.pop();
      } else {
        toast(
          context,
          title: "Something went wrong",
          backgroundColor: AppConstants.red,
        );
      }
    } catch (e) {
      toast(
        context,
        title: "Server error, please try again later",
        backgroundColor: AppConstants.red,
      );
      debugPrint("Error in upgradeTierFn: $e");
    } finally {
      LoadingOverlay.of(context).hide();
      notifyListeners();
    }
  }

  //  ------------  UPGRADE TIER API END   ------------------ //

  //  ------------  CLAIM LOYALTY POINTS API START ------------------ //

  Future<void> claimLoyaltyPointsFn({
    required BuildContext context,
    required String points,
    required num minimumPoints,
    required String tierId,
    required Function() clear,
    required num userTotalPoints,
  }) async {
    LoadingOverlay.of(context).show();
    try {
      num claimedPoints = points.isEmpty ? 0.00 : int.tryParse(points) ?? 0;
      if (claimedPoints < minimumPoints) {
        LoadingOverlay.of(context).hide();
        Future.delayed(const Duration(milliseconds: 100), () {
          toast(
            context,
            title: "Minimum points to claim is $minimumPoints",
            backgroundColor: AppConstants.red,
          );
          clear();
          convertedAmount = 0;
        });
        return;
      }

      if (claimedPoints > userTotalPoints) {
        LoadingOverlay.of(context).hide();
        Future.delayed(const Duration(milliseconds: 100), () {
          toast(
            context,
            title: "Not enough points to claim",
            backgroundColor: AppConstants.red,
          );
          clear();
          convertedAmount = 0;
        });
        return;
      }

      var params = {
        "tierId": tierId,
        "point": points,
      };
      List response = await ServerClient.post(
        LoyaltyUrl.claimLoyaltyPointsUrl,
        data: params,
      );
      if (response.first >= 200 && response.first < 300) {
        clear();
        getLoyaltyDetailsFn();
        convertedAmount = 0;
        context.pop();
        toast(
          context,
          title: "Points claimed successfully",
          backgroundColor: AppConstants.stepperGreen,
        );
      } else {
        toast(
          context,
          title: "Something went wrong",
          backgroundColor: AppConstants.red,
        );
      }
    } catch (e) {
      toast(
        context,
        title: "Server error, please try again later",
        backgroundColor: AppConstants.red,
      );
      debugPrint("Error in claimLoyaltyPointsFn: $e");
    } finally {
      LoadingOverlay.of(context).hide();

      notifyListeners();
    }
  }

  //  ------------  CLAIM LOYALTY POINTS API END   ------------------ //``

  //  ------------  SHOW CLAIMED POINTS API START ------------------ //

  GetLoyaltyHistoryStatus getLoyaltyHistoryStatus =
      GetLoyaltyHistoryStatus.initial;
  GetLoyaltyHistoryModel getLoyaltyHistoryModel = GetLoyaltyHistoryModel();

  Future<void> getLoyaltyHistoryFn({
    required String filter,
  }) async {
    try {
      getLoyaltyHistoryStatus = GetLoyaltyHistoryStatus.loading;
      List response = await ServerClient.get(
        LoyaltyUrl.getLoyaltyHistoryUrl + filter,
      );
      if (response.first >= 200 && response.first < 300) {
        getLoyaltyHistoryModel = GetLoyaltyHistoryModel.fromJson(response.last);
        getLoyaltyHistoryStatus = GetLoyaltyHistoryStatus.success;
        notifyListeners();
      } else {
        getLoyaltyHistoryStatus = GetLoyaltyHistoryStatus.error;
        getLoyaltyHistoryModel = GetLoyaltyHistoryModel();
      }
    } catch (e) {
      getLoyaltyHistoryModel = GetLoyaltyHistoryModel();
      debugPrint("Error in getLoyaltyHistoryFn: $e");
    } finally {
      notifyListeners();
    }
  }

  //  ------------  SHOW CLAIMED POINTS API END   ------------------ //

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
}

enum Selection { bronze, gold, platinum, diamond, history }

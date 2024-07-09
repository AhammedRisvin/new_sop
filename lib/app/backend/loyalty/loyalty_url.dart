import '../../env.dart';

class LoyaltyUrl {
  static String baseUrl = Environments.baseUrl;

  static String getLoyaltyUrl = "${baseUrl}sophwe-user/get-loyality-tiers";
  static String upgradeTierUrl = "${baseUrl}sophwe-user/upgrade-tier";
  static String claimLoyaltyPointsUrl = "${baseUrl}sophwe-user/claim-loyality";
  static String getLoyaltyHistoryUrl =
      "${baseUrl}sophwe-user/get-loyality-history?filter=";
}

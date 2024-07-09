import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/app_router.dart';
import 'package:sophwe_newmodule/app/helpers/extentions.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/modules/loyalty/view%20model/loyalty_provider.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/home%20screen/view%20model/theme_provider.dart';
import 'package:sophwe_newmodule/app/modules/widgets/empty_screen.dart';
import 'package:sophwe_newmodule/app/utils/app_constants.dart';
import 'package:sophwe_newmodule/app/utils/app_images.dart';
import 'package:sophwe_newmodule/app/utils/enums.dart';
import 'package:sophwe_newmodule/app/utils/prefferences.dart';

import '../../widgets/common_widgets.dart';
import '../widget/benefits_showing_container.dart';
import '../widget/history_showing_widget.dart';
import '../widget/tier_benefits_showing_widget.dart';

class LoyaltyHomeScreen extends StatefulWidget {
  const LoyaltyHomeScreen({super.key});

  @override
  State<LoyaltyHomeScreen> createState() => _LoyaltyHomeScreenState();
}

LoyaltyProvider? provider;

class _LoyaltyHomeScreenState extends State<LoyaltyHomeScreen> {
  bool isSignedIn = false;
  @override
  void initState() {
    provider = Provider.of<LoyaltyProvider>(context, listen: false);
    super.initState();
    isSignedIn = AppPref.isSignedIn;
    if (isSignedIn) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        provider?.getLoyaltyDetailsFn();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, child) {
        return !isSignedIn
            ? Scaffold(
                body: EmptyScreenWidget(
                  text: "Please login to access the personalized data",
                  image: AppImages.reminderEmpty,
                  height: Responsive.height * 100,
                  isFromServerError: true,
                  ontap: () {
                    context.pushReplacementNamed(AppRouter.login);
                  },
                ),
              )
            : Scaffold(
                backgroundColor:
                    isDarkModeOn ? AppConstants.black : AppConstants.white,
                appBar: AppBar(
                  backgroundColor: isDarkModeOn
                      ? AppConstants.darkBlue
                      : AppConstants.darkBlue,
                  title: CommonTextWidget(
                    align: TextAlign.start,
                    color:
                        isDarkModeOn ? AppConstants.white : AppConstants.white,
                    text: "My Benefits",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  automaticallyImplyLeading: false,
                ),
                body: Consumer<LoyaltyProvider>(
                  builder: (context, provider, child) {
                    return provider.getLoyaltyStatus == GetLoyaltyStatus.loading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppConstants.commonGold,
                            ),
                          )
                        : provider.getLoyaltyStatus == GetLoyaltyStatus.loaded
                            ? SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      width: Responsive.width * 100,
                                      color: isDarkModeOn
                                          ? AppConstants.darkBlue
                                          : AppConstants.darkBlue,
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          BenefitsShowingContainer(
                                            isDarkModeOn: isDarkModeOn,
                                            data: provider.getLoyaltyModel
                                                .currentTierDetails,
                                            provider: provider,
                                          ),
                                          const SizeBoxH(10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: List.generate(
                                                    (provider
                                                                .getLoyaltyModel
                                                                .tiers
                                                                ?.length ??
                                                            0) +
                                                        1,
                                                    (index) {
                                                      if (index < 4) {
                                                        final data = provider
                                                            .getLoyaltyModel
                                                            .tiers?[index];
                                                        return provider
                                                            .buildExpandedWidget(
                                                          "assets/icons/tierIcon.png",
                                                          data?.name
                                                                  ?.capitalizeFirstLetter() ??
                                                              "",
                                                          isDarkModeOn,
                                                          60,
                                                          [
                                                            Selection.bronze,
                                                            Selection.gold,
                                                            Selection.platinum,
                                                            Selection.diamond
                                                          ][index],
                                                          data?.benefites ?? [],
                                                          data?.minLoyalityPointsForUpgrade ??
                                                              0,
                                                          data?.id ?? "",
                                                        );
                                                      } else {
                                                        return provider
                                                            .buildExpandedWidget(
                                                          "assets/icons/historyIcon.png",
                                                          "History",
                                                          isDarkModeOn,
                                                          30,
                                                          Selection.history,
                                                          [],
                                                          0,
                                                          "",
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Consumer<LoyaltyProvider>(
                                      builder: (context, provider, child) {
                                        Widget tierWidget;
                                        switch (provider.currentSelection) {
                                          case Selection.gold:
                                            tierWidget =
                                                TierDetailsShowingWidget(
                                              isDarkModeOn: isDarkModeOn,
                                              provider: provider,
                                              title: "Gold",
                                              color: AppConstants.loyaltyGold,
                                              color40:
                                                  AppConstants.loyaltyGold40,
                                              benefits: "",
                                              numColor:
                                                  AppConstants.loyaltyGold,
                                              currentTierData: provider
                                                  .getLoyaltyModel
                                                  .currentTierDetails,
                                            );
                                            break;
                                          case Selection.platinum:
                                            tierWidget =
                                                TierDetailsShowingWidget(
                                              isDarkModeOn: isDarkModeOn,
                                              provider: provider,
                                              title: "Platinum",
                                              color:
                                                  AppConstants.loyaltyPlatinum,
                                              color40: AppConstants
                                                  .loyaltyPlatinum40,
                                              benefits: "",
                                              numColor:
                                                  AppConstants.loyaltyPlatinum,
                                              currentTierData: provider
                                                  .getLoyaltyModel
                                                  .currentTierDetails,
                                            );
                                            break;
                                          case Selection.diamond:
                                            tierWidget =
                                                TierDetailsShowingWidget(
                                              isDarkModeOn: isDarkModeOn,
                                              provider: provider,
                                              title: "Diamond",
                                              color:
                                                  AppConstants.loyaltyDiamond,
                                              color40:
                                                  AppConstants.loyaltyDiamond40,
                                              benefits: "",
                                              numColor:
                                                  AppConstants.loyaltyDiamond,
                                              currentTierData: provider
                                                  .getLoyaltyModel
                                                  .currentTierDetails,
                                            );
                                            break;
                                          case Selection.history:
                                            tierWidget = HistoryShowingWidget(
                                              isDarkModeOn: isDarkModeOn,
                                            );
                                            break;
                                          default:
                                            tierWidget =
                                                TierDetailsShowingWidget(
                                              isDarkModeOn: isDarkModeOn,
                                              provider: provider,
                                              title: "Bronze",
                                              color: AppConstants.loyaltyBronze,
                                              color40:
                                                  AppConstants.loyaltyBronze40,
                                              benefits: "",
                                              currentTierData: provider
                                                  .getLoyaltyModel
                                                  .currentTierDetails,
                                            );
                                            break;
                                        }
                                        return tierWidget;
                                      },
                                    ),
                                  ],
                                ),
                              )
                            : EmptyScreenWidget(
                                text: "Server Busy, please try again later.",
                                image: AppImages.reminderEmpty,
                                height: Responsive.height * 100,
                                isFromServerError: true,
                                ontap: () {
                                  provider.getLoyaltyDetailsFn();
                                },
                              );
                  },
                ),
              );
      },
    );
  }
}

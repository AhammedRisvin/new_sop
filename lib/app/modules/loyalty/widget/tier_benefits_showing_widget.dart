import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sophwe_newmodule/app/modules/loyalty/model/get_loyalty_model.dart';

import '../../../helpers/extentions.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/confimration_widget.dart';
import '../view model/loyalty_provider.dart';

class TierDetailsShowingWidget extends StatelessWidget {
  const TierDetailsShowingWidget({
    super.key,
    required this.isDarkModeOn,
    required this.provider,
    required this.title,
    required this.color,
    required this.benefits,
    required this.color40,
    this.numColor = AppConstants.loyaltyBronze,
    this.currentTierData,
  });

  final bool isDarkModeOn;
  final LoyaltyProvider provider;
  final String title;
  final Color color;
  final String benefits;
  final Color color40;
  final Color numColor;
  final CurrentTierDetails? currentTierData;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppConstants.darkBlue,
      child: Container(
        width: Responsive.width * 100,
        decoration: BoxDecoration(
          color: isDarkModeOn ? AppConstants.black : Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: Responsive.width * 50,
              height: Responsive.height * 5,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: color,
              ),
              child: Center(
                child: CommonTextWidget(
                  align: TextAlign.start,
                  color: isDarkModeOn ? AppConstants.white : AppConstants.white,
                  text: title,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizeBoxH(10),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final num = provider.numbers[index];
                final benefits = provider.benefits?[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: color40,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Center(
                            child: CommonTextWidget(
                              align: TextAlign.start,
                              color: numColor,
                              text: num,
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      const SizeBoxV(10),
                      Expanded(
                        child: CommonTextWidget(
                          align: TextAlign.start,
                          color: isDarkModeOn
                              ? AppConstants.white
                              : AppConstants.black,
                          text: benefits ?? "",
                          fontSize: 12,
                          maxLines: 4,
                          overFlow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizeBoxH(15),
              itemCount: provider.benefits?.length ?? 0,
            ),
            const SizeBoxH(30),
            if (currentTierData?.name?.toLowerCase() !=
                    provider.currentSelection.name &&
                currentTierData?.name?.toLowerCase() == "bronze" &&
                (currentTierData?.currentPoints ?? 0) >=
                    provider.minPointsToUpgradeToNextTier) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CommonButton(
                  ontap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          content: Container(
                            height: Responsive.height * 23,
                            width: Responsive.width * 100,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isDarkModeOn
                                  ? AppConstants.black
                                  : AppConstants.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonTextWidget(
                                  align: TextAlign.start,
                                  text:
                                      "Are you sure you want to upgrade your tier from Bronze to Gold",
                                  color: isDarkModeOn
                                      ? AppConstants.white
                                      : AppConstants.black,
                                  fontSize: 18,
                                  letterSpacing: -0.5,
                                  fontWeight: FontWeight.w600,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      AppImages.coinIcon,
                                      height: 26,
                                    ),
                                    const SizeBoxV(10),
                                    CommonTextWidget(
                                      align: TextAlign.start,
                                      color: isDarkModeOn
                                          ? AppConstants.black
                                          : AppConstants.black,
                                      text: provider
                                          .minPointsToUpgradeToNextTier
                                          .toString(),
                                      fontSize: 16,
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: AlertDialogButtonWidget(
                                        onTap: () {
                                          context.pop();
                                        },
                                        text: "No",
                                        buttonBgColor: AppConstants.white,
                                        buttonBorderColor:
                                            AppConstants.darkBlue,
                                        textColor: AppConstants.darkBlue,
                                        isDarkModeOn: isDarkModeOn,
                                      ),
                                    ),
                                    Expanded(
                                      child: AlertDialogButtonWidget(
                                        onTap: () {
                                          provider.upgradeTierFn(
                                            context: context,
                                          );
                                        },
                                        text: "Yes",
                                        buttonBgColor: AppConstants.darkBlue,
                                        buttonBorderColor:
                                            AppConstants.darkBlue,
                                        textColor: AppConstants.white,
                                        isDarkModeOn: isDarkModeOn,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  height: Responsive.height * 6,
                  text: "Upgrade Tier",
                  isDarkMode: isDarkModeOn,
                ),
              ),
            ],
            const SizeBoxH(40),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/modules/loyalty/model/get_loyalty_model.dart';
import 'package:sophwe_newmodule/app/modules/loyalty/view%20model/loyalty_provider.dart';

import '../../../helpers/extentions.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../widgets/common_widgets.dart';

class BenefitsShowingContainer extends StatefulWidget {
  const BenefitsShowingContainer({
    super.key,
    required this.isDarkModeOn,
    this.data,
    required this.provider,
  });

  final bool isDarkModeOn;
  final CurrentTierDetails? data;
  final LoyaltyProvider provider;

  @override
  State<BenefitsShowingContainer> createState() =>
      _BenefitsShowingContainerState();
}

class _BenefitsShowingContainerState extends State<BenefitsShowingContainer> {
  final TextEditingController _claimLoyaltyPointsController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: Responsive.height * 26,
          width: Responsive.width * 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: widget.isDarkModeOn
                ? AppConstants.transparent
                : AppConstants.transparent,
            image: const DecorationImage(
              image: AssetImage(
                AppImages.loyaltyTierContainer,
              ),
              fit: BoxFit.fill,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CommonTextWidget(
                align: TextAlign.start,
                color: widget.isDarkModeOn
                    ? AppConstants.black
                    : AppConstants.black,
                text: widget.data?.name ?? "",
                fontSize: 24,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w900,
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
                    color: widget.isDarkModeOn
                        ? AppConstants.black
                        : AppConstants.black,
                    text: widget.data?.currentPoints.toString() ?? "",
                    fontSize: 16,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              if ((widget.data?.currentPoints ?? 0) >
                  (widget.data?.minLoyalityPointForClaim ?? 0)) ...[
                Row(
                  children: [
                    CommonInkwell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: SingleChildScrollView(
                                child: Consumer<LoyaltyProvider>(
                                  builder: (context, provider, child) =>
                                      Container(
                                    width: Responsive.width * 100,
                                    height: Responsive.height * 30,
                                    decoration: BoxDecoration(
                                      color: widget.isDarkModeOn
                                          ? AppConstants.black
                                          : AppConstants.white,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CommonTextWidget(
                                          align: TextAlign.start,
                                          color: widget.isDarkModeOn
                                              ? AppConstants.white
                                              : AppConstants.black,
                                          text: "Claim",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        const SizeBoxH(20),
                                        CommonTextWidget(
                                          align: TextAlign.start,
                                          color: widget.isDarkModeOn
                                              ? AppConstants.white
                                              : AppConstants.black,
                                          text: "Enter Loyalty Points",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        const SizeBoxH(5),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CommonTextFormField(
                                                bgColor:
                                                    AppConstants.transparent,
                                                hintText:
                                                    "Enter Loyalty Points",
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.done,
                                                controller:
                                                    _claimLoyaltyPointsController,
                                                prefixIcon: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Image.asset(
                                                    AppImages.coinIcon,
                                                    height: 20,
                                                  ),
                                                ),
                                                onChanged: (p0) {
                                                  provider.convertLoyaltyPoints(
                                                    value: p0,
                                                    conversionRate: widget
                                                            .data
                                                            ?.loyalityPointsAndPrice
                                                            ?.price ??
                                                        0,
                                                    conversionLoyaltyPoints: widget
                                                            .data
                                                            ?.loyalityPointsAndPrice
                                                            ?.loyalityPoints ??
                                                        0,
                                                  );
                                                },
                                              ),
                                            ),
                                            const SizeBoxV(10),
                                            if (provider.convertedAmount >
                                                0) ...[
                                              CommonTextWidget(
                                                align: TextAlign.start,
                                                color: widget.isDarkModeOn
                                                    ? AppConstants.white
                                                    : AppConstants.black,
                                                text:
                                                    "${provider.convertedAmount.toStringAsFixed(2)} ${widget.data?.loyalityPointsAndPrice?.currency}",
                                                fontSize: 16,
                                                letterSpacing: 1.5,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ]
                                          ],
                                        ),
                                        const SizeBoxH(20),
                                        CommonButton(
                                          ontap: () {
                                            provider.claimLoyaltyPointsFn(
                                                context: context,
                                                userTotalPoints: widget
                                                        .data?.currentPoints ??
                                                    0,
                                                minimumPoints: widget.data
                                                        ?.minLoyalityPointForClaim ??
                                                    0,
                                                points:
                                                    _claimLoyaltyPointsController
                                                        .text,
                                                tierId:
                                                    widget.data?.tierId ?? "",
                                                clear: () {
                                                  _claimLoyaltyPointsController
                                                      .clear();
                                                });
                                          },
                                          height: Responsive.height * 6,
                                          text: "Claim",
                                          isDarkMode: widget.isDarkModeOn,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 30,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppConstants.commonGold,
                        ),
                        child: Center(
                          child: CommonTextWidget(
                            align: TextAlign.start,
                            color: widget.isDarkModeOn
                                ? AppConstants.black
                                : AppConstants.black,
                            text: "Claim",
                            fontSize: 12,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 6,
                          backgroundColor: widget.isDarkModeOn
                              ? AppConstants.commonGold
                              : AppConstants.darkBlue,
                        ),
                        const SizeBoxV(5),
                        CommonTextWidget(
                          align: TextAlign.start,
                          color: widget.isDarkModeOn
                              ? AppConstants.black
                              : AppConstants.black,
                          text:
                              "${widget.data?.loyalityPointsAndPrice?.loyalityPoints} loyalty points = ${widget.data?.loyalityPointsAndPrice?.price} ${widget.data?.loyalityPointsAndPrice?.currency}",
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  const SizeBoxV(5),
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 6,
                          backgroundColor: widget.isDarkModeOn
                              ? AppConstants.commonGold
                              : AppConstants.darkBlue,
                        ),
                        const SizeBoxV(5),
                        CommonTextWidget(
                          align: TextAlign.start,
                          color: widget.isDarkModeOn
                              ? AppConstants.black
                              : AppConstants.black,
                          maxLines: 2,
                          overFlow: TextOverflow.ellipsis,
                          text:
                              "Minimum ${widget.data?.minLoyalityPointForClaim} to claim",
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.provider.buildTierText(
                      "Bronze", widget.data?.name?.toLowerCase() == "bronze"),
                  widget.provider.buildTierText(
                      "Gold", widget.data?.name?.toLowerCase() == "gold"),
                  widget.provider.buildTierText("Platinum",
                      widget.data?.name?.toLowerCase() == "platinum"),
                  widget.provider.buildTierText(
                      "Diamond", widget.data?.name?.toLowerCase() == "diamond"),
                ],
              ),
              LinearProgressIndicator(
                value: widget.provider.getProgressValue(widget.data),
                minHeight: 12,
                borderRadius: BorderRadius.circular(10),
                backgroundColor: AppConstants.white,
                valueColor: AlwaysStoppedAnimation<Color>(
                  widget.provider.getProgressIndicatorColor(
                    widget.data?.name?.toLowerCase() ?? "",
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Transform.scale(
            scale: Responsive.height * 0.16,
            child: Image.asset(
              "assets/icons/tierIcon.png",
              height: Responsive.height * 16,
            ),
          ),
        )
      ],
    );
  }
}

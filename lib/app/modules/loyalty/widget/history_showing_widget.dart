import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/modules/widgets/empty_screen.dart';
import 'package:sophwe_newmodule/app/utils/enums.dart';

import '../../../helpers/extentions.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../widgets/common_widgets.dart';
import '../view model/loyalty_provider.dart';

class HistoryShowingWidget extends StatefulWidget {
  const HistoryShowingWidget({
    super.key,
    required this.isDarkModeOn,
  });

  final bool isDarkModeOn;

  @override
  State<HistoryShowingWidget> createState() => _HistoryShowingWidgetState();
}

LoyaltyProvider? loyaltyProvider;

class _HistoryShowingWidgetState extends State<HistoryShowingWidget> {
  @override
  void initState() {
    loyaltyProvider = context.read<LoyaltyProvider>();
    loyaltyProvider?.isClaimedSelected = true;
    loyaltyProvider?.getLoyaltyHistoryFn(
      filter: "claimed",
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoyaltyProvider>(
      builder: (context, provider, child) => Container(
        width: Responsive.width * 100,
        decoration: BoxDecoration(
          color: widget.isDarkModeOn ? AppConstants.black : Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 15,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: AppConstants.black10,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CommonInkwell(
                        onTap: () {
                          provider.selectClaimed();
                          provider.getLoyaltyHistoryFn(
                            filter: "claimed",
                          );
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: provider.isClaimedSelected
                                ? widget.isDarkModeOn
                                    ? AppConstants.commonGold
                                    : AppConstants.darkBlue
                                : widget.isDarkModeOn
                                    ? AppConstants.black
                                    : AppConstants.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignment: Alignment.center,
                          child: CommonTextWidget(
                            align: TextAlign.start,
                            color: provider.isClaimedSelected
                                ? widget.isDarkModeOn
                                    ? AppConstants.black
                                    : AppConstants.white
                                : widget.isDarkModeOn
                                    ? AppConstants.white
                                    : AppConstants.black,
                            text: "Claimed",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CommonInkwell(
                        onTap: () {
                          provider.selectEarn();
                          provider.getLoyaltyHistoryFn(
                            filter: "earned",
                          );
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: provider.isClaimedSelected
                                ? widget.isDarkModeOn
                                    ? AppConstants.black
                                    : AppConstants.white
                                : widget.isDarkModeOn
                                    ? AppConstants.commonGold
                                    : AppConstants.darkBlue,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignment: Alignment.center,
                          child: CommonTextWidget(
                            align: TextAlign.start,
                            color: provider.isClaimedSelected
                                ? widget.isDarkModeOn
                                    ? AppConstants.white
                                    : AppConstants.black
                                : widget.isDarkModeOn
                                    ? AppConstants.black
                                    : AppConstants.white,
                            text: "Earn",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            provider.isClaimedSelected
                ? provider.getLoyaltyHistoryModel.history?.isEmpty == true
                    ? EmptyScreenWidget(
                        text: "No Transactions",
                        image: AppImages.loyaltyNoData,
                        height: Responsive.height * 35,
                      )
                    : provider.getLoyaltyHistoryStatus ==
                            GetLoyaltyHistoryStatus.loading
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 150),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: widget.isDarkModeOn
                                    ? AppConstants.commonGold
                                    : AppConstants.darkBlue,
                              ),
                            ),
                          )
                        : provider.getLoyaltyHistoryStatus ==
                                GetLoyaltyHistoryStatus.success
                            ? ListView.separated(
                                padding: const EdgeInsets.only(
                                  bottom: 40,
                                  right: 15,
                                  left: 15,
                                  top: 15,
                                ),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var historyData = provider
                                      .getLoyaltyHistoryModel.history?[(provider
                                              .getLoyaltyHistoryModel
                                              .history
                                              ?.length ??
                                          0) -
                                      1 -
                                      index];
                                  var currencySymbol = provider
                                          .getLoyaltyHistoryModel
                                          .currencySymbol ??
                                      '';
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: CommonTextWidget(
                                              align: TextAlign.start,
                                              color: widget.isDarkModeOn
                                                  ? AppConstants.white
                                                  : AppConstants.black,
                                              text:
                                                  "${historyData?.points} Points ${historyData?.method} Successful",
                                              fontSize: 16,
                                              maxLines: 2,
                                              overFlow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          if (historyData?.amount != null) ...[
                                            CommonTextWidget(
                                              align: TextAlign.start,
                                              color: widget.isDarkModeOn
                                                  ? AppConstants.white
                                                  : AppConstants.black,
                                              text:
                                                  "$currencySymbol ${historyData?.amount?.toStringAsFixed(2)}",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ]
                                        ],
                                      ),
                                      const SizeBoxH(10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: CommonTextWidget(
                                              align: TextAlign.start,
                                              color: const Color(0xff999999),
                                              text: provider.formatDateTime(
                                                historyData?.createdAt ??
                                                    DateTime.now(),
                                              ),
                                              fontSize: 14,
                                              maxLines: 2,
                                              overFlow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 10,
                                  ),
                                  child: Image.asset(
                                    AppImages.dottedLine,
                                  ),
                                ),
                                itemCount: provider.getLoyaltyHistoryModel
                                        .history?.length ??
                                    0,
                              )
                            : const Text("Error")
                : provider.getLoyaltyHistoryModel.history?.isEmpty == true
                    ? EmptyScreenWidget(
                        text: "No Transactions",
                        image: AppImages.loyaltyNoData,
                        height: Responsive.height * 35,
                      )
                    : provider.getLoyaltyHistoryStatus ==
                            GetLoyaltyHistoryStatus.loading
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 150.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : provider.getLoyaltyHistoryStatus ==
                                GetLoyaltyHistoryStatus.success
                            ? ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var historyData = provider
                                      .getLoyaltyHistoryModel.history?[(provider
                                              .getLoyaltyHistoryModel
                                              .history
                                              ?.length ??
                                          0) -
                                      1 -
                                      index];
                                  var currencySymbol = provider
                                          .getLoyaltyHistoryModel
                                          .currencySymbol ??
                                      '';
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                      vertical: 8,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: CommonTextWidget(
                                                align: TextAlign.start,
                                                color: widget.isDarkModeOn
                                                    ? AppConstants.white
                                                    : AppConstants.black,
                                                text:
                                                    "${historyData?.points} Points ${historyData?.method} Successful",
                                                fontSize: 16,
                                                maxLines: 2,
                                                overFlow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            if (historyData?.amount !=
                                                null) ...[
                                              CommonTextWidget(
                                                align: TextAlign.start,
                                                color: widget.isDarkModeOn
                                                    ? AppConstants.white
                                                    : AppConstants.black,
                                                text:
                                                    "$currencySymbol ${historyData?.amount?.toStringAsFixed(2)}",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ]
                                          ],
                                        ),
                                        const SizeBoxH(10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: CommonTextWidget(
                                                align: TextAlign.start,
                                                color: const Color(0xff999999),
                                                text: provider.formatDateTime(
                                                  historyData?.createdAt
                                                          ?.toLocal() ??
                                                      DateTime.now(),
                                                ),
                                                fontSize: 14,
                                                maxLines: 2,
                                                overFlow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Image.asset(
                                    AppImages.dottedLine,
                                  ),
                                ),
                                itemCount: provider.getLoyaltyHistoryModel
                                        .history?.length ??
                                    0,
                              )
                            : const Text("Error")
          ],
        ),
      ),
    );
  }
}

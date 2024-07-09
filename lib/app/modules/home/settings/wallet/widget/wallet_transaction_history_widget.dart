import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/modules/home/settings/wallet/model/get_wallet_history_model.dart';
import 'package:sophwe_newmodule/app/modules/home/settings/wallet/view%20model/wallet_provider.dart';

import '../../../../../helpers/size_box.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_images.dart';
import '../../../../widgets/common_widgets.dart';

class WalletTransactionHistoryWidget extends StatelessWidget {
  const WalletTransactionHistoryWidget({
    super.key,
    required this.isDarkModeOn,
    this.singleData,
  });

  final bool isDarkModeOn;
  final History? singleData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color:
            isDarkModeOn ? AppConstants.transparent : AppConstants.transparent,
        border: Border.all(
          color: AppConstants.black10,
        ),
      ),
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 9,
        bottom: 9,
      ),
      child: Row(
        children: [
          Image.asset(
            AppImages.walletCoinIcon,
            width: 50,
            height: 50,
          ),
          const SizeBoxV(10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonTextWidget(
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                  text: singleData?.source ?? "",
                  maxLines: 1,
                  overFlow: TextOverflow.ellipsis,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                CommonTextWidget(
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                  text: context.read<WalletProvider>().formatDateTime(
                        singleData?.createdAt?.toLocal() ?? DateTime.now(),
                      ),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                CommonTextWidget(
                  color: isDarkModeOn
                      ? AppConstants.stepperGreen
                      : AppConstants.stepperGreen,
                  text:
                      "${singleData?.amount?.toStringAsFixed(2) ?? ""} ${singleData?.currency ?? ""}",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/extentions.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/modules/home/settings/wallet/view%20model/wallet_provider.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/home%20screen/view%20model/theme_provider.dart';
import 'package:sophwe_newmodule/app/modules/widgets/empty_screen.dart';
import 'package:sophwe_newmodule/app/utils/app_images.dart';

import '../../../../../utils/app_constants.dart';
import '../../../../widgets/common_widgets.dart';
import '../widget/wallet_drop_down_widget.dart';
import '../widget/wallet_transaction_history_widget.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

WalletProvider? provider;
final walletHistoryScrollCntrlr = ScrollController();

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    provider = Provider.of<WalletProvider>(context, listen: false);
    walletHistoryScrollCntrlr.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider?.getWalletHistoryFn(
        page: 1,
      );
    });
  }

  void _onScroll() {
    if (walletHistoryScrollCntrlr.position.pixels >=
        walletHistoryScrollCntrlr.position.maxScrollExtent) {
      provider?.getWalletHistoryFn();
    }
  }

  // @override
  // void dispose() {
  //   walletHistoryScrollCntrlr.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, child) => Scaffold(
        backgroundColor: isDarkModeOn ? AppConstants.black : AppConstants.white,
        appBar: AppBar(
          backgroundColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          surfaceTintColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          title: CommonTextWidget(
            color: isDarkModeOn ? AppConstants.white : AppConstants.black,
            text: "Wallet",
            fontSize: 14,
            letterSpacing: 0.5,
            fontWeight: FontWeight.w500,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: isDarkModeOn ? AppConstants.white : AppConstants.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Consumer<WalletProvider>(
          builder: (context, provider, child) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Responsive.width * 100,
                  height: Responsive.height * 13,
                  padding: const EdgeInsets.only(left: 30),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      image: AssetImage(
                        "assets/images/walletContainerBg.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonTextWidget(
                        color: isDarkModeOn
                            ? AppConstants.white.withOpacity(0.6)
                            : AppConstants.white.withOpacity(0.6),
                        text: "Wallet Balance",
                        fontSize: 14,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w400,
                      ),
                      CommonTextWidget(
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.white,
                        text:
                            "${provider.getWalletHistoryModel.userWalletAmount?.toStringAsFixed(2)} ${provider.getWalletHistoryModel.currencyCode}",
                        fontSize: 33,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
                CommonTextWidget(
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                  text: "Transactions",
                  fontSize: 14,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w600,
                ),
                const SizeBoxH(15),
                WalletDropDownWidget(
                  isDarkModeOn: isDarkModeOn,
                ),
                const SizeBoxH(15),
                Expanded(
                  child: provider.getWalletHistoryModel.history?.isEmpty == true
                      ? EmptyScreenWidget(
                          text: "Wallet History is Empty",
                          image: AppImages.reminderEmpty,
                          height: Responsive.height * 50,
                        )
                      : ListView.separated(
                          controller: walletHistoryScrollCntrlr,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (index ==
                                    provider.getWalletHistoryModel.history
                                        ?.length &&
                                provider.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            final singleData =
                                provider.getWalletHistoryModel.history?[index];
                            return WalletTransactionHistoryWidget(
                              isDarkModeOn: isDarkModeOn,
                              singleData: singleData,
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemCount:
                              (provider.getWalletHistoryModel.history?.length ??
                                      0) +
                                  (provider.isLoading ? 1 : 0),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

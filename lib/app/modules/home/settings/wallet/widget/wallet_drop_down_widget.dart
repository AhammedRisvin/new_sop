import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/extentions.dart';
import '../../../../../helpers/size_box.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../widgets/common_widgets.dart';
import '../view model/wallet_provider.dart';

class WalletDropDownWidget extends StatelessWidget {
  const WalletDropDownWidget({
    super.key,
    required this.isDarkModeOn,
  });

  final bool isDarkModeOn;

  @override
  Widget build(BuildContext context) {
    return Selector<WalletProvider, String>(
      selector: (p0, p1) => p1.selectedOption,
      builder: (context, selectedOption, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonTextWidget(
            color: isDarkModeOn ? AppConstants.white : AppConstants.black,
            text: selectedOption,
            fontSize: 14,
            letterSpacing: 0.5,
            fontWeight: FontWeight.w500,
          ),
          CommonInkwell(
            onTap: () async {
              final RenderBox overlay =
                  Overlay.of(context).context.findRenderObject() as RenderBox;
              final RenderBox button = context.findRenderObject() as RenderBox;
              final RelativeRect position = RelativeRect.fromRect(
                Rect.fromPoints(
                  button.localToGlobal(
                    button.size.topRight(Offset(0, button.size.height)),
                    ancestor: overlay,
                  ),
                  button.localToGlobal(
                    button.size.bottomRight(Offset(0, button.size.height)),
                    ancestor: overlay,
                  ),
                ),
                Offset.zero & overlay.size,
              );

              final String? selectedItem = await showMenu<String>(
                context: context,
                position: position,
                items: [
                  PopupMenuItem<String>(
                    value: 'all',
                    child: Text(
                      'All',
                      style: TextStyle(
                        color: isDarkModeOn
                            ? AppConstants.black
                            : AppConstants.white,
                      ),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'food',
                    child: Text(
                      'Food',
                      style: TextStyle(
                        color: isDarkModeOn
                            ? AppConstants.black
                            : AppConstants.white,
                      ),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'pharmacy',
                    child: Text(
                      'Pharmacy',
                      style: TextStyle(
                        color: isDarkModeOn
                            ? AppConstants.black
                            : AppConstants.white,
                      ),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'loyalty',
                    child: Text(
                      'loyalty',
                      style: TextStyle(
                        color: isDarkModeOn
                            ? AppConstants.black
                            : AppConstants.white,
                      ),
                    ),
                  ),
                ],
                elevation: 8.0,
                color: isDarkModeOn
                    ? AppConstants.commonGold
                    : AppConstants.darkBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
              );

              if (selectedItem != null) {
                context.read<WalletProvider>().setSelectedOption(selectedItem);
                context.read<WalletProvider>().getWalletHistoryFn(
                      page: 1,
                    );
              }
            },
            child: Container(
              height: Responsive.height * 3.8,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: isDarkModeOn
                    ? AppConstants.commonGold
                    : AppConstants.darkBlue,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonTextWidget(
                    color:
                        isDarkModeOn ? AppConstants.black : AppConstants.white,
                    text: "Filter",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizeBoxV(5),
                  Icon(
                    Icons.filter_alt_outlined,
                    size: 14,
                    color:
                        isDarkModeOn ? AppConstants.black : AppConstants.white,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

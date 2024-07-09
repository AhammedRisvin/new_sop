import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/app_router.dart';
import 'package:sophwe_newmodule/app/modules/pharma/address/model/address_model.dart';
import 'package:sophwe_newmodule/app/modules/pharma/address/view_model/address_provider.dart';
import 'package:sophwe_newmodule/app/modules/widgets/confimration_widget.dart';
import 'package:sophwe_newmodule/app/utils/app_constants.dart';

import '../../../helpers/size_box.dart';
import '../../widgets/common_widgets.dart';

class AddressWidget extends StatelessWidget {
  final bool isDarkModeOn;
  final bool isAddressScreen;
  final ShippingAddress? addressData;
  final int addressLength;
  final void Function()? onTap;
  final bool isSelected;
  const AddressWidget({
    super.key,
    required this.isDarkModeOn,
    this.isAddressScreen = false,
    this.addressData,
    this.addressLength = 0,
    this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          15,
        ),
        border: Border.all(
          color: AppConstants.black10,
        ),
      ),
      child: Consumer<PharmaAddressProvider>(
        builder: (context, provider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                isAddressScreen
                    ? CommonInkwell(
                        onTap: onTap,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: isDarkModeOn
                              ? AppConstants.commonGold
                              : AppConstants.darkBlue,
                          child: CircleAvatar(
                            radius: 11,
                            backgroundColor: isDarkModeOn
                                ? AppConstants.black
                                : AppConstants.white,
                            child: CircleAvatar(
                              radius: 9,
                              backgroundColor: isDarkModeOn
                                  ? isSelected == true
                                      ? AppConstants.commonGold
                                      : AppConstants.black
                                  : isSelected == true
                                      ? AppConstants.darkBlue
                                      : AppConstants.white,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: 40,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: isDarkModeOn
                              ? AppConstants.commonGold
                              : AppConstants.darkBlue,
                        ),
                        child: Center(
                          child: CommonTextWidget(
                            color: isDarkModeOn
                                ? AppConstants.black
                                : AppConstants.white,
                            text: "${addressData?.addressType}",
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                const SizeBoxV(10),
                Expanded(
                  child: CommonTextWidget(
                    align: TextAlign.start,
                    color:
                        isDarkModeOn ? AppConstants.white : AppConstants.black,
                    text: addressData?.name ?? "",
                    fontSize: 16,
                    maxLines: 2,
                    overFlow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizeBoxV(10),
                isAddressScreen
                    ? Row(
                        children: [
                          CommonInkwell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return ConfirmationWidget(
                                    title: "DELETE",
                                    message: "Are you sure ?",
                                    onTap: () {
                                      provider.deleteAddressFn(
                                        ctx: context,
                                        addressId: addressData?.id ?? "",
                                      );
                                      context.pop();
                                    },
                                    onCancel: () {
                                      context.pop();
                                    },
                                    isDarkModeOn: isDarkModeOn,
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: AppConstants.red.withOpacity(0.5),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.delete_outline,
                                  color: AppConstants.red,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizeBoxV(10),
                          Container(
                            width: 40,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: isDarkModeOn
                                  ? AppConstants.commonGold
                                  : AppConstants.darkBlue,
                            ),
                            child: Center(
                              child: CommonTextWidget(
                                color: isDarkModeOn
                                    ? AppConstants.black
                                    : AppConstants.white,
                                text: addressData?.addressType ?? "",
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      )
                    : CommonInkwell(
                        onTap: () {
                          context.pushNamed(AppRouter.addressScreen);
                        },
                        child: Container(
                          width: 100,
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: isDarkModeOn
                                ? AppConstants.transparent
                                : AppConstants.transparent,
                            border: Border.all(
                              color: isDarkModeOn
                                  ? AppConstants.white
                                  : AppConstants.black,
                            ),
                          ),
                          child: Center(
                            child: CommonTextWidget(
                              color: isDarkModeOn
                                  ? AppConstants.white
                                  : AppConstants.black,
                              text: "Change Address",
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                const SizeBoxV(10),
                IconButton(
                  onPressed: () {
                    context.pushNamed(AppRouter.addAddressScreen,
                        queryParameters: {
                          "isEdit": "true",
                          "addressId": addressData?.id,
                          "address": addressData?.address,
                          "city": addressData?.city,
                          "pincode": addressData?.pincode,
                          "state": addressData?.state,
                          "name": addressData?.name,
                          "phone": addressData?.phone,
                          "addressType": addressData?.addressType,
                          "dialCodeShipping": addressData?.dialCodeShipping,
                          "isDefault": addressData?.isDefault.toString(),
                        });
                  },
                  icon: Icon(
                    Icons.edit,
                    color: isDarkModeOn
                        ? AppConstants.commonGold
                        : AppConstants.darkBlue,
                  ),
                ),
              ],
            ),
            const SizeBoxH(0),
            CommonTextWidget(
              color: isDarkModeOn ? AppConstants.white : AppConstants.black,
              text: "${addressData?.city ?? ''},${addressData?.state ?? ''}",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            const SizeBoxH(10),
            CommonTextWidget(
              color: isDarkModeOn ? AppConstants.white : AppConstants.black,
              text:
                  "${addressData?.address ?? ''}, ${addressData?.pincode ?? ''}",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            const SizeBoxH(10),
            CommonTextWidget(
              color: isDarkModeOn ? AppConstants.white : AppConstants.black,
              text:
                  "Mobile number: ${addressData?.dialCodeShipping} ${addressData?.phone}",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}

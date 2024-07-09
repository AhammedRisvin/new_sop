import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/app_router.dart';
import 'package:sophwe_newmodule/app/helpers/extentions.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/modules/pharma/address/view_model/address_provider.dart';
import 'package:sophwe_newmodule/app/modules/widgets/empty_screen.dart';
import 'package:sophwe_newmodule/app/utils/app_images.dart';
import 'package:sophwe_newmodule/app/utils/enums.dart';

import '../../../../utils/app_constants.dart';
import '../../../widgets/common_widgets.dart';
import '../../home/home screen/view model/theme_provider.dart';
import '../../widget/address_widget.dart';
import '../model/address_model.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

PharmaAddressProvider? provider;

class _AddressScreenState extends State<AddressScreen> {
  @override
  void initState() {
    super.initState();
    provider = context.read<PharmaAddressProvider>();
    provider?.getPharmaAddressFn();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, _) => Scaffold(
        backgroundColor: isDarkModeOn ? AppConstants.black : AppConstants.white,
        appBar: AppBar(
          surfaceTintColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          title: CommonTextWidget(
            color: isDarkModeOn ? AppConstants.white : AppConstants.black,
            text: "Address",
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          backgroundColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: isDarkModeOn ? AppConstants.white : AppConstants.black,
            ),
          ),
          actions: [
            CommonInkwell(
              onTap: () {
                context.pushNamed(AppRouter.addAddressScreen, queryParameters: {
                  "isEdit": "false",
                  "addressId": "",
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isDarkModeOn
                        ? AppConstants.commonGold
                        : AppConstants.darkBlue,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonTextWidget(
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      text: "Add New Address",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    Icon(
                      Icons.add,
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Consumer<PharmaAddressProvider>(
          builder: (context, provider, child) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: provider.getAddressModel.shippingAddress?.isEmpty == true
                ? EmptyScreenWidget(
                    text: "You haven't saved any address",
                    image: AppImages.reminderEmpty,
                    height: Responsive.height * 80,
                  )
                : provider.status == PharmaAddressStatus.loading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: isDarkModeOn
                              ? AppConstants.commonGold
                              : AppConstants.darkBlue,
                        ),
                      )
                    : provider.status == PharmaAddressStatus.loaded
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonTextWidget(
                                color: isDarkModeOn
                                    ? AppConstants.white
                                    : AppConstants.black,
                                text: "Saved Address",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              const SizeBoxH(20),
                              Expanded(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final addressData =
                                        provider.sortedAddresses?[index];
                                    final isSelected =
                                        provider.selectedAddressIndex == index;
                                    return AddressWidget(
                                      isDarkModeOn: isDarkModeOn,
                                      isAddressScreen: true,
                                      addressData: addressData,
                                      onTap: () {
                                        provider.changeUserAddressFn(
                                          newAddress:
                                              addressData ?? ShippingAddress(),
                                          index: index,
                                        );
                                      },
                                      isSelected: isSelected,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizeBoxH(15),
                                  itemCount:
                                      provider.sortedAddresses?.length ?? 0,
                                ),
                              ),
                            ],
                          )
                        : EmptyScreenWidget(
                            text: "Server is Busy Please Try Again Later",
                            image: AppImages.serverMaintenanceImage,
                            height: Responsive.height * 80,
                            isFromServerError: true,
                            ontap: () {
                              provider.getPharmaAddressFn();
                            },
                          ),
          ),
        ),
      ),
    );
  }
}

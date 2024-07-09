// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sophwe_newmodule/app/backend/pharmacy/urls.dart';
import 'package:sophwe_newmodule/app/backend/server_client_services.dart';
import 'package:sophwe_newmodule/app/helpers/loading_overlay.dart';
import 'package:sophwe_newmodule/app/modules/widgets/common_widgets.dart';

import '../../../../utils/enums.dart';
import '../../../home/settings/profile_edit/view_model/number_validation_map.dart';
import '../model/address_model.dart';

class PharmaAddressProvider extends ChangeNotifier {
  //  --------- GET ADDRESS FN START --------- //
  GetAddressModel getAddressModel = GetAddressModel();
  PharmaAddressStatus status = PharmaAddressStatus.initial;
  List<ShippingAddress>? sortedAddresses;
  ShippingAddress? defaultShippingAddress;

  Future<void> getPharmaAddressFn() async {
    try {
      status = PharmaAddressStatus.loading;
      getAddressModel = GetAddressModel();
      List response = await ServerClient.get(
        Urls.getPharmaAddressUrl,
      );
      if (response.first >= 200 && response.first < 300) {
        getAddressModel = GetAddressModel.fromJson(response.last);
        sortedAddresses = getAddressModel.shippingAddress;
        defaultShippingAddress = sortedAddresses?.firstWhere(
          (element) => element.isDefault == true,
          orElse: () => sortedAddresses?.isNotEmpty == true
              ? sortedAddresses!.first
              : ShippingAddress(),
        );
        if (defaultShippingAddress?.isDefault == true) {
          bool? find = sortedAddresses?.remove(defaultShippingAddress);
          if (find == true) {
            sortedAddresses?.insert(0, defaultShippingAddress!);
          }
        }
        status = PharmaAddressStatus.loaded;
        notifyListeners();
      } else {
        status = PharmaAddressStatus.error;
      }
    } catch (e) {
      debugPrint('Get Address Error: $e');
      status = PharmaAddressStatus.error;
    } finally {
      notifyListeners();
    }
  }

  //  --------- GET ADDRESS FN END --------- //

//  --------- PHONE NUMBER ----------- //
  int maxLength = 9;
  String countryCodeCtrl = "+917";

  void updateCountryCode(String value) {
    countryCodeCtrl = value;
    getMaxLength();
    notifyListeners();
  }

  void getMaxLength() {
    maxLength = NumberValidation.getLength(countryCodeCtrl);
  }

//  --------- PHONE NUMBER ----------- //

// --------- ADDRESS TYPE ----------- //

  bool isDefault = false;
  String addressType = 'Home';

  void toggleDefaultStatus() {
    isDefault = !isDefault;
    notifyListeners();
  }

  void setAddressType(String type) {
    addressType = type;
    notifyListeners();
  }

  // --------- ADDRESS TYPE ----------- //

  // --------- ADD ADDRESS FN START --------- //

  Future<void> addAddressFn({
    required BuildContext ctx,
    required String address,
    required String city,
    required String pincode,
    required String state,
    required String name,
    required String phone,
    required Null Function() clear,
  }) async {
    try {
      LoadingOverlay.of(ctx).show();
      final body = {
        "address": address,
        "city": city,
        "pincode": pincode,
        "state": state,
        "name": name,
        "phone": phone,
        "addressType": addressType,
        "dialCode": countryCodeCtrl,
        "isDefault": isDefault,
      };
      List response = await ServerClient.post(
        Urls.getPharmaAddressUrl,
        data: body,
        post: true,
      );
      if (response.first >= 200 && response.first < 300) {
        getPharmaAddressFn();
        clear();
        addressType = 'Home';
        isDefault = false;
        ctx.pop();
        toast(
          ctx,
          title: "Address added successfully",
          backgroundColor: Colors.green,
        );
      } else {
        toast(
          ctx,
          title: "Failed to add address",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      toast(
        ctx,
        title: "please try again later",
        backgroundColor: Colors.red,
      );
      ctx.pop();
      debugPrint('Add Address Error: $e');
    } finally {
      LoadingOverlay.of(ctx).hide();
      notifyListeners();
    }
  }

  Future<void> editAddressFn(
      {required BuildContext ctx,
      required String address,
      required String city,
      required String pincode,
      required String state,
      required String name,
      required String phone,
      required String addressId,
      required Null Function() clear}) async {
    try {
      LoadingOverlay.of(ctx).show();
      final body = {
        "address": address,
        "city": city,
        "pincode": pincode,
        "state": state,
        "name": name,
        "phone": phone,
        "addressType": addressType,
        "dialCode": countryCodeCtrl,
        "isDefault": isDefault,
      };

      List response = await ServerClient.put(
        "${Urls.getPharmaAddressUrl}/$addressId",
        data: body,
      );
      if (response.first >= 200 && response.first < 300) {
        getPharmaAddressFn();
        clear();
        isDefault = false;
        addressType = 'Home';
        toast(
          ctx,
          title: "Address edited successfully",
          backgroundColor: Colors.green,
        );
        ctx.pop();
      } else {
        toast(
          ctx,
          title: "Failed to edit address",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      toast(
        ctx,
        title: "please try again later",
        backgroundColor: Colors.red,
      );
      ctx.pop();
      debugPrint('edit Address Error: $e');
    } finally {
      LoadingOverlay.of(ctx).hide();
      notifyListeners();
    }
  }

  //  -------- ADD ADDRESS FN END --------  //

  int selectedAddressIndex = 0;

  void changeUserAddressFn({
    required ShippingAddress newAddress,
    required int index,
  }) {
    if (sortedAddresses != null &&
        index >= 0 &&
        index < sortedAddresses!.length) {
      sortedAddresses!.removeAt(index);
      sortedAddresses!.insert(0, newAddress);
      selectedAddressIndex = 0;
      defaultShippingAddress = newAddress;
      notifyListeners();
    }
  }

  //  --------- DELETE ADDRESS FN START --------- //

  Future<void> deleteAddressFn({
    required BuildContext ctx,
    required String addressId,
  }) async {
    try {
      LoadingOverlay.of(ctx).show();
      List response = await ServerClient.delete(
        "${Urls.getPharmaAddressUrl}/$addressId",
      );
      if (response.first >= 200 && response.first < 300) {
        getPharmaAddressFn();
        toast(
          ctx,
          title: "Address deleted successfully",
          backgroundColor: Colors.green,
        );
      } else {
        toast(
          ctx,
          title: "Failed to delete address",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      toast(
        ctx,
        title: "please try again later",
        backgroundColor: Colors.red,
      );
      debugPrint('Delete Address Error: $e');
    } finally {
      LoadingOverlay.of(ctx).hide();
      notifyListeners();
    }
  }

  //  --------- DELETE ADDRESS FN START --------- //
}

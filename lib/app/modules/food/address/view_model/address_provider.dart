import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sophwe_newmodule/app/helpers/app_router.dart';
import 'package:sophwe_newmodule/app/modules/home/settings/profile_edit/view_model/number_validation_map.dart';

import '../../../../backend/food/food_server_client_services.dart';
import '../../../../backend/food/urls.dart';
import '../../../../utils/food/food_enums.dart';
import '../../../widgets/common_widgets.dart';
import '../model/address_model.dart';

class FoodAddressProvider extends ChangeNotifier {
  TextEditingController foodAddresNameControll = TextEditingController();
  TextEditingController foodAddresCountryCodeControll = TextEditingController();
  TextEditingController foodAddresPhoneNumberControll = TextEditingController();
  TextEditingController foodAddresCountryControll = TextEditingController();
  TextEditingController foodAddresCityControll = TextEditingController();
  TextEditingController foodAddresStreetAddressControll =
      TextEditingController();
  TextEditingController foodAddresZipCodeControll = TextEditingController();

  String countryCodeCtrl = "+917";
  int maxLength = 9;

  void getMaxLength() {
    maxLength = NumberValidation.getLength(countryCodeCtrl);
  }

  void updateCountryCode(String value) {
    countryCodeCtrl = value;
    getMaxLength();
    notifyListeners();
  }

  String addressType = '';
  void updateAddressType({String? value}) {
    addressType = value ?? '';
    notifyListeners();
  }

  bool isSetDefault = false;
  void updateIsSetDefault() {
    isSetDefault = !isSetDefault;
    notifyListeners();
  }

  int selectedAddressIndex = -1;

  void updateSelectedAddressIndex({int? index}) {
    selectedAddressIndex = index ?? -1;
    notifyListeners();
  }

  FoodAddressModel foodAddressModel = FoodAddressModel();
  bool isEditAddress = false;
  void updateIsEdit({bool? isEdit}) {
    isEditAddress = isEdit ?? false;

    notifyListeners();
  }

  addAddressinCtrol({required String addressId}) {
    // Find the address by ID
    ShippingAddress? address = foodAddressModel.shippingAddress?.firstWhere(
      (addr) => addr.id == addressId,
    );

    // If address is found, update the form controls
    if (address != null) {
      foodAddresNameControll.text = address.name ?? '';
      foodAddresPhoneNumberControll.text = address.phone ?? '';
      foodAddresCountryControll.text = address.city ?? '';
      foodAddresCityControll.text = address.city ?? '';
      foodAddresStreetAddressControll.text = address.address ?? '';
      foodAddresZipCodeControll.text = address.pincode ?? '';
      addressType = address.addressType ?? '';
      isSetDefault = address.isDelete ?? false;
      notifyListeners();
    } else {
      // Handle case when address is not found
      print('Address with ID $addressId not found');
    }
    notifyListeners();
  }
  /*........................Api integration......................*/
  /*........................Api addrees......................*/

  GetAddressStatus getAddressStatus = GetAddressStatus.initial;
  Future getAllAddressFnc({required BuildContext context}) async {
    try {
      getAddressStatus = GetAddressStatus.loading;
      final response = await FoodServerClient.get(FoodUrls.getAddressUrl);
      print('statusCode:::${response.first}');
      if (response.first >= 200 && response.first < 300) {
        foodAddressModel = FoodAddressModel.fromJson(response.last);

        getAddressStatus = GetAddressStatus.loaded;
      } else {
        getAddressStatus = GetAddressStatus.error;
        toast(context,
            title: response.last, backgroundColor: Colors.red, duration: 2);
      }
    } catch (e) {
      getAddressStatus = GetAddressStatus.error;
      toast(context,
          title: 'something have proplem',
          backgroundColor: Colors.red,
          duration: 2);
    } finally {
      notifyListeners();
    }
  }

  /*........................Api addrees......................*/

  clearFnc() {
    foodAddresNameControll.clear();
    foodAddresPhoneNumberControll.clear();
    foodAddresCountryControll.clear();
    foodAddresCityControll.clear();
    foodAddresStreetAddressControll.clear();
    foodAddresZipCodeControll.clear();
    addressType = '';
    isSetDefault = false;
    notifyListeners();
  }

  Future addAddressFnc({
    required BuildContext context,
  }) async {
    try {
      final response = await FoodServerClient.post(FoodUrls.addAddressUrl,
          post: true,
          data: {
            'name': foodAddresNameControll.text,
            'phone': foodAddresPhoneNumberControll.text,
            'address': foodAddresStreetAddressControll.text,
            'city': foodAddresCityControll.text,
            'state': foodAddresCityControll
                .text, // Assuming state field is not used in the form
            'pincode': foodAddresZipCodeControll.text,
            'addressType': addressType,
            'alternatePhone': '',
            'isDefault': isSetDefault,
          });
      print('statusCode:::${response.first}');
      if (response.first >= 200 && response.first < 300) {
        // ignore: use_build_context_synchronously
        context.pushReplacementNamed(AppRouter.foodaddresscreen);
        clearFnc();
      } else {
        toast(context,
            title: response.last, backgroundColor: Colors.red, duration: 2);
      }
    } catch (e) {
      toast(context,
          title: 'something have proplem',
          backgroundColor: Colors.red,
          duration: 2);
    } finally {
      notifyListeners();
    }
  }

  Future editAddressFnc(
      {required BuildContext context, required String addressId}) async {
    try {
      final response = await FoodServerClient.put(
          FoodUrls.editAddressUrl + addressId,
          data: {
            'name': foodAddresNameControll.text,
            'phone': foodAddresPhoneNumberControll.text,
            'address': foodAddresStreetAddressControll.text,
            'city': foodAddresCityControll.text,
            'state': foodAddresCityControll
                .text, // Assuming state field is not used in the form
            'pincode': foodAddresZipCodeControll.text,
            'addressType': addressType,
            'alternatePhone': '',
            'isDefault': isSetDefault,
          });
      print('statusCode:::${response.first}');
      if (response.first >= 200 && response.first < 300) {
        // ignore: use_build_context_synchronously
        context.pushReplacementNamed(AppRouter.foodaddresscreen);
        updateIsEdit(isEdit: false);
        clearFnc();
      } else {
        toast(context,
            title: response.last, backgroundColor: Colors.red, duration: 2);
      }
    } catch (e) {
      toast(context,
          title: 'something have proplem',
          backgroundColor: Colors.red,
          duration: 2);
    } finally {
      notifyListeners();
    }
  }

  Future deleteAddressFnc(
      {required BuildContext context, required String addressId}) async {
    try {
      final response = await FoodServerClient.delete(
        FoodUrls.deleteAddressUrl + addressId,
      );
      print('statusCode:::${response.first}');
      if (response.first >= 200 && response.first < 300) {
        int index = foodAddressModel.shippingAddress?.indexWhere(
              (addr) => addr.id == addressId,
            ) ??
            -1;

        if (index != -1) {
          foodAddressModel.shippingAddress?.removeAt(index);
          context.pop();
          notifyListeners();
        } else {
          print('Address with ID $addressId not found');
        }
      } else {
        toast(context,
            title: response.last, backgroundColor: Colors.red, duration: 2);
      }
    } catch (e) {
      toast(context,
          title: 'something have proplem',
          backgroundColor: Colors.red,
          duration: 2);
    } finally {
      notifyListeners();
    }
  }
}

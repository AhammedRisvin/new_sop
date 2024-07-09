import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../../../../backend/pharmacy/urls.dart';
import '../../../../../backend/server_client_services.dart';
import '../../../../../utils/enums.dart';
import '../../../../home/home/model/get_home_data_model.dart';
import '../model/get_product_model.dart';
import '../model/get_sub_catagory_model.dart';

class CatagoryProvider extends ChangeNotifier {
  int selectedIndex = 0;
  String selectedSubCatagoryId = "";
  void selectContainer(int index, String subCatagoryId) {
    selectedIndex = index;
    selectedSubCatagoryId = subCatagoryId;
    notifyListeners();
  }

  String searchKeyword = "";
  void setSearchKeyword(String keyword) {
    searchKeyword = keyword;
    notifyListeners();
  }

  // ----------------- GET SUB CATAGORY START ----------------- //
  GetSubCatagoryModel getSubCatagoryModel = GetSubCatagoryModel();
  GetSubCatagoryStatus pharmaSubCatagoryStatus = GetSubCatagoryStatus.initial;

  Future<void> getSubCatagoryFn({
    required String catagoryId,
  }) async {
    pharmaSubCatagoryStatus = GetSubCatagoryStatus.loading;
    try {
      getSubCatagoryModel = GetSubCatagoryModel();
      List response = await ServerClient.get(
        Urls.getPharmacySubCatagory + catagoryId,
      );

      log("response.first ${response.first} response.last ${response.last}");
      if (response.first >= 200 && response.first <= 299) {
        pharmaSubCatagoryStatus = GetSubCatagoryStatus.loaded;
        getSubCatagoryModel = GetSubCatagoryModel.fromJson(response.last);
        getSubCatagoryModel.subCategories?.insert(
          0,
          SubCategory(
            id: "",
            name: "All",
          ),
        );
        selectedSubCatagoryId =
            getSubCatagoryModel.subCategories?.first.id ?? "";
        getProductFn(
          catagoryId: catagoryId,
          subCatagoryId: getSubCatagoryModel.subCategories?.first.id ?? "",
        );
        notifyListeners();
      } else {
        pharmaSubCatagoryStatus = GetSubCatagoryStatus.error;
        notifyListeners();
      }
    } catch (e) {
      pharmaSubCatagoryStatus = GetSubCatagoryStatus.error;
      debugPrint('Error: $e');
    } finally {
      notifyListeners();
    }
  }

  // ----------------- GET SUB CATAGORY END   ----------------- //

  // ----------------- GET SUB CATAGORY START ----------------- //
  GetProductModel getProductModel = GetProductModel();
  GetProductStatus getProductStatus = GetProductStatus.initial;
  List<LatestProduct> searchList = [];

  Future<void> getProductFn({
    required String catagoryId,
    required String subCatagoryId,
    String filterKeyWord = "",
    String search = '',
  }) async {
    getProductStatus = GetProductStatus.loading;
    try {
      if (search.isEmpty) {
        searchList.clear();
      }
      getProductModel = GetProductModel();
      List response = await ServerClient.get(
        "${Urls.getPharmacyProduct + subCatagoryId}&category=$catagoryId$filterKeyWord&keyword=$search",
      );
      if (response.first >= 200 && response.first <= 299) {
        getProductStatus = GetProductStatus.loaded;
        getProductModel = GetProductModel.fromJson(response.last);
        if (search.isNotEmpty) {
          searchList.clear();
          searchList.addAll(getProductModel.products ?? []);
        }
        notifyListeners();
      } else {
        getProductModel = GetProductModel();
        notifyListeners();
      }
    } catch (e) {
      getProductStatus = GetProductStatus.error;
      debugPrint('Error: $e');
    } finally {
      notifyListeners();
    }
  }

  // ----------------- GET SUB CATAGORY END   ----------------- //

  //  VOICE SEARCH FUN START
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = '';

  bool get isListening => _isListening;
  String get text => _text;

  void startListening(
    String catagoryId,
    String subCatagoryId,
    TextEditingController searchController,
  ) async {
    _isListening = true;
    notifyListeners();
    bool available = await _speech.initialize(onStatus: (status) {
      if (status == 'done') {
        _isListening = false;
        notifyListeners();
      }
    }, onError: (error) {
      _isListening = false;
      notifyListeners();
    });
    if (available) {
      _speech.listen(onResult: (result) {
        _text = result.recognizedWords;
        searchKeyword = _text;
        searchController.text = _text;
        getProductFn(
          catagoryId: catagoryId,
          subCatagoryId: subCatagoryId,
          search: _text,
        );
        notifyListeners();
      });
    }
  }

  void stopListening() {
    _speech.stop();
    _isListening = false;
    notifyListeners();
  }

  void resetVoiceSearchState() {
    _isListening = false;
    _text = '';
    notifyListeners();
  }

  //  VOICE SEARCH FUN END
}

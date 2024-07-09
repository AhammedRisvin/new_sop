// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';

import '../../../../../backend/server_client_services.dart';
import '../../../../../backend/settings_url/settings_url.dart';
import '../../../../../helpers/loading_overlay.dart';
import '../../../../widgets/common_widgets.dart';
import '../../main/view_model/settings_provider.dart';
import 'number_validation_map.dart';

class ProfileEditProvider extends ChangeNotifier {
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

  // GENDER DROPDOWN

  String selectedGender = "Male";
  void updateSelectedGender(String value) {
    selectedGender = value;
    notifyListeners();
  }

  // DATE PICKER
  String selectedDate = '';
  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      selectedDate =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      FocusScope.of(context).unfocus();
      FocusScope.of(context).requestFocus(FocusNode());
      notifyListeners();
    }
  }

  // Height
  String? selectedUnit = "feet";

  void onSelect(String title) {
    selectedUnit = title;
    notifyListeners();
  }
  // --------- IMAGE PICKING START -------- //

  // image picker
  File? thumbnailImage;
  String? imageTitle;
  Future<File?> pickImageFromGallery() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg'],
      );
      var image = result?.files[0];
      if (image == null) return null;
      final imageTemporaryData = File(image.path!);
      thumbnailImage = imageTemporaryData;
      imageTitle = thumbnailImage?.path.split('/').last ?? "";
      return imageTemporaryData;
    } finally {
      notifyListeners();
    }
  }

  // Image Upload Function
  String imageUrlForUpload = '';

  Future<void> uploadImage({required BuildContext context}) async {
    File? tempImage = await pickImageFromGallery();
    if (tempImage == null) {
      return;
    }

    final fileType = getMimeType(tempImage.path);
    const url = 'https://api.dev.test.image.theowpc.com/upload';
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
      await http.MultipartFile.fromPath(
        'image_mushthak',
        tempImage.path,
        contentType: MediaType.parse(fileType),
      ),
    );
    request.headers['Content-Type'] = fileType;

    try {
      LoadingOverlay.of(context).show();
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        var data = json.decode(responseBody);
        imageUrlForUpload = data["images"][0]["imageUrl"];
        LoadingOverlay.of(context).hide();

        FocusScope.of(context).unfocus();
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
      debugPrint('Error occurred during upload: $e ');
    } finally {
      FocusScope.of(context).unfocus();
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  String getMimeType(String filePath) {
    final file = File(filePath);
    final fileType = file.path.split('.').last.toLowerCase();
    switch (fileType) {
      case 'jpg':
        return 'image/jpg';
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'mp4':
        return 'video/mp4';
      case 'webm':
        return 'video/webm';
      case 'mov':
        return 'video/quicktime';
      case 'pdf':
        return 'application/pdf';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case 'xls':
        return 'application/vnd.ms-excel';
      case 'xlsx':
        return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      case 'mkv':
        return 'video/x-matroska';
      case 'avi':
        return 'video/x-msvideo';
      case 'mp3':
        return 'audio/mpeg';
      case 'wav':
        return 'audio/wav';
      case 'flac':
        return 'audio/flac';
      default:
        return 'application/octet-stream';
    }
  }

  // --------- IMAGE PICKING END -------- //

  // --------- API INTEGRATION -------- //

  Future<void> updateProfileFn({
    required String name,
    required String phone,
    required String heigh,
    required String weight,
    required BuildContext context,
    required Function() clear,
  }) async {
    LoadingOverlay.of(context).show();
    try {
      if (name.isEmpty ||
          phone.isEmpty ||
          heigh.isEmpty ||
          weight.isEmpty ||
          selectedDate.isEmpty ||
          imageUrlForUpload == '') {
        toast(
          context,
          title: "Please fill all the fields",
          backgroundColor: Colors.red,
        );
        return;
      }
      int weightInt = int.parse(weight);
      int heightInt = int.parse(heigh);
      var params = {
        "name": name,
        "phone": phone,
        "dateOfBirth": selectedDate,
        "height": heightInt,
        "weight": weightInt,
        "profileImage": imageUrlForUpload,
        "unit": selectedUnit,
        "dialCode": countryCodeCtrl,
        "gender": selectedGender,
      };

      List response = await ServerClient.post(
        SettingsUrl.updateProfileUrl,
        data: params,
        post: true,
      );
      if (response.first >= 200 && response.first <= 300) {
        clear();
        context.read<SettingsProvider>().getProfileDataFn();
        context.pop();
        toast(
          context,
          title: "Profile Updated Successfully",
          backgroundColor: Colors.green,
        );
      } else {
        toast(
          context,
          title: "Something went wrong",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      debugPrint("Error: $e");
      toast(
        context,
        title: "Something went wrong,Please try again later",
        backgroundColor: Colors.red,
      );
    } finally {
      LoadingOverlay.of(context).hide();
      FocusScope.of(context).unfocus();
      FocusScope.of(context).requestFocus(FocusNode());
      notifyListeners();
    }
  }
}

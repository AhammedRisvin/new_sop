// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sophwe_newmodule/app/backend/pharmacy/urls.dart';
import 'package:sophwe_newmodule/app/backend/server_client_services.dart';

import '../../../../../helpers/loading_overlay.dart';
import '../../../../../utils/enums.dart';
import '../../../../widgets/common_widgets.dart';
import '../model/get_review_model.dart';

class RatingProvider extends ChangeNotifier {
  double ratingLength = 0.0;

  ratingLengthFun(double value) {
    ratingLength = value;
    notifyListeners();
  }

  List<String> selectedOptions = [];

  void toggleOption(String option) {
    if (selectedOptions.contains(option)) {
      selectedOptions.remove(option);
    } else {
      selectedOptions.add(option);
    }
    notifyListeners();
  }

  List reviewsBad = [
    'Location awareness',
    'Rider behavior',
    'Rider hygiene',
    'Delivery time',
    'Excessive calling',
    'Delivery instruction ignored',
    'Spilled or damaged item',
  ];

  // ------------- LIST ALL REVIEW FN START --------- //

  GetReviewModel reviewModel = GetReviewModel();
  ReviewStatus reviewStatus = ReviewStatus.loading;

  // Variables for pagination
  int currentPage = 1;
  bool hasMore = true;

  Future<void> getReviewFn({
    required String productId,
    String page = '1',
  }) async {
    if (!hasMore) return;

    try {
      reviewStatus = ReviewStatus.loading;
      List response = await ServerClient.get(
        "${Urls.getReviewUrl + productId}&page=$currentPage",
      );
      if (response.first >= 200 && response.first < 300) {
        var newReviews = GetReviewModel.fromJson(response.last);
        if (currentPage == 1) {
          reviewModel = newReviews;
        } else {
          reviewModel.reviews?.addAll(newReviews.reviews ?? []);
        }
        reviewStatus = ReviewStatus.loaded;
        currentPage++;
        hasMore = newReviews.reviews?.isNotEmpty ?? false;
      } else {
        reviewStatus = ReviewStatus.error;
      }
    } catch (e) {
      debugPrint('Get Review Error: $e');
    } finally {
      notifyListeners();
    }
  }

  // -------------  LIST ALL REVIEW FN END  --------- //

  //  format date

  String formatDate(DateTime date) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
    final DateTime inputDate = DateTime(date.year, date.month, date.day);

    if (inputDate == today) {
      return 'Today';
    } else if (inputDate == yesterday) {
      return 'Yesterday';
    } else {
      return '${date.day} ${_monthName(date.month)} ${date.year}';
    }
  }

  String _monthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return 'Unknown';
    }
  }

  //  ---- ADD REVIEW FN START ---- //

  void clear() {
    addedImageList.clear();
    item = 0;
    notifyListeners();
  }

  List<String> addedImageList = [];
  int item = 0;
  File? thumbnailImage;
  Future addImage(bool isGallery, BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(
        source: isGallery ? ImageSource.gallery : ImageSource.camera,
      );

      if (image == null) return;
      final imageTemporary = File(image.path);
      thumbnailImage = imageTemporary;
      notifyListeners();

      if (thumbnailImage != null) {
        uploadImage(context: context);
      }
    } finally {
      notifyListeners();
    }
  }

//**Image Upload Fun */
  String imageUrlForUpload = '';
  // Function to upload image to the API
  String? imageTitlee;
  Future<void> uploadImage({required BuildContext context}) async {
    LoadingOverlay.of(context).show();

    final fileType = getMimeType(thumbnailImage?.path ?? '');
    const url = 'https://api.dev.test.image.theowpc.com/upload';
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
      await http.MultipartFile.fromPath(
        'image_mushthak',
        thumbnailImage?.path ?? '',
        contentType: MediaType.parse(fileType),
      ),
    );
    request.headers['Content-Type'] = fileType;
    LoadingOverlay.of(context).hide();
    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var data = json.decode(responseBody);

        imageUrlForUpload = data['images'][0]["imageUrl"];
        addImageToList(imageUrlForUpload);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    } finally {
      notifyListeners();
    }
  }

  void addImageToList(String value) {
    addedImageList.add(value);
    item++;

    notifyListeners();
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

  int selectedRate = 1;

  void updateRate(int value) {
    selectedRate = value;
    notifyListeners();
  }

  Future<void> postReviewFn({
    required String productId,
    required BuildContext context,
    required String review,
    required void Function() clear,
  }) async {
    if (review.isEmpty) {
      toast(context, title: 'Please write Something');
    } else {
      try {
        LoadingOverlay.of(context).show();
        var params = {
          "productId": productId,
          "review": review,
          "rating": selectedRate,
          "images": addedImageList
        };
        List response = await ServerClient.post(Urls.addReviewUrl,
            data: params, post: true);
        if (response.first >= 200 && response.first < 300) {
          clear();
          selectedRate = 0;
          addedImageList.clear();
          context.pop();
          LoadingOverlay.of(context).hide();
          toast(
            context,
            title: "Review added successfully!",
            backgroundColor: Colors.green,
          );
        } else if (response.first == 400) {
          LoadingOverlay.of(context).hide();
          toast(context,
              title: response.last.toString(), backgroundColor: Colors.red);
        }
      } catch (e) {
        debugPrint('Error occurred during upload: $e ');
      } finally {
        LoadingOverlay.of(context).hide();
        notifyListeners();
      }
    }
  }

  //  ---- ADD REVIEW FN END ---- //
}

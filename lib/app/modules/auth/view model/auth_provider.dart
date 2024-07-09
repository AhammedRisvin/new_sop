// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../../background_nt.dart';
import '../../../backend/auth_urls/auth_urls.dart';
import '../../../backend/server_client_services.dart';
import '../../../helpers/app_router.dart';
import '../../../helpers/loading_overlay.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/prefferences.dart';
import '../../widgets/common_widgets.dart';

class AuthProvider extends ChangeNotifier {
  bool isSignUpTapped = false;

  void updateSignUpTapped() {
    isSignUpTapped = !isSignUpTapped;
    notifyListeners();
  }

  bool toggleVisibility = true;

  void updateVisibility() {
    toggleVisibility = !toggleVisibility;
    notifyListeners();
  }

  bool toggleConfirmPasswordVisibility = true;

  void updateConfirmPasswordVisibility() {
    toggleConfirmPasswordVisibility = !toggleConfirmPasswordVisibility;
    notifyListeners();
  }

  String otpController = "";
  String emailForOtp = "";

  // ----------------- Sign up  function start ----------------- //
  Future<void> signUpFn({
    required BuildContext context,
    required String email,
    required String password,
    required String confirmPassword,
    required Function() clear,
    required String fullName,
  }) async {
    LoadingOverlay.of(context).show();
    try {
      if (!_validateFields(
          context, email, password, confirmPassword, fullName)) {
        return;
      }
      var params = imageUrlForUpload.isEmpty
          ? {
              "email": email,
              "password": password,
              "name": fullName,
              "profileImage": 'empty',
            }
          : {
              "email": email,
              "password": password,
              "name": fullName,
              "profileImage": imageUrlForUpload,
            };

      List response = await ServerClient.post(
        AuthUrls.emailSignup,
        data: params,
        post: true,
      );

      if (response.first >= 200 && response.first < 300) {
        clear();
        imageUrlForUpload = '';
        thumbnailImage = null;
        imageTitle = '';
        toggleConfirmPasswordVisibility = true;
        toggleVisibility = true;
        emailForOtp = response.last['email'];
        context.push(AppRouter.otpScreen);
        toast(
          context,
          title: response.last['message'],
          duration: 2,
          backgroundColor: AppConstants.stepperGreen,
        );
      } else {
        toast(
          context,
          title: response.last,
          duration: 2,
          backgroundColor: AppConstants.red,
        );
      }
    } catch (e) {
      debugPrint('Error occurred during signup: $e');
      toast(
        context,
        title: 'An error occurred. Please try again.',
        duration: 2,
        backgroundColor: AppConstants.red,
      );
    } finally {
      LoadingOverlay.of(context).hide();
      FocusScope.of(context).unfocus();
      notifyListeners();
    }
  }

  bool _validateFields(BuildContext context, String email, String password,
      String confirmPassword, String fullName) {
    if (fullName.isEmpty) {
      _showErrorToast(context, 'Please enter your full name');
      return false;
    }

    if (email.isEmpty) {
      _showErrorToast(context, 'Please enter your email');
      return false;
    }

    RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    if (!emailRegExp.hasMatch(email)) {
      _showErrorToast(context, 'Please enter a valid email');
      return false;
    }

    if (password.isEmpty) {
      _showErrorToast(context, 'Please enter a password');
      return false;
    }

    if (password.length < 6) {
      _showErrorToast(context, 'Password must be at least 6 characters long');
      return false;
    }

    if (confirmPassword.isEmpty) {
      _showErrorToast(context, 'Please confirm your password');
      return false;
    }

    if (password != confirmPassword) {
      _showErrorToast(context, 'Password and Confirm Password do not match');
      return false;
    }

    return true;
  }

  void _showErrorToast(BuildContext context, String message) {
    toast(
      context,
      title: message,
      duration: 2,
      backgroundColor: AppConstants.red,
    );
  }
  // ----------------- Sign up  function end ----------------- //

  // ----------------- otp function start ----------------- //

  Future<void> verifyOtp({
    required BuildContext context,
  }) async {
    if (emailForOtp.isEmpty) {
      toast(
        context,
        title: "Email and OTP must not be empty",
        duration: 2,
        backgroundColor: AppConstants.red,
      );
      return;
    }

    try {
      LoadingOverlay.of(context).show();
      String? firebaseId = await BackgroundNt.getToken();
      if (firebaseId == null) {
        toast(
          context,
          title: "Failed to get device information",
          duration: 2,
          backgroundColor: AppConstants.red,
        );
        return;
      }

      // Prepare Parameters
      var params = {
        "email": emailForOtp,
        "otp": otpController,
        "firebaseId": 'empty', //firebaseId
      };

      // Send OTP Verification Request
      List response = await ServerClient.post(
        AuthUrls.verifyOtp,
        data: params,
        post: true,
      );

      if (response.first >= 200 && response.first < 300) {
        AppPref.userToken = response.last['encryptedToken'];
        AppPref.isSignedIn = true;
        emailForOtp = '';
        toast(
          context,
          title: response.last['message'] ?? "Verification successful",
          duration: 2,
          backgroundColor: AppConstants.stepperGreen,
        );

        context.goNamed(AppRouter.mainBottomNav);
      } else {
        toast(
          context,
          title: response.last ?? "Verification failed",
          duration: 2,
          backgroundColor: AppConstants.red,
        );
      }
    } catch (e) {
      debugPrint('Error occurred during OTP verification: $e');
      toast(
        context,
        title: "An error occurred",
        duration: 2,
        backgroundColor: AppConstants.red,
      );
    } finally {
      LoadingOverlay.of(context).hide();
      FocusScope.of(context).unfocus();
      notifyListeners();
    }
  }

  // ----------------- otp function end ----------------- //

  // ----------------- Sign in  function start ----------------- //
  Future<void> signInFn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      toast(
        context,
        title: "Email and password must not be empty",
        duration: 2,
        backgroundColor: AppConstants.red,
      );
      return;
    }
    RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    if (!emailRegExp.hasMatch(email)) {
      toast(
        context,
        title: 'Please enter a valid email',
        duration: 2,
        backgroundColor: AppConstants.red,
      );
      return;
    }

    try {
      LoadingOverlay.of(context).show();
      var params = {
        "email": email,
        "password": password,
      };
      List response = await ServerClient.post(
        AuthUrls.emailSignIn,
        data: params,
        post: true,
      );
      if (response.first >= 200 && response.first < 300) {
        if (response.last['isOtpVerified'] == true) {
          AppPref.userToken = response.last['token'];
          AppPref.isSignedIn = true;
          toast(
            context,
            title: response.last['message'] ?? "Login successful",
            duration: 2,
            backgroundColor: AppConstants.stepperGreen,
          );
          context.goNamed(AppRouter.mainBottomNav);
        } else if (response.last['isOtpVerified'] == false) {
          emailForOtp = response.last['email'];
          context.pushNamed(AppRouter.otpScreen);
          toast(
            context,
            title: response.last['message'] ?? "Please verify your email",
            duration: 2,
            backgroundColor: AppConstants.stepperGreen,
          );
        }
      } else {
        toast(
          context,
          title: response.last ?? "Login failed",
          duration: 2,
          backgroundColor: AppConstants.red,
        );
      }
    } catch (e) {
      debugPrint('Error occurred during sign-in: $e');
      toast(
        context,
        title: "An error occurred",
        duration: 2,
        backgroundColor: AppConstants.red,
      );
    } finally {
      LoadingOverlay.of(context).hide();
      FocusScope.of(context).unfocus();
      FocusScope.of(context).requestFocus(FocusNode());
      notifyListeners();
    }
  }
  // ----------------- Sign in  function end ----------------- //

  // ----------------- Resend otp function start ----------------- //
  Future<void> resendOtpFn({
    required BuildContext context,
  }) async {
    try {
      LoadingOverlay.of(context).show();
      var params = {
        "email": emailForOtp,
      };
      List response = await ServerClient.post(
        AuthUrls.resendOtp,
        data: params,
        post: true,
      );
      if (response.first >= 200 && response.first < 300) {
        toast(
          context,
          title: response.last['message'] ?? "Otp sent successful",
          duration: 2,
          backgroundColor: AppConstants.stepperGreen,
        );
      } else {
        toast(
          context,
          title: response.last['message'] ?? "Otp sending failed",
          duration: 2,
          backgroundColor: AppConstants.red,
        );
      }
    } catch (e) {
      debugPrint('Error occurred during sign-in: $e');
      toast(
        context,
        title: "An error occurred",
        duration: 2,
        backgroundColor: AppConstants.red,
      );
    } finally {
      LoadingOverlay.of(context).hide();
      FocusScope.of(context).unfocus();
      FocusScope.of(context).requestFocus(FocusNode());
      notifyListeners();
    }
  }
  // ----------------- Resend otp  function end ----------------- //

  // ----------------- Upload image start ----------------- //

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

  // ----------------- Upload image end ----------------- //
}

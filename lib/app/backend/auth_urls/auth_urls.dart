import '../../env.dart';

class AuthUrls {
  static String baseUrl = Environments.baseUrl;

  static String emailSignup = "${baseUrl}sophwe-user/register";
  static String verifyOtp = "${baseUrl}sophwe-user/verify-otp";
  static String emailSignIn = "${baseUrl}sophwe-user/login";
  static String resendOtp = "${baseUrl}sophwe-user/resend-otp";
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../helpers/extentions.dart';
import '../../helpers/size_box.dart';
import '../../utils/app_constants.dart';

class CommonInkwell extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final double? borderRadius;
  final Color? splashColor;
  const CommonInkwell(
      {super.key,
      required this.child,
      required this.onTap,
      this.borderRadius,
      this.splashColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      splashColor: splashColor ?? Colors.transparent,
      highlightColor: Colors.transparent,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      focusColor: Colors.transparent,
      onTap: onTap,
      child: child,
    );
  }
}

class CommonTextWidget extends StatelessWidget {
  final Color color;
  final String text;
  final double fontSize;
  final TextAlign align;
  final double letterSpacing;
  final FontWeight fontWeight;
  final int? maxLines;
  final double? height;
  final double? wordSpacing;
  final TextOverflow? overFlow;

  const CommonTextWidget({
    super.key,
    required this.color,
    required this.text,
    this.fontSize = 18,
    this.fontWeight = FontWeight.normal,
    this.letterSpacing = 0.5,
    this.maxLines,
    this.align = TextAlign.center,
    this.overFlow,
    this.height,
    this.wordSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines,
      text,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: AppConstants.fontFamily,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        overflow: overFlow,
        wordSpacing: wordSpacing,
      ),
    );
  }
}

bool _isToastShowing = false;
void toast(
  BuildContext context, {
  String? title,
  int duration = 2,
  Color? backgroundColor,
}) {
  if (_isToastShowing) return;

  _isToastShowing = true;

  final scaffold = ScaffoldMessenger.of(context);
  final mediaQuery = MediaQuery.of(context);
  final bool isKeyboardOpen = mediaQuery.viewInsets.bottom > 0.0;

  scaffold
      .showSnackBar(
        SnackBar(
          backgroundColor: backgroundColor,
          duration: Duration(seconds: duration),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Container(
            height: Responsive.height * 3,
            width: Responsive.width * 90,
            alignment: Alignment.center,
            child: Text(
              title ?? 'Something went wrong',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: isKeyboardOpen ? mediaQuery.viewInsets.bottom : 15.0,
            left: 8.0,
            right: 8.0,
          ),
        ),
      )
      .closed
      .then((reason) {
    _isToastShowing = false;
  });
}

class CachedImageWidget extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final BorderRadiusGeometry? borderRadius;
  const CachedImageWidget({
    super.key,
    required this.imageUrl,
    this.height = 0,
    this.width = 0,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
        ),
      ),
      placeholder: (context, url) => Center(
        child: SizedBox(
          height: height,
          width: width,
          child: const Center(
            child: CircularProgressIndicator(
              color: AppConstants.commonGold,
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) {
        return Image.asset(
          "assets/images/defaultProfPic.png",
          height: height,
          width: width,
          fit: BoxFit.cover,
        );
      },
    );
  }
}

class CommonButton extends StatelessWidget {
  final void Function()? ontap;

  final double horizontal;
  final Color bgColor;
  final double? width;
  final double? fontSize;
  final Color textColor;
  final String text;
  final FontWeight fontWeight;
  final Color borderColor;
  final double height;
  final BorderRadiusGeometry? borderRadius;
  final bool isDarkMode;
  final bool isFromRedButton;

  const CommonButton({
    super.key,
    this.textColor = AppConstants.white,
    this.borderColor = AppConstants.transparent,
    required this.ontap,
    this.horizontal = 0.0,
    this.bgColor = AppConstants.white,
    this.fontWeight = FontWeight.w600,
    this.fontSize,
    this.width,
    required this.height,
    required this.text,
    this.borderRadius,
    required this.isDarkMode,
    this.isFromRedButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        width: width ?? Responsive.width * 100,
        height: height,
        decoration: isFromRedButton
            ? BoxDecoration(
                borderRadius: borderRadius ?? BorderRadius.circular(10),
                border: Border.all(
                  color: borderColor,
                ),
                color: bgColor,
              )
            : ShapeDecoration(
                gradient: LinearGradient(
                  begin: const Alignment(-1, 0),
                  end: const Alignment(1.00, 0.00),
                  colors: isDarkMode
                      ? [
                          const Color(
                            0xFFF3E1C9,
                          ),
                          const Color(0xFFDECBB1),
                          const Color(0xFFEEDBC3),
                          const Color(
                            0xFFC5B195,
                          ),
                          const Color(0xFFB49F81)
                        ]
                      : [
                          const Color(0xFF10274A),
                          const Color(0xFF12294D),
                          const Color(0xFF162F56),
                          const Color(0xFF1B3865),
                          const Color(0xFF1C3B6A)
                        ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(10),
                ),
              ),
        child: Center(
          child: CommonTextWidget(
            color: isDarkMode
                ? isFromRedButton
                    ? textColor
                    : AppConstants.black
                : isFromRedButton
                    ? textColor
                    : AppConstants.white,
            text: text,
            fontWeight: fontWeight,
            fontSize: fontSize ?? 16,
          ),
        ),
      ),
    );
  }
}

class CommonTextFormField extends StatelessWidget {
  final Color bgColor, borderColor;
  final String hintText;
  final Color hintTextColor;
  final Widget? prefixIcon;
  final Color color;
  final bool noBordr;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final int? maxLength;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? contentPadding;
  final bool obscureText;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final bool enabled;
  final bool readOnly;
  final double radius;
  final int? minLine;
  final int? maxLine;
  final FocusNode? focusNode;
  final bool isFromChat;
  final void Function(String)? onChanged;

  const CommonTextFormField({
    this.noBordr = false,
    this.borderColor = Colors.black12,
    super.key,
    required this.bgColor,
    required this.hintText,
    this.hintTextColor = AppConstants.tInactive,
    this.color = AppConstants.black,
    required this.keyboardType,
    required this.textInputAction,
    this.validator,
    this.maxLength,
    required this.controller,
    this.contentPadding = const EdgeInsets.only(left: 10),
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.focusNode,
    this.enabled = true,
    this.readOnly = false,
    this.radius = 10,
    this.minLine,
    this.maxLine,
    this.isFromChat = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      onTap: onTap,
      style: TextStyle(
        color: color,
        fontSize: 14,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      textInputAction: textInputAction,
      enabled: enabled,
      focusNode: focusNode,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        counterText: '',
        contentPadding: contentPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: noBordr
              ? BorderSide.none
              : BorderSide(
                  color: borderColor,
                ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: noBordr
              ? BorderSide.none
              : BorderSide(
                  color: borderColor,
                ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: noBordr
              ? BorderSide.none
              : BorderSide(
                  color: borderColor,
                ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: noBordr
              ? BorderSide.none
              : BorderSide(
                  color: borderColor,
                ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        suffixIcon: suffixIcon,
        fillColor: bgColor,
        filled: true,
        labelText: hintText,
        labelStyle: const TextStyle(
          color: AppConstants.black40,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
      validator: validator,
      maxLength: maxLength,
      controller: controller,
      readOnly: readOnly,
      minLines: minLine,
      maxLines: maxLine,
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CommonTextFormField(
      bgColor: AppConstants.transparent,
      hintText: "Search...",
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      controller: TextEditingController(),
      prefixIcon: const Icon(
        Icons.search,
        color: AppConstants.black40,
        size: 18,
      ),
      suffixIcon: const Icon(
        Icons.mic_rounded,
        size: 18,
        color: AppConstants.black40,
      ),
    );
  }
}

class CustomBannerWidget extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;

  const CustomBannerWidget({
    super.key,
    required this.message,
    this.backgroundColor = AppConstants.red,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Responsive.height * 4,
        left: Responsive.width * 5,
        right: Responsive.width * 5,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16),
      child: CommonTextWidget(
        color: Colors.white,
        text: message,
        fontSize: 14,
      ),
    );
  }
}

Future<dynamic> successPopUp({
  required BuildContext context,
  required String title,
  required String content,
  required void Function()? ontap,
  required String image,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          height: Responsive.height * 50,
          width: Responsive.width * 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: 100,
                width: 100,
              ),
              const SizeBoxH(20),
              CommonTextWidget(
                text: title,
                color: Theme.of(context).primaryColorDark,
                fontSize: 26,
                fontWeight: FontWeight.w700,
                height: 0.05,
              ),
              const SizeBoxH(20),
              CommonTextWidget(
                text: content,
                color: const Color(0xFF8390A1),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              const SizeBoxH(20),
              CommonButton(
                text: "Back",
                height: Responsive.height * 6,
                isDarkMode: false,
                ontap: ontap,
              ),
            ],
          ),
        ),
      );
    },
  );
}

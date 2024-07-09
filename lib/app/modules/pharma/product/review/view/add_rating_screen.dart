import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/home%20screen/view%20model/theme_provider.dart';
import 'package:sophwe_newmodule/app/modules/pharma/product/review/widget/review_user_captured_product_image_widget.dart';

import '../../../../../helpers/extentions.dart';
import '../../../../../helpers/size_box.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../widgets/common_widgets.dart';
import '../view model/raing_provider.dart';

class WriteReviewScreen extends StatefulWidget {
  final String? productId;
  const WriteReviewScreen({super.key, this.productId});

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

RatingProvider? ratingProvider;

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  TextEditingController reviewController = TextEditingController();
  @override
  void initState() {
    super.initState();
    ratingProvider = context.read<RatingProvider>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ratingProvider?.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: isDarkModeOn ? AppConstants.black : AppConstants.white,
        appBar: AppBar(
          title: CommonTextWidget(
            color: isDarkModeOn ? AppConstants.white : AppConstants.black,
            text: "Reviews",
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
          surfaceTintColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizeBoxH(20),
              CommonTextWidget(
                color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                text:
                    "Please write Overall level of satisfaction with your shipping/ Delivery Service",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              const SizeBoxH(20),
              Selector<RatingProvider, int>(
                selector: (p0, provider) => provider.selectedRate,
                builder: (context, value, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CommonInkwell(
                      onTap: () {
                        ratingProvider?.updateRate(1);
                      },
                      child: Icon(
                        value >= 1 ? Icons.star : Icons.star_border_outlined,
                        size: 37,
                        color: value >= 1
                            ? isDarkModeOn
                                ? AppConstants.commonGold
                                : AppConstants.darkBlue
                            : AppConstants.black40,
                      ),
                    ),
                    const SizeBoxV(5),
                    CommonInkwell(
                      onTap: () {
                        ratingProvider?.updateRate(2);
                      },
                      child: Icon(
                        value >= 2 ? Icons.star : Icons.star_border_outlined,
                        size: 37,
                        color: value >= 2
                            ? isDarkModeOn
                                ? AppConstants.commonGold
                                : AppConstants.darkBlue
                            : AppConstants.black40,
                      ),
                    ),
                    const SizeBoxV(5),
                    CommonInkwell(
                      onTap: () {
                        ratingProvider?.updateRate(3);
                      },
                      child: Icon(
                        value >= 3 ? Icons.star : Icons.star_border_outlined,
                        size: 37,
                        color: value >= 3
                            ? isDarkModeOn
                                ? AppConstants.commonGold
                                : AppConstants.darkBlue
                            : AppConstants.black40,
                      ),
                    ),
                    const SizeBoxV(5),
                    CommonInkwell(
                      onTap: () {
                        ratingProvider?.updateRate(4);
                      },
                      child: Icon(
                        value >= 4 ? Icons.star : Icons.star_border_outlined,
                        size: 37,
                        color: value >= 4
                            ? isDarkModeOn
                                ? AppConstants.commonGold
                                : AppConstants.darkBlue
                            : AppConstants.black40,
                      ),
                    ),
                    const SizeBoxV(5),
                    CommonInkwell(
                      onTap: () {
                        ratingProvider?.updateRate(5);
                      },
                      child: Icon(
                        value >= 5 ? Icons.star : Icons.star_border_outlined,
                        size: 37,
                        color: value >= 5
                            ? isDarkModeOn
                                ? AppConstants.commonGold
                                : AppConstants.darkBlue
                            : AppConstants.black40,
                      ),
                    ),
                    const SizeBoxV(5),
                    CommonTextWidget(
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      text: "$value",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              const SizeBoxH(40),
              CommonTextWidget(
                color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                text: "Write Your Review",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              const SizeBoxH(20),
              Expanded(
                child: TextField(
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  controller: reviewController,
                  maxLines: null,
                  minLines: 11,
                  scrollPadding: EdgeInsets.zero,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    color:
                        isDarkModeOn ? AppConstants.white : AppConstants.black,
                    fontSize: 12,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: isDarkModeOn
                            ? AppConstants.white
                            : AppConstants.black,
                        width: 1,
                      ),
                    ),
                    fillColor: AppConstants.transparent,
                    filled: true,
                    hintText: "How can we improve?",
                    hintStyle: TextStyle(
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizeBoxH(20),
              CommonTextWidget(
                color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                text: "Add Photo",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              const SizeBoxH(15),
              SizedBox(
                height: 72,
                child: Selector<RatingProvider, int>(
                  selector: (p0, p1) => p1.item,
                  builder: (context, item, child) =>
                      Selector<RatingProvider, List<String>>(
                    selector: (p0, p1) => p1.addedImageList,
                    builder: (context, value, child) => ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (index < item) {
                            var data = value[index];
                            return ReviewUserCaptureProductiveWidget(
                              reviewImage: data,
                            );
                          } else {
                            return Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppConstants.black10,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: IconButton(
                                  onPressed: () {
                                    ratingProvider?.addImage(false, context);
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: AppConstants.black60,
                                    size: 40,
                                  )),
                            );
                          }
                        },
                        separatorBuilder: (context, index) =>
                            const SizeBoxV(10),
                        itemCount: item + 1),
                  ),
                ),
              ),
              const Spacer(),
              CommonButton(
                text: "Submit",
                width: Responsive.width * 100,
                height: Responsive.height * 6,
                isDarkMode: isDarkModeOn,
                ontap: () {
                  ratingProvider?.postReviewFn(
                    context: context,
                    productId: widget.productId ?? '',
                    review: reviewController.text,
                    clear: () => reviewController.clear(),
                  );
                },
              ),
              const SizeBoxH(15)
            ],
          ),
        ),
      ),
    );
  }
}

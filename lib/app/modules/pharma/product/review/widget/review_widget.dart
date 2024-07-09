import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/extentions.dart';
import '../../../../../helpers/size_box.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_images.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../home/home screen/view model/theme_provider.dart';
import '../model/get_review_model.dart';

class ReviewWidget extends StatelessWidget {
  final Review? review;
  final bool isDarkModeOn;
  const ReviewWidget({
    super.key,
    this.review,
    required this.isDarkModeOn,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.width * 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: CircleAvatar(
              radius: 35,
              child: CachedImageWidget(
                height: 50,
                width: 50,
                imageUrl: review?.user?.details?.profilePicture ?? "",
                borderRadius: BorderRadius.circular(35),
              ),
            ),
            title: CommonTextWidget(
              align: TextAlign.start,
              color: isDarkModeOn ? AppConstants.white : AppConstants.black,
              text: review?.user?.name ?? " Name",
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
            subtitle: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: buildStars(
                  review?.rating ?? 0,
                ),
              ),
            ),
          ),
          const SizeBoxH(10),
          CommonTextWidget(
            align: TextAlign.start,
            color: isDarkModeOn
                ? AppConstants.white.withOpacity(0.6)
                : AppConstants.black60,
            text: review?.review ?? "",
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          Visibility(
            visible: review?.images?.isNotEmpty ?? false,
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              height: 72,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final image = review?.images?[index];
                  return CachedImageWidget(
                    imageUrl: image ??
                        "https://t4.ftcdn.net/jpg/04/95/28/65/240_F_495286577_rpsT2Shmr6g81hOhGXALhxWOfx1vOQBa.jpg",
                    height: 70,
                    width: 70,
                    borderRadius: BorderRadius.circular(10),
                  );
                },
                separatorBuilder: (context, index) => const SizeBoxV(10),
                itemCount: review?.images?.length ?? 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildStars(num rating) {
    List<Widget> stars = [];
    for (num i = 0; i < rating; i++) {
      stars.add(const Icon(
        Icons.star,
        color: Colors.amber,
        size: 16,
      ));
    }
    return stars;
  }
}

class ReviewUserCaptureProductImageWidget extends StatelessWidget {
  final String? reviewImage;
  const ReviewUserCaptureProductImageWidget({super.key, this.reviewImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
          color: context.watch<ThemeProvider>().isDarkModeOn == true
              ? AppConstants.black
              : const Color(0xFFF9F9FB),
          borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: Image.network(
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              AppImages.noFavouritesImage,
              fit: BoxFit.fill,
            );
          },
          reviewImage ?? "",
        ),
      ),
    );
  }
}

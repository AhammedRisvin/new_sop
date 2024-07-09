import 'package:flutter/material.dart';

import '../../../../helpers/extentions.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../widgets/common_widgets.dart';
import 'star_and_review_widgets.dart';

class ProductImageContainer extends StatelessWidget {
  final bool isEmpty;
  final bool reviewRight;
  final String? img;
  final String? cookingTime;
  const ProductImageContainer(
      {this.isEmpty = false,
      this.reviewRight = false,
      super.key,
      this.img,
      this.cookingTime});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedImageWidget(
          imageUrl:
              'https://t4.ftcdn.net/jpg/04/95/28/65/240_F_495286577_rpsT2Shmr6g81hOhGXALhxWOfx1vOQBa.jpg',
          height: Responsive.height * 12,
          width: Responsive.width * 45,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        isEmpty
            ? const SizedBox.shrink()
            : reviewRight
                ? const Positioned(
                    top: 7, right: 10, child: StarReviewContainer())
                : Positioned(
                    top: 7,
                    left: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff272626),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.schedule,
                                color: AppConstants.darkPrimaryColor,
                                size: 18,
                              ),
                              CommonTextWidget(
                                color: AppConstants.white,
                                text: '25 min',
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        SizeBoxV(Responsive.width * 15),
                        Image.asset(
                          AppImages.cartImg,
                          width: 30,
                          height: 30,
                          color: AppConstants.darkBlue,
                        )
                      ],
                    ),
                  )
      ],
    );
  }
}

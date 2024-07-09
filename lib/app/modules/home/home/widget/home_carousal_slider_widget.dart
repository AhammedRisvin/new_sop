import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sophwe_newmodule/app/modules/home/home/model/get_home_data_model.dart';

import '../../../../helpers/extentions.dart';
import '../../../../utils/app_constants.dart';
import '../../../widgets/common_widgets.dart';

class CarousalSliderWidget extends StatelessWidget {
  const CarousalSliderWidget({
    super.key,
    this.data,
  });

  final List<BannerData>? data;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.5,
        enlargeCenterPage: true,
      ),
      items: List.generate(
        data?.length ?? 0,
        (index) {
          final data = this.data?[index];
          return Container(
            width: Responsive.width * 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppConstants.black10,
              ),
            ),
            child: CachedImageWidget(
              imageUrl: data?.image ??
                  "https://t4.ftcdn.net/jpg/04/95/28/65/240_F_495286577_rpsT2Shmr6g81hOhGXALhxWOfx1vOQBa.jpg",
              width: Responsive.width * 100,
              height: Responsive.height * 10,
              borderRadius: BorderRadius.circular(20),
            ),
          );
        },
      ),
    );
  }
}

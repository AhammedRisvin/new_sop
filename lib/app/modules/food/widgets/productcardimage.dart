import 'package:flutter/material.dart';

import '../../../helpers/extentions.dart';
import '../../widgets/common_widgets.dart';

class ProductCardImage extends StatelessWidget {
  final bool? isWhishlist;
  final String url;
  final double radius;
  final bool isShowWhishlist;
  const ProductCardImage(
      {this.isWhishlist,
      super.key,
      this.radius = 20,
      this.isShowWhishlist = true,
      this.url = ""});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedImageWidget(
            imageUrl: url,
            height: Responsive.height * 14,
            width: Responsive.width * 45,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius))),
      ],
    );
  }
}

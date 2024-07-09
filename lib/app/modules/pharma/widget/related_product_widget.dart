import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../helpers/app_router.dart';
import '../../../helpers/extentions.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../widgets/common_widgets.dart';
import '../home/home screen/widget/product_listing_widget.dart';
import '../product/product details/view model/detailed_product_view_provider.dart';

class RelatedProductWidget extends StatelessWidget {
  const RelatedProductWidget({
    super.key,
    required this.isDarkModeOn,
    required this.provider,
  });

  final bool isDarkModeOn;
  final DetailedProductViewProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextWidget(
          color: isDarkModeOn ? AppConstants.white : AppConstants.black,
          text: "Related Products",
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        SizeBoxH(Responsive.height * 0.5),
        CommonTextWidget(
          color: isDarkModeOn ? AppConstants.tInactive : AppConstants.tInactive,
          text: "People usually order these as well",
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        SizeBoxH(Responsive.height * 1),
        SizedBox(
          height: Responsive.height * 30,
          child: ListView.separated(
            itemBuilder: (context, index) {
              final relatedProducts = provider.model.relatedProducts?[index];
              return Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Column(
                  children: [
                    const SizeBoxH(10),
                    CommonProductListingWidget(
                      isDarkModeOn: isDarkModeOn,
                      onTap: () {
                        context.pushReplacementNamed(
                            AppRouter.productDetailsScreen,
                            queryParameters: {
                              "productLink": relatedProducts?.link ?? "",
                            });
                      },
                      isFromListView: true,
                      width: Responsive.width * 48,
                      data: relatedProducts,
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizeBoxV(10),
            itemCount: provider.model.relatedProducts?.length ?? 0,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
          ),
        ),
      ],
    );
  }
}

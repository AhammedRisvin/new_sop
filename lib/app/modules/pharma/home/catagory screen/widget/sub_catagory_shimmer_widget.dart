import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../helpers/size_box.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../widgets/common_widgets.dart';

class SubCatagoryShimmerWidget extends StatelessWidget {
  const SubCatagoryShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppConstants.white,
                  border: Border.all(
                    color: AppConstants.darkBlue,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: const Center(
                  child: CommonTextWidget(
                    color: AppConstants.black,
                    text: "",
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizeBoxV(10),
          itemCount: 4),
    );
  }
}

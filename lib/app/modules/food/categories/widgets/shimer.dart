import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/home%20screen/view%20model/theme_provider.dart';

import '../../../../helpers/extentions.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';

class CategoryPageShimmer extends StatelessWidget {
  const CategoryPageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 4,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 5 / 5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return Selector<ThemeProvider, bool>(
            selector: (p0, p1) => p1.isDarkModeOn,
            builder: (context, isDarkModeOn, _) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                    color: isDarkModeOn
                        ? const Color(0xff2B2B2B)
                        : AppConstants.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 11, vertical: 12),
                  child: Column(
                    children: [
                      Container(
                        height: Responsive.height * 10,
                        width: Responsive.width * 22,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      SizeBoxH(Responsive.height * 1.5),
                      Container(
                        height: 16,
                        color: Colors.grey[400],
                      ),
                      SizeBoxH(Responsive.height * 0.5),
                      Container(
                        height: 10,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}

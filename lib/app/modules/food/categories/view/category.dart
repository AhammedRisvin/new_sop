import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/app_router.dart';
import 'package:sophwe_newmodule/app/helpers/extentions.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/modules/food/widgets/searchwidgets.dart';
import 'package:sophwe_newmodule/app/modules/widgets/common_widgets.dart';
import 'package:sophwe_newmodule/app/utils/app_constants.dart';

import '../../../../utils/food/food_enums.dart';
import '../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../subcategory/view_model/sub_category_provider.dart';
import '../../widgets/carousel_widgets.dart';
import '../../widgets/common_app_bar.dart';
import '../widgets/shimer.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SubcategoryProvider>().getFoodCategirysFnc(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
        selector: (_, value) => value.isDarkModeOn,
        builder: (context, isDarkModeOn, _) {
          return Scaffold(
            backgroundColor:
                isDarkModeOn ? AppConstants.black : AppConstants.white,
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
              preferredSize:
                  Size(Responsive.width * 100, Responsive.height * 6),
              child: const CommonAppBarWidgets(title: 'Categories'),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextWidget(
                            color: isDarkModeOn
                                ? AppConstants.white
                                : AppConstants.black,
                            text: 'Find your Healthy food',
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                        SizeBoxH(Responsive.height * 1.5),
                        const Searchwidgets(),
                      ],
                    ),
                  ),
                  SizeBoxH(Responsive.height * 1.5),
                  CarouserlWidgets(
                    hieght: Responsive.height * 17,
                  ),
                  SizeBoxH(Responsive.height * 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Consumer<SubcategoryProvider>(
                        builder: (context, obj, _) {
                      return obj.getFoodCategirysStatus ==
                              GetFoodCategirysStatus.loading
                          ? const CategoryPageShimmer()
                          : obj.categoryModel.subCategories == null ||
                                  obj.categoryModel.subCategories!.isEmpty
                              ? const Text('Nocategorys')
                              : GridView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      obj.categoryModel.subCategories?.length ??
                                          0,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 5 / 5,
                                          crossAxisSpacing: 16,
                                          mainAxisSpacing: 16,
                                          crossAxisCount: 2),
                                  itemBuilder: (context, index) {
                                    final product =
                                        obj.categoryModel.subCategories?[index];
                                    return CommonInkwell(
                                      onTap: () {
                                        context.push(
                                            AppRouter.foodSubCategoryScreen);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: isDarkModeOn
                                              ? const Color(0xff2B2B2B)
                                              : AppConstants.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color(
                                                  0x26000000), // Equivalent to #00000026
                                              offset: Offset(0, 0),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 11, vertical: 12),
                                        child: Column(
                                          children: [
                                            CachedImageWidget(
                                              imageUrl: product?.image ?? '',
                                              height: Responsive.height * 10,
                                              width: Responsive.width * 22,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            SizeBoxH(Responsive.height * 1.5),
                                            CommonTextWidget(
                                              color: isDarkModeOn
                                                  ? AppConstants
                                                      .darkPrimaryColor
                                                  : AppConstants.black,
                                              text: product?.name ?? '',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            CommonTextWidget(
                                              color: isDarkModeOn
                                                  ? AppConstants.white
                                                  : AppConstants.black,
                                              text: product?.description ?? '',
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              align: TextAlign.center,
                                              overFlow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                    }),
                  )
                ],
              ),
            ),
          );
        });
  }
}

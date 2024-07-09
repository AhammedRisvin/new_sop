import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sophwe_newmodule/app/modules/food/widgets/searchwidgets.dart';

import '../../../../helpers/app_router.dart';
import '../../../../helpers/extentions.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/food/food_enums.dart';
import '../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../widgets/common_widgets.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/items_card.dart';
import '../view_model/sub_category_provider.dart';

class SubcategoryScreen extends StatefulWidget {
  const SubcategoryScreen({super.key});

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    context.read<SubcategoryProvider>().getFoodCategirysFnc(context: context);
    context.read<SubcategoryProvider>().getFoodProductsFnc(
        context: context, subCategoryId: '664ef14898e5c4872874feea');
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (_, value) => value.isDarkModeOn,
      builder: (context, isDarkModeOn, _) {
        return Scaffold(
          backgroundColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          appBar: PreferredSize(
            preferredSize: Size(Responsive.width * 100, Responsive.height * 6),
            child: const CommonAppBarWidgets(title: 'Diet Food'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizeBoxH(Responsive.height * 2),
                  CommonInkwell(
                      onTap: () {
                        context.push(AppRouter.foodSearchScreen);
                      },
                      child: const Searchwidgets()),
                  SizeBoxH(Responsive.height * 2),
                  Builder(builder: (context) {
                    return SizedBox(
                      height: Responsive.height * 4,
                      child: Consumer<SubcategoryProvider>(
                        builder: (context, obj, _) {
                          return obj.getFoodCategirysStatus ==
                                  GetFoodCategirysStatus.loading
                              ? buildShimmer()
                              : obj.categoryModel.subCategories == null ||
                                      obj.categoryModel.subCategories!.isEmpty
                                  ? const Text('Nocategorys')
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return CommonInkwell(
                                          onTap: () {
                                            obj.categoryIndexFnc(value: index);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: obj.categoryIndex == index
                                                  ? isDarkModeOn
                                                      ? AppConstants
                                                          .darkPrimaryColor
                                                      : AppConstants.darkBlue
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: isDarkModeOn
                                                      ? AppConstants.white
                                                      : AppConstants.darkBlue,
                                                  width: 2),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 7, horizontal: 10),
                                            child: Center(
                                              child: CommonTextWidget(
                                                  color: isDarkModeOn
                                                      ? AppConstants.white
                                                      : AppConstants
                                                          .categoryGrey,
                                                  text: obj
                                                          .categoryModel
                                                          .subCategories?[index]
                                                          .name ??
                                                      '',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  overFlow: TextOverflow.fade,
                                                  maxLines: 2,
                                                  letterSpacing: -0.3,
                                                  height: 5),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizeBoxV(Responsive.width * 2),
                                      itemCount: obj.categoryModel.subCategories
                                              ?.length ??
                                          0);
                        },
                      ),
                    );
                  }),
                  SizeBoxH(Responsive.height * 2),
                  Consumer<SubcategoryProvider>(builder: (context, obj, _) {
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: obj.foodProductModel.products?.length ?? 0,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: Responsive.height * 0.081,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return ItemsCard(
                          product: obj.foodProductModel.products?[index],
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            margin: const EdgeInsets.symmetric(horizontal: 5),
          );
        },
        separatorBuilder: (context, index) =>
            SizedBox(width: Responsive.width * 2),
        itemCount: 6, // Number of shimmer items you want to show
      ),
    );
  }
}

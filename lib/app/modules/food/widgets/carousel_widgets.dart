import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../helpers/extentions.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../widgets/common_widgets.dart';
import '../home/view_model/food_home.dart';

class CarouserlWidgets extends StatefulWidget {
  final double? hieght;
  final String? imageUrl;
  final int? caroselLength;
  const CarouserlWidgets(
      {this.hieght, this.imageUrl, this.caroselLength, super.key});

  @override
  State<CarouserlWidgets> createState() => _CarouserlWidgetsState();
}

class _CarouserlWidgetsState extends State<CarouserlWidgets> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.hieght ?? Responsive.height * 15,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: Responsive.width * 100,
          child: PageView.builder(
            controller: _pageController,
            itemCount: 3,
            onPageChanged: (value) =>
                context.read<FoodHomeProvider>().nextPage(value: value),
            itemBuilder: (context, index) {
              return CachedImageWidget(
                imageUrl: widget.imageUrl ?? '',
                height: widget.hieght ?? Responsive.height * 15,
                width: Responsive.width * 100,
                borderRadius: BorderRadius.circular(20),
              );
            },
          ),
        ),
        SizeBoxH(Responsive.height * 1),
        DotListWidget(
          caroselLength: widget.caroselLength,
        )
      ],
    );
  }
}

class DotListWidget extends StatelessWidget {
  final int? caroselLength;

  const DotListWidget({
    super.key,
    this.caroselLength,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return SizedBox(
        height: 8,
        width: Responsive.width * 100,
        child: Selector<FoodHomeProvider, int>(
          selector: (p0, p1) => p1.caroselPageChange,
          builder: (context, value, child) => Center(
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return DotWidget(
                      color: value == index
                          ? AppConstants.black
                          : const Color(0x33000000));
                },
                separatorBuilder: (context, index) => const SizeBoxV(8),
                itemCount: caroselLength ?? 0),
          ),
        ),
      );
    });
  }
}

class DotWidget extends StatelessWidget {
  final Color color;
  const DotWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
      ),
    );
  }
}

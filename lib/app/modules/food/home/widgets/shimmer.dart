import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../helpers/extentions.dart';

class CategorysShimmer extends StatelessWidget {
  const CategorysShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            children: [
              Container(
                height: Responsive.height * 10,
                width: Responsive.width * 22,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: Responsive.height * 0.7),
              Container(
                width: Responsive.width * 14,
                height: 16, // Adjust this height as needed
                color: Colors.white,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) =>
          SizedBox(width: Responsive.width * 5),
      itemCount: 10, // The number of shimmer items you want to show
    );
  }
}

class RecommendedShimmer extends StatelessWidget {
  const RecommendedShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: 20),
      separatorBuilder: (context, index) => const SizedBox(width: 20),
      itemCount: 5, // Number of shimmer items you want to show
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            children: [
              Container(
                width: Responsive.width * 45,
                height: Responsive.height * 20,
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 8.0),
              ),
              Container(
                width: Responsive.width * 45,
                height: 20,
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 8.0),
              ),
              Container(
                width: Responsive.width * 30,
                height: 20,
                color: Colors.white,
              ),
            ],
          ),
        );
      },
    );
  }
}

class CarouselShimmer extends StatelessWidget {
  final double height;
  const CarouselShimmer({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

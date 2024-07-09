import 'package:sophwe_newmodule/app/modules/home/home/model/get_home_data_model.dart';

class GetProductModel {
  bool? success;
  String? message;
  List<LatestProduct>? products;
  int? totalProducts;

  GetProductModel({
    this.success,
    this.message,
    this.products,
    this.totalProducts,
  });

  factory GetProductModel.fromJson(Map<String, dynamic> json) =>
      GetProductModel(
        success: json["success"],
        message: json["message"],
        products: json["products"] == null
            ? []
            : List<LatestProduct>.from(
                json["products"]!.map((x) => LatestProduct.fromJson(x))),
        totalProducts: json["totalProducts"],
      );
}

class Ratings {
  int? average;
  int? count;

  Ratings({
    this.average,
    this.count,
  });

  factory Ratings.fromJson(Map<String, dynamic> json) => Ratings(
        average: json["average"],
        count: json["count"],
      );
}

import '../../../../home/home/model/get_home_data_model.dart';

class GetPharmaHomeModel {
  bool? success;
  List<Category>? categories;
  List<LatestProduct>? latestProducts;

  GetPharmaHomeModel({
    this.success,
    this.categories,
    this.latestProducts,
  });

  factory GetPharmaHomeModel.fromJson(Map<String, dynamic> json) =>
      GetPharmaHomeModel(
        success: json["success"],
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
        latestProducts: json["latestProducts"] == null
            ? []
            : List<LatestProduct>.from(
                json["latestProducts"]!.map((x) => LatestProduct.fromJson(x))),
      );
}

class Category {
  String? id;
  String? name;
  List<SubCategory>? subCategories;
  String? image;
  List<dynamic>? brands;

  Category({
    this.id,
    this.name,
    this.subCategories,
    this.image,
    this.brands,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
        subCategories: json["subCategories"] == null
            ? []
            : List<SubCategory>.from(
                json["subCategories"]!.map((x) => SubCategory.fromJson(x))),
        image: json["image"],
        brands: json["brands"] == null
            ? []
            : List<dynamic>.from(json["brands"]!.map((x) => x)),
      );
}

class SubCategory {
  String? id;
  String? name;
  String? image;

  SubCategory({
    this.id,
    this.name,
    this.image,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
      );
}

class GetFoodCategoryModel {
  bool? success;
  String? message;
  List<SubCategory>? subCategories;

  GetFoodCategoryModel({
    this.success,
    this.message,
    this.subCategories,
  });

  factory GetFoodCategoryModel.fromJson(Map<String, dynamic> json) =>
      GetFoodCategoryModel(
        success: json["success"],
        message: json["message"],
        subCategories: json["subCategories"] == null
            ? []
            : List<SubCategory>.from(
                json["subCategories"]!.map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "subCategories": subCategories == null
            ? []
            : List<dynamic>.from(subCategories!.map((x) => x.toJson())),
      };
}

class SubCategory {
  String? name;
  String? description;
  String? category;
  String? image;

  SubCategory({
    this.name,
    this.description,
    this.category,
    this.image,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        name: json["name"],
        description: json["description"],
        category: json["category"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "category": category,
        "image": image,
      };
}

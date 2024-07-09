class GetSubCatagoryModel {
  bool? success;
  String? message;
  List<SubCategory>? subCategories;

  GetSubCatagoryModel({
    this.success,
    this.message,
    this.subCategories,
  });

  factory GetSubCatagoryModel.fromJson(Map<String, dynamic> json) =>
      GetSubCatagoryModel(
        success: json["success"],
        message: json["message"],
        subCategories: json["subCategories"] == null
            ? []
            : List<SubCategory>.from(
                json["subCategories"]!.map((x) => SubCategory.fromJson(x))),
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

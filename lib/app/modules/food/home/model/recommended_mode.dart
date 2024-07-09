class GetFoodRecommendedModel {
  bool? success;
  String? message;
  List<UpdatedProduct>? updatedProducts;

  GetFoodRecommendedModel({
    this.success,
    this.message,
    this.updatedProducts,
  });

  factory GetFoodRecommendedModel.fromJson(Map<String, dynamic> json) =>
      GetFoodRecommendedModel(
        success: json["success"],
        message: json["message"],
        updatedProducts: json["updatedProducts"] == null
            ? []
            : List<UpdatedProduct>.from(json["updatedProducts"]!
                .map((x) => UpdatedProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "updatedProducts": updatedProducts == null
            ? []
            : List<dynamic>.from(updatedProducts!.map((x) => x.toJson())),
      };
}

class UpdatedProduct {
  String? id;
  String? subCategory;
  String? name;
  Rating? rating;
  num? reviews;
  num? price;
  String? currencyCode;
  bool? inCart;
  bool? inWishlist;
  String? image;
  num? cookingTime;

  UpdatedProduct({
    this.id,
    this.subCategory,
    this.name,
    this.rating,
    this.reviews,
    this.price,
    this.currencyCode,
    this.inCart,
    this.inWishlist,
    this.image,
    this.cookingTime,
  });

  factory UpdatedProduct.fromJson(Map<String, dynamic> json) => UpdatedProduct(
        id: json["_id"],
        subCategory: json["subCategory"],
        name: json["name"],
        rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
        reviews: json["reviews"],
        price: json["price"],
        currencyCode: json["currencyCode"],
        inCart: json["inCart"],
        inWishlist: json["inWishlist"],
        image: json["image"],
        cookingTime: json["cookingTime"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "subCategory": subCategory,
        "name": name,
        "rating": rating?.toJson(),
        "reviews": reviews,
        "price": price,
        "currencyCode": currencyCode,
        "inCart": inCart,
        "inWishlist": inWishlist,
        "image": image,
        "cookingTime": cookingTime,
      };
}

class Rating {
  num? average;
  num? count;

  Rating({
    this.average,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        average: json["average"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "average": average,
        "count": count,
      };
}

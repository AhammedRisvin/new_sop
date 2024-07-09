class FoodProductModel {
  bool? success;
  String? message;
  List<Product>? products;
  int? totalProducts;

  FoodProductModel({
    this.success,
    this.message,
    this.products,
    this.totalProducts,
  });

  factory FoodProductModel.fromJson(Map<String, dynamic> json) =>
      FoodProductModel(
        success: json["success"],
        message: json["message"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
        totalProducts: json["totalProducts"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "totalProducts": totalProducts,
      };
}

class Product {
  Ratings? ratings;
  String? id;
  String? productName;
  String? description;
  int? offers;
  List<dynamic>? images;
  String? link;
  int? price;
  bool? wishlist;

  Product({
    this.ratings,
    this.id,
    this.productName,
    this.description,
    this.offers,
    this.images,
    this.link,
    this.price,
    this.wishlist,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        ratings:
            json["ratings"] == null ? null : Ratings.fromJson(json["ratings"]),
        id: json["_id"],
        productName: json["productName"],
        description: json["description"],
        offers: json["offers"],
        images: json["images"] == null
            ? []
            : List<dynamic>.from(json["images"]!.map((x) => x)),
        link: json["link"],
        price: json["price"],
        wishlist: json["wishlist"],
      );

  Map<String, dynamic> toJson() => {
        "ratings": ratings?.toJson(),
        "_id": id,
        "productName": productName,
        "description": description,
        "offers": offers,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "link": link,
        "price": price,
        "wishlist": wishlist,
      };
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

  Map<String, dynamic> toJson() => {
        "average": average,
        "count": count,
      };
}

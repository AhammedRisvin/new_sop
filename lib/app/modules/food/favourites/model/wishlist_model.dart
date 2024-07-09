class WhishListModel {
  bool? success;
  String? message;
  Wishlists? wishlists;

  WhishListModel({
    this.success,
    this.message,
    this.wishlists,
  });

  factory WhishListModel.fromJson(Map<String, dynamic> json) => WhishListModel(
        success: json["success"],
        message: json["message"],
        wishlists: json["wishlists"] == null
            ? null
            : Wishlists.fromJson(json["wishlists"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "wishlists": wishlists?.toJson(),
      };
}

class Wishlists {
  String? id;
  List<Product>? product;
  String? user;
  String? appId;
  String? section;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;

  Wishlists({
    this.id,
    this.product,
    this.user,
    this.appId,
    this.section,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Wishlists.fromJson(Map<String, dynamic> json) => Wishlists(
        id: json["_id"],
        product: json["product"] == null
            ? []
            : List<Product>.from(
                json["product"]!.map((x) => Product.fromJson(x))),
        user: json["user"],
        appId: json["appId"],
        section: json["section"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "product": product == null
            ? []
            : List<dynamic>.from(product!.map((x) => x.toJson())),
        "user": user,
        "appId": appId,
        "section": section,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Product {
  Ratings? ratings;
  String? id;
  String? productName;
  String? description;
  num? offers;
  num? price;
  String? image;
  String? link;

  Product({
    this.ratings,
    this.id,
    this.productName,
    this.description,
    this.offers,
    this.price,
    this.image,
    this.link,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        ratings:
            json["ratings"] == null ? null : Ratings.fromJson(json["ratings"]),
        id: json["_id"],
        productName: json["productName"],
        description: json["description"],
        offers: json["offers"],
        price: json["price"],
        image: json["image"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "ratings": ratings?.toJson(),
        "_id": id,
        "productName": productName,
        "description": description,
        "offers": offers,
        "price": price,
        "image": image,
        "link": link,
      };
}

class Ratings {
  num? average;
  num? count;

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

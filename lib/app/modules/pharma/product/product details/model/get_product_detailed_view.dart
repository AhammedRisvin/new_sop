import 'package:sophwe_newmodule/app/modules/home/home/model/get_home_data_model.dart';

class GetProductDetailViewModel {
  bool? success;
  String? message;
  Product? product;
  List<LatestProduct>? relatedProducts;

  GetProductDetailViewModel({
    this.success,
    this.message,
    this.product,
    this.relatedProducts,
  });

  factory GetProductDetailViewModel.fromJson(Map<String, dynamic> json) =>
      GetProductDetailViewModel(
        success: json["success"],
        message: json["message"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        relatedProducts: json["relatedProducts"] == null
            ? []
            : List<LatestProduct>.from(
                json["relatedProducts"]!.map((x) => LatestProduct.fromJson(x))),
      );
}

class Product {
  Available? available;
  Ratings? ratings;
  String? id;
  String? productName;
  String? description;
  num? offers;
  List<String>? images;
  Section? section;
  String? category;
  num? price;
  num? discountPrice;
  String? currency;
  List<dynamic>? variants;
  List<Detail>? details;
  List<dynamic>? specifications;
  String? returnPolicy;
  List<dynamic>? reviews;
  List<Viewer>? viewers;
  String? link;
  bool? wishlist;
  bool? cart;
  bool? isAvailable;

  Product({
    this.available,
    this.ratings,
    this.id,
    this.productName,
    this.description,
    this.offers,
    this.images,
    this.section,
    this.category,
    this.price,
    this.discountPrice,
    this.currency,
    this.variants,
    this.details,
    this.specifications,
    this.returnPolicy,
    this.reviews,
    this.viewers,
    this.link,
    this.wishlist,
    this.cart,
    this.isAvailable,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        available: json["available"] == null
            ? null
            : Available.fromJson(json["available"]),
        ratings:
            json["ratings"] == null ? null : Ratings.fromJson(json["ratings"]),
        id: json["_id"],
        productName: json["productName"],
        description: json["description"],
        offers: json["offers"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        section:
            json["section"] == null ? null : Section.fromJson(json["section"]),
        category: json["category"],
        price: json["price"],
        discountPrice: json["discountPrice"],
        currency: json["currency"],
        variants: json["variants"] == null
            ? []
            : List<dynamic>.from(json["variants"]!.map((x) => x)),
        details: json["details"] == null
            ? []
            : List<Detail>.from(
                json["details"]!.map((x) => Detail.fromJson(x))),
        specifications: json["specifications"] == null
            ? []
            : List<dynamic>.from(json["specifications"]!.map((x) => x)),
        returnPolicy: json["returnPolicy"],
        reviews: json["reviews"] == null
            ? []
            : List<dynamic>.from(json["reviews"]!.map((x) => x)),
        viewers: json["viewers"] == null
            ? []
            : List<Viewer>.from(
                json["viewers"]!.map((x) => Viewer.fromJson(x))),
        link: json["link"],
        wishlist: json["wishlist"],
        cart: json["cart"],
        isAvailable: json["isAvailable"],
      );
}

class Available {
  bool? isAll;
  List<String>? countries;

  Available({
    this.isAll,
    this.countries,
  });

  factory Available.fromJson(Map<String, dynamic> json) => Available(
        isAll: json["isAll"],
        countries: json["countries"] == null
            ? []
            : List<String>.from(json["countries"]!.map((x) => x)),
      );
}

class Detail {
  String? size;
  num? quantity;
  num? price;
  String? id;

  Detail({
    this.size,
    this.quantity,
    this.price,
    this.id,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        size: json["size"],
        quantity: json["quantity"],
        price: json["price"],
        id: json["_id"],
      );
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
}

class Section {
  String? id;
  String? name;

  Section({
    this.id,
    this.name,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["_id"],
        name: json["name"],
      );
}

class Viewer {
  num? viewCount;
  String? country;
  String? id;
  String? user;

  Viewer({
    this.viewCount,
    this.country,
    this.id,
    this.user,
  });

  factory Viewer.fromJson(Map<String, dynamic> json) => Viewer(
        viewCount: json["viewCount"],
        country: json["country"],
        id: json["_id"],
        user: json["user"],
      );
}

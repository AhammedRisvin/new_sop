import 'package:sophwe_newmodule/app/modules/home/home/model/get_home_data_model.dart';

class FavouritesModel {
  bool? success;
  String? message;
  Wishlists? wishlists;

  FavouritesModel({
    this.success,
    this.message,
    this.wishlists,
  });

  factory FavouritesModel.fromJson(Map<String, dynamic> json) =>
      FavouritesModel(
        success: json["success"],
        message: json["message"],
        wishlists: json["wishlists"] == null
            ? null
            : Wishlists.fromJson(json["wishlists"]),
      );
}

class Wishlists {
  String? id;
  List<LatestProduct>? product;

  Wishlists({
    this.id,
    this.product,
  });

  factory Wishlists.fromJson(Map<String, dynamic> json) => Wishlists(
        id: json["_id"],
        product: json["product"] == null
            ? []
            : List<LatestProduct>.from(
                json["product"]!.map((x) => LatestProduct.fromJson(x))),
      );
}

// class Product {
//     Ratings? ratings;
//     String? id;
//     String? productName;
//     String? description;
//     int? offers;
//     List<String>? images;
//     String? section;
//     String? category;
//     double? price;
//     double? discountPrice;
//     String? currency;
//     String? link;

//     Product({
//         this.ratings,
//         this.id,
//         this.productName,
//         this.description,
//         this.offers,
//         this.images,
//         this.section,
//         this.category,
//         this.price,
//         this.discountPrice,
//         this.currency,
//         this.link,
//     });

//     factory Product.fromJson(Map<String, dynamic> json) => Product(
//         ratings: json["ratings"] == null ? null : Ratings.fromJson(json["ratings"]),
//         id: json["_id"],
//         productName: json["productName"],
//         description: json["description"],
//         offers: json["offers"],
//         images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
//         section: json["section"],
//         category: json["category"],
//         price: json["price"]?.toDouble(),
//         discountPrice: json["discountPrice"]?.toDouble(),
//         currency: json["currency"],
//         link: json["link"],
//     );
// }

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

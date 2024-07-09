class GetReviewModel {
  String? message;
  List<Review>? reviews;
  bool? hasPurchasedProduct;
  num? totalReview;
  num? totalAvg;
  RatingsCount? ratingsCount;

  GetReviewModel({
    this.message,
    this.reviews,
    this.hasPurchasedProduct,
    this.totalReview,
    this.totalAvg,
    this.ratingsCount,
  });

  factory GetReviewModel.fromJson(Map<String, dynamic> json) => GetReviewModel(
        message: json["message"],
        reviews: json["reviews"] == null
            ? []
            : List<Review>.from(
                json["reviews"]!.map((x) => Review.fromJson(x))),
        hasPurchasedProduct: json["hasPurchasedProduct"],
        totalReview: json["totalReview"],
        totalAvg: json["totalAvg"],
        ratingsCount: json["ratingsCount"] == null
            ? null
            : RatingsCount.fromJson(json["ratingsCount"]),
      );
}

class RatingsCount {
  num? the1;
  num? the2;
  num? the3;
  num? the4;
  num? the5;

  RatingsCount({
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.the5,
  });

  factory RatingsCount.fromJson(Map<String, dynamic> json) => RatingsCount(
        the1: json["1"],
        the2: json["2"],
        the3: json["3"],
        the4: json["4"],
        the5: json["5"],
      );
}

class Review {
  User? user;
  num? rating;
  String? review;
  List<String>? images;
  DateTime? date;
  String? id;

  Review({
    this.user,
    this.rating,
    this.review,
    this.images,
    this.date,
    this.id,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        rating: json["rating"],
        review: json["review"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
        id: json["_id"],
      );
}

class User {
  Details? details;
  String? id;
  String? name;

  User({
    this.details,
    this.id,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        details:
            json["details"] == null ? null : Details.fromJson(json["details"]),
        id: json["_id"],
        name: json["name"],
      );
}

class Details {
  String? profilePicture;

  Details({
    this.profilePicture,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        profilePicture: json["profilePicture"],
      );
}

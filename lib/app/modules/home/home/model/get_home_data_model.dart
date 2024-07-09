class GetHomeDataModel {
  String? message;
  List<LatestProduct>? latestProducts;
  String? useImage;
  String? userName;
  GetHomeDataModelLocation? location;
  List<RestaurentDatum>? restaurentData;
  List<BannerData>? bannerDatas;
  List<Section>? sections;

  GetHomeDataModel({
    this.message,
    this.latestProducts,
    this.useImage,
    this.userName,
    this.location,
    this.restaurentData,
    this.bannerDatas,
    this.sections,
  });

  factory GetHomeDataModel.fromJson(Map<String, dynamic> json) =>
      GetHomeDataModel(
        message: json["message"],
        latestProducts: json["latestProducts"] == null
            ? []
            : List<LatestProduct>.from(
                json["latestProducts"]!.map((x) => LatestProduct.fromJson(x))),
        useImage: json["useImage"],
        userName: json["userName"],
        location: json["location"] == null
            ? null
            : GetHomeDataModelLocation.fromJson(json["location"]),
        restaurentData: json["restaurentData"] == null
            ? []
            : List<RestaurentDatum>.from(json["restaurentData"]!
                .map((x) => RestaurentDatum.fromJson(x))),
        bannerDatas: json["bannerDatas"] == null
            ? []
            : List<BannerData>.from(
                json["bannerDatas"]!.map((x) => BannerData.fromJson(x))),
        sections: json["sections"] == null
            ? []
            : List<Section>.from(
                json["sections"]!.map((x) => Section.fromJson(x))),
      );
}

class BannerData {
  String? image;
  String? navigationLink;
  String? navigationType;

  BannerData({
    this.image,
    this.navigationLink,
    this.navigationType,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
        image: json["image"],
        navigationLink: json["navigationLink"],
        navigationType: json["navigationType"],
      );
}

class LatestProduct {
  String? id;
  String? productName;
  String? description;
  List<String>? images;
  Ratings? ratings;
  num? offers;
  num? price;
  String? currency;
  String? section;
  String? category;
  num? discountPrice;
  String? link;
  bool? wishlist;
  String? productId;
  String? productLink;
  String? size;
  String? sizeId;
  num? quantity;
  num? availableQuantity;
  bool? isAvailable;
  num? pricePerItem;

  LatestProduct({
    this.id,
    this.productName,
    this.description,
    this.images,
    this.ratings,
    this.offers,
    this.price,
    this.currency,
    this.section,
    this.category,
    this.discountPrice,
    this.link,
    this.wishlist,
    this.productId,
    this.productLink,
    this.size,
    this.sizeId,
    this.quantity,
    this.availableQuantity,
    this.isAvailable,
    this.pricePerItem,
  });

  factory LatestProduct.fromJson(Map<String, dynamic> json) => LatestProduct(
        id: json["_id"],
        productName: json["productName"],
        description: json["description"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        ratings:
            json["ratings"] == null ? null : Ratings.fromJson(json["ratings"]),
        offers: json["offers"],
        price: json["price"],
        currency: json["currency"],
        section: json["section"],
        category: json["category"],
        discountPrice: json["discountPrice"],
        link: json["link"],
        wishlist: json["wishlist"],
        productId: json["productId"],
        productLink: json["productLink"],
        size: json["size"],
        sizeId: json["sizeId"],
        quantity: json["quantity"],
        availableQuantity: json["availableQuantity"],
        isAvailable: json["isAvailable"],
        pricePerItem: json["pricePerItem"],
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

class GetHomeDataModelLocation {
  GetHomeDataModelLocation();

  factory GetHomeDataModelLocation.fromJson(Map<String, dynamic> json) =>
      GetHomeDataModelLocation();
}

class RestaurentDatum {
  String? id;
  String? name;
  RestaurentDatumLocation? location;
  String? image;
  num? ratings;

  RestaurentDatum({
    this.id,
    this.name,
    this.location,
    this.image,
    this.ratings,
  });

  factory RestaurentDatum.fromJson(Map<String, dynamic> json) =>
      RestaurentDatum(
        id: json["_id"],
        name: json["name"],
        location: json["location"] == null
            ? null
            : RestaurentDatumLocation.fromJson(json["location"]),
        image: json["image"],
        ratings: json["ratings"],
      );
}

class RestaurentDatumLocation {
  String? longitude;
  String? latitude;

  RestaurentDatumLocation({
    this.longitude,
    this.latitude,
  });

  factory RestaurentDatumLocation.fromJson(Map<String, dynamic> json) =>
      RestaurentDatumLocation(
        longitude: json["longitude"],
        latitude: json["latitude"],
      );
}

class Section {
  String? id;
  String? name;
  String? image;

  Section({
    this.id,
    this.name,
    this.image,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
      );
}

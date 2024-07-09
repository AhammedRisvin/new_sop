class GetFoodcarouselModel {
  bool? success;
  String? message;
  List<Banner>? topBanners;
  List<Banner>? bottomBanners;

  GetFoodcarouselModel({
    this.success,
    this.message,
    this.topBanners,
    this.bottomBanners,
  });

  factory GetFoodcarouselModel.fromJson(Map<String, dynamic> json) =>
      GetFoodcarouselModel(
        success: json["success"],
        message: json["message"],
        topBanners: json["topBanners"] == null
            ? []
            : List<Banner>.from(
                json["topBanners"]!.map((x) => Banner.fromJson(x))),
        bottomBanners: json["bottomBanners"] == null
            ? []
            : List<Banner>.from(
                json["bottomBanners"]!.map((x) => Banner.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "topBanners": topBanners == null
            ? []
            : List<dynamic>.from(topBanners!.map((x) => x.toJson())),
        "bottomBanners": bottomBanners == null
            ? []
            : List<dynamic>.from(bottomBanners!.map((x) => x.toJson())),
      };
}

class Banner {
  String? id;
  String? appId;
  String? banner;
  String? product;
  String? subCategory;
  String? position;
  String? section;
  String? page;
  DateTime? validity;
  String? vendor;
  String? status;
  String? paymentStatus;
  DateTime? startDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;

  Banner({
    this.id,
    this.appId,
    this.banner,
    this.product,
    this.subCategory,
    this.position,
    this.section,
    this.page,
    this.validity,
    this.vendor,
    this.status,
    this.paymentStatus,
    this.startDate,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        id: json["_id"],
        appId: json["appId"],
        banner: json["banner"],
        product: json["product"],
        subCategory: json["subCategory"],
        position: json["position"],
        section: json["section"],
        page: json["page"],
        validity:
            json["validity"] == null ? null : DateTime.parse(json["validity"]),
        vendor: json["vendor"],
        status: json["status"],
        paymentStatus: json["paymentStatus"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
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
        "appId": appId,
        "banner": banner,
        "product": product,
        "subCategory": subCategory,
        "position": position,
        "section": section,
        "page": page,
        "validity": validity?.toIso8601String(),
        "vendor": vendor,
        "status": status,
        "paymentStatus": paymentStatus,
        "startDate": startDate?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

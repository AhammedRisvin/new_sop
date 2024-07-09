class GetOrderHistoryModel {
  String? message;
  List<Response>? response;
  String? currency;
  String? currencySymbol;

  GetOrderHistoryModel({
    this.message,
    this.response,
    this.currency,
    this.currencySymbol,
  });

  factory GetOrderHistoryModel.fromJson(Map<String, dynamic> json) =>
      GetOrderHistoryModel(
        message: json["message"],
        response: json["response"] == null
            ? []
            : List<Response>.from(
                json["response"]!.map((x) => Response.fromJson(x))),
        currency: json["currency"],
        currencySymbol: json["currencySymbol"],
      );
}

class Response {
  String? bookingId;
  String? productId;
  String? sizeId;
  String? productName;
  String? productLink;
  List<String>? images;
  String? size;
  List<ShippingInfo>? shippingInfo;
  int? quantity;
  double? price;
  int? discount;
  double? total;
  String? orderStatus;
  String? estimatedDeliveryTime;
  bool? isReturn;

  Response({
    this.bookingId,
    this.productId,
    this.sizeId,
    this.productName,
    this.productLink,
    this.images,
    this.size,
    this.shippingInfo,
    this.quantity,
    this.price,
    this.discount,
    this.total,
    this.orderStatus,
    this.estimatedDeliveryTime,
    this.isReturn,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        bookingId: json["bookingId"],
        productId: json["productId"],
        sizeId: json["sizeId"],
        productName: json["productName"],
        productLink: json["productLink"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        size: json["size"],
        shippingInfo: json["shippingInfo"] == null
            ? []
            : List<ShippingInfo>.from(
                json["shippingInfo"]!.map((x) => ShippingInfo.fromJson(x))),
        quantity: json["quantity"],
        price: json["price"]?.toDouble(),
        discount: json["discount"],
        total: json["total"]?.toDouble(),
        orderStatus: json["orderStatus"],
        estimatedDeliveryTime: json["estimatedDeliveryTime"],
        isReturn: json["isReturn"],
      );
}

class ShippingInfo {
  String? status;
  DateTime? date;
  dynamic message;
  String? id;

  ShippingInfo({
    this.status,
    this.date,
    this.message,
    this.id,
  });

  factory ShippingInfo.fromJson(Map<String, dynamic> json) => ShippingInfo(
        status: json["status"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        message: json["message"],
        id: json["_id"],
      );
}

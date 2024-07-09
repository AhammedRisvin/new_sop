class GetOrderHistoryDeatilsModel {
  String? message;
  List<OrderData>? orderDatas;
  ShippingAddress? shippingAddress;
  String? currency;
  String? currencySymbol;

  GetOrderHistoryDeatilsModel({
    this.message,
    this.orderDatas,
    this.shippingAddress,
    this.currency,
    this.currencySymbol,
  });

  factory GetOrderHistoryDeatilsModel.fromJson(Map<String, dynamic> json) =>
      GetOrderHistoryDeatilsModel(
        message: json["message"],
        orderDatas: json["orderDatas"] == null
            ? []
            : List<OrderData>.from(
                json["orderDatas"]!.map((x) => OrderData.fromJson(x))),
        shippingAddress: json["shippingAddress"] == null
            ? null
            : ShippingAddress.fromJson(json["shippingAddress"]),
        currency: json["currency"],
        currencySymbol: json["currencySymbol"],
      );
}

class OrderData {
  String? orderId;
  List<ShippingInfo>? shippingInfo;
  List<dynamic>? returnInfo;
  String? productName;
  String? productId;
  String? otp;
  String? sizeId;
  String? bookingId;
  List<String>? productImage;
  String? size;
  String? shippingAddress;
  String? orderStatus;
  num? quantity;
  bool? isReturn;
  bool? isAddedTheReview;
  num? discount;
  double? price;
  double? totalPrice;

  OrderData({
    this.orderId,
    this.shippingInfo,
    this.returnInfo,
    this.productName,
    this.productId,
    this.otp,
    this.sizeId,
    this.bookingId,
    this.productImage,
    this.size,
    this.shippingAddress,
    this.orderStatus,
    this.quantity,
    this.discount,
    this.price,
    this.totalPrice,
    this.isReturn,
    this.isAddedTheReview,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        orderId: json["orderId"],
        shippingInfo: json["shippingInfo"] == null
            ? []
            : List<ShippingInfo>.from(
                json["shippingInfo"]!.map((x) => ShippingInfo.fromJson(x))),
        returnInfo: json["returnInfo"] == null
            ? []
            : List<dynamic>.from(json["returnInfo"]!.map((x) => x)),
        productName: json["productName"],
        productId: json["productId"],
        otp: json["otp"],
        sizeId: json["sizeId"],
        bookingId: json["bookingId"],
        productImage: json["productImage"] == null
            ? []
            : List<String>.from(json["productImage"]!.map((x) => x)),
        size: json["size"],
        shippingAddress: json["shippingAddress"],
        orderStatus: json["orderStatus"],
        quantity: json["quantity"],
        discount: json["discount"],
        price: json["price"]?.toDouble(),
        totalPrice: json["totalPrice"]?.toDouble(),
        isReturn: json["isReturn"],
        isAddedTheReview: json["isAddedTheReview"],
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

class ShippingAddress {
  String? name;
  String? phone;
  String? dialCodeShipping;
  String? address;
  String? city;
  String? state;
  String? pincode;
  String? addressType;
  bool? isDelete;
  bool? isDefault;
  String? id;

  ShippingAddress({
    this.name,
    this.phone,
    this.dialCodeShipping,
    this.address,
    this.city,
    this.state,
    this.pincode,
    this.addressType,
    this.isDelete,
    this.isDefault,
    this.id,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        name: json["name"],
        phone: json["phone"],
        dialCodeShipping: json["dialCodeShipping"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
        addressType: json["addressType"],
        isDelete: json["isDelete"],
        isDefault: json["isDefault"],
        id: json["_id"],
      );
}

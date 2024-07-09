class FoodAddressModel {
  bool? success;
  String? message;
  List<ShippingAddress>? shippingAddress;

  FoodAddressModel({
    this.success,
    this.message,
    this.shippingAddress,
  });

  factory FoodAddressModel.fromJson(Map<String, dynamic> json) =>
      FoodAddressModel(
        success: json["success"],
        message: json["message"],
        shippingAddress: json["shippingAddress"] == null
            ? []
            : List<ShippingAddress>.from(json["shippingAddress"]!
                .map((x) => ShippingAddress.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "shippingAddress": shippingAddress == null
            ? []
            : List<dynamic>.from(shippingAddress!.map((x) => x.toJson())),
      };
}

class ShippingAddress {
  String? name;
  String? phone;
  String? address;
  String? city;
  String? state;
  String? pincode;
  String? addressType;
  bool? isDelete;
  String? id;

  ShippingAddress({
    this.name,
    this.phone,
    this.address,
    this.city,
    this.state,
    this.pincode,
    this.addressType,
    this.isDelete,
    this.id,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
        addressType: json["addressType"],
        isDelete: json["isDelete"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "address": address,
        "city": city,
        "state": state,
        "pincode": pincode,
        "addressType": addressType,
        "isDelete": isDelete,
        "_id": id,
      };
}

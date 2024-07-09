class GetAddressModel {
  bool? success;
  String? message;
  List<ShippingAddress>? shippingAddress;

  GetAddressModel({
    this.success,
    this.message,
    this.shippingAddress,
  });

  factory GetAddressModel.fromJson(Map<String, dynamic> json) =>
      GetAddressModel(
        success: json["success"],
        message: json["message"],
        shippingAddress: json["shippingAddress"] == null
            ? []
            : List<ShippingAddress>.from(json["shippingAddress"]!
                .map((x) => ShippingAddress.fromJson(x))),
      );
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
  String? dialCodeShipping;
  bool? isDefault;

  ShippingAddress({
    this.name,
    this.phone,
    this.address,
    this.dialCodeShipping,
    this.city,
    this.state,
    this.pincode,
    this.addressType,
    this.isDelete,
    this.id,
    this.isDefault,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        dialCodeShipping: json["dialCodeShipping"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
        addressType: json["addressType"],
        isDelete: json["isDelete"],
        id: json["_id"],
        isDefault: json["isDefault"],
      );
}

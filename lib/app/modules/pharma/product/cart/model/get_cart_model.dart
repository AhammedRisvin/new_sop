import '../../../../home/home/model/get_home_data_model.dart';

class GetCartModel {
  String? message;
  double? walletAmount;
  String? currency;
  String? currencySymbol;
  CartData? cartData;

  GetCartModel({
    this.message,
    this.walletAmount,
    this.currency,
    this.currencySymbol,
    this.cartData,
  });

  factory GetCartModel.fromJson(Map<String, dynamic> json) => GetCartModel(
        message: json["message"],
        walletAmount: json["walletAmount"]?.toDouble(),
        currency: json["currency"],
        currencySymbol: json["currencySymbol"],
        cartData: json["cartData"] == null
            ? null
            : CartData.fromJson(json["cartData"]),
      );
}

class CartData {
  String? id;
  List<LatestProduct>? cart;
  num? totalPrice;
  num? shippingCharge;
  num? totalDiscount;
  num? totalSubTotal;
  num? totalItem;
  double? loyalityPoint;

  CartData({
    this.id,
    this.cart,
    this.totalPrice,
    this.shippingCharge,
    this.totalDiscount,
    this.totalSubTotal,
    this.totalItem,
    this.loyalityPoint,
  });
  factory CartData.fromJson(Map<String, dynamic> json) => CartData(
        id: json["_id"],
        cart: json["cart"] == null
            ? []
            : List<LatestProduct>.from(
                json["cart"]!.map((x) => LatestProduct.fromJson(x))),
        totalPrice: json["totalPrice"],
        shippingCharge: json["shippingCharge"],
        totalDiscount: json["totalDiscount"],
        totalSubTotal: json["totalSubTotal"],
        totalItem: json["totalItem"],
        loyalityPoint: json["loyalityPoint"]?.toDouble(),
      );
}

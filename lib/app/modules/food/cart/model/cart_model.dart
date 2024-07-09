class FoodCartModel {
  String? message;
  int? walletAmount;
  String? currency;
  CartData? cartData;

  FoodCartModel({
    this.message,
    this.walletAmount,
    this.currency,
    this.cartData,
  });

  factory FoodCartModel.fromJson(Map<String, dynamic> json) => FoodCartModel(
        message: json["message"],
        walletAmount: json["walletAmount"],
        currency: json["currency"],
        cartData: json["cartData"] == null
            ? null
            : CartData.fromJson(json["cartData"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "walletAmount": walletAmount,
        "currency": currency,
        "cartData": cartData?.toJson(),
      };
}

class CartData {
  String? id;
  List<Cart>? cart;
  int? totalPrice;
  dynamic shippingCharge;
  dynamic totalDiscount;
  dynamic totalSubTotal;
  int? totalItem;

  CartData({
    this.id,
    this.cart,
    this.totalPrice,
    this.shippingCharge,
    this.totalDiscount,
    this.totalSubTotal,
    this.totalItem,
  });

  factory CartData.fromJson(Map<String, dynamic> json) => CartData(
        id: json["_id"],
        cart: json["cart"] == null
            ? []
            : List<Cart>.from(json["cart"]!.map((x) => Cart.fromJson(x))),
        totalPrice: json["totalPrice"],
        shippingCharge: json["shippingCharge"],
        totalDiscount: json["totalDiscount"],
        totalSubTotal: json["totalSubTotal"],
        totalItem: json["totalItem"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "cart": cart == null
            ? []
            : List<dynamic>.from(cart!.map((x) => x.toJson())),
        "totalPrice": totalPrice,
        "shippingCharge": shippingCharge,
        "totalDiscount": totalDiscount,
        "totalSubTotal": totalSubTotal,
        "totalItem": totalItem,
      };
}

class Cart {
  String? productId;
  String? productName;
  String? productLink;
  String? images;
  int? pricePerItem;
  int? quantity;
  int? availableQuantity;
  List<AddOn>? addOns;
  int? totalPrice;

  Cart({
    this.productId,
    this.productName,
    this.productLink,
    this.images,
    this.pricePerItem,
    this.quantity,
    this.availableQuantity,
    this.addOns,
    this.totalPrice,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        productId: json["productId"],
        productName: json["productName"],
        productLink: json["productLink"],
        images: json["images"],
        pricePerItem: json["pricePerItem"],
        quantity: json["quantity"],
        availableQuantity: json["availableQuantity"],
        addOns: json["addOns"] == null
            ? []
            : List<AddOn>.from(json["addOns"]!.map((x) => AddOn.fromJson(x))),
        totalPrice: json["totalPrice"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "productLink": productLink,
        "images": images,
        "pricePerItem": pricePerItem,
        "quantity": quantity,
        "availableQuantity": availableQuantity,
        "addOns": addOns == null
            ? []
            : List<dynamic>.from(addOns!.map((x) => x.toJson())),
        "totalPrice": totalPrice,
      };
}

class AddOn {
  String? addOnId;
  String? addOnName;
  int? addOnPrice;
  String? addOnImage;
  int? addOnQuantity;

  AddOn({
    this.addOnId,
    this.addOnName,
    this.addOnPrice,
    this.addOnImage,
    this.addOnQuantity,
  });

  factory AddOn.fromJson(Map<String, dynamic> json) => AddOn(
        addOnId: json["addOnId"],
        addOnName: json["addOnName"],
        addOnPrice: json["addOnPrice"],
        addOnImage: json["addOnImage"],
        addOnQuantity: json["addOnQuantity"],
      );

  Map<String, dynamic> toJson() => {
        "addOnId": addOnId,
        "addOnName": addOnName,
        "addOnPrice": addOnPrice,
        "addOnImage": addOnImage,
        "addOnQuantity": addOnQuantity,
      };
}

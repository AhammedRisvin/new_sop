class GetLoyaltyModel {
  num? status;
  String? message;
  List<Tier>? tiers;
  CurrentTierDetails? currentTierDetails;

  GetLoyaltyModel({
    this.status,
    this.message,
    this.tiers,
    this.currentTierDetails,
  });

  factory GetLoyaltyModel.fromJson(Map<String, dynamic> json) =>
      GetLoyaltyModel(
        status: json["status"],
        message: json["message"],
        tiers: json["tiers"] == null
            ? []
            : List<Tier>.from(json["tiers"]!.map((x) => Tier.fromJson(x))),
        currentTierDetails: json["currentTierDetails"] == null
            ? null
            : CurrentTierDetails.fromJson(json["currentTierDetails"]),
      );
}

class CurrentTierDetails {
  String? tierId;
  String? name;
  num? minLoyalityPointForClaim;
  CurrentTierDetailsLoyalityPointsAndPrice? loyalityPointsAndPrice;
  num? currentPoints;

  CurrentTierDetails({
    this.tierId,
    this.name,
    this.minLoyalityPointForClaim,
    this.loyalityPointsAndPrice,
    this.currentPoints,
  });

  factory CurrentTierDetails.fromJson(Map<String, dynamic> json) =>
      CurrentTierDetails(
        tierId: json["tierId"],
        name: json["name"],
        minLoyalityPointForClaim: json["minLoyalityPointForClaim"],
        loyalityPointsAndPrice: json["loyalityPointsAndPrice"] == null
            ? null
            : CurrentTierDetailsLoyalityPointsAndPrice.fromJson(
                json["loyalityPointsAndPrice"]),
        currentPoints: json["currentPoints"],
      );
}

class CurrentTierDetailsLoyalityPointsAndPrice {
  num? loyalityPoints;
  num? price;
  String? currency;

  CurrentTierDetailsLoyalityPointsAndPrice({
    this.loyalityPoints,
    this.price,
    this.currency,
  });

  factory CurrentTierDetailsLoyalityPointsAndPrice.fromJson(
          Map<String, dynamic> json) =>
      CurrentTierDetailsLoyalityPointsAndPrice(
        loyalityPoints: json["loyalityPoints"],
        price: json["price"],
        currency: json["currency"],
      );
}

class Tier {
  TierLoyalityPointsAndPrice? loyalityPointsAndPrice;
  String? id;
  String? name;
  List<String>? benefites;
  String? image;
  num? minLoyalityPointsForUpgrade;
  num? minLoyalityPointForClaim;

  Tier({
    this.loyalityPointsAndPrice,
    this.id,
    this.name,
    this.benefites,
    this.image,
    this.minLoyalityPointsForUpgrade,
    this.minLoyalityPointForClaim,
  });

  factory Tier.fromJson(Map<String, dynamic> json) => Tier(
        loyalityPointsAndPrice: json["loyalityPointsAndPrice"] == null
            ? null
            : TierLoyalityPointsAndPrice.fromJson(
                json["loyalityPointsAndPrice"]),
        id: json["_id"],
        name: json["name"],
        benefites: json["benefites"] == null
            ? []
            : List<String>.from(json["benefites"]!.map((x) => x)),
        image: json["image"],
        minLoyalityPointsForUpgrade: json["minLoyalityPointsForUpgrade"],
        minLoyalityPointForClaim: json["minLoyalityPointForClaim"],
      );
}

class TierLoyalityPointsAndPrice {
  num? loyalityPoints;
  double? price;
  String? currency;

  TierLoyalityPointsAndPrice({
    this.loyalityPoints,
    this.price,
    this.currency,
  });

  factory TierLoyalityPointsAndPrice.fromJson(Map<String, dynamic> json) =>
      TierLoyalityPointsAndPrice(
        loyalityPoints: json["loyalityPoints"],
        price: json["price"]?.toDouble(),
        currency: json["currency"],
      );
}

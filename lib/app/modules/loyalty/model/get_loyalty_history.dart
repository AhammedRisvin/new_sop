class GetLoyaltyHistoryModel {
  int? status;
  String? message;
  List<History>? history;
  String? currencySymbol;

  GetLoyaltyHistoryModel({
    this.status,
    this.message,
    this.history,
    this.currencySymbol,
  });

  factory GetLoyaltyHistoryModel.fromJson(Map<String, dynamic> json) =>
      GetLoyaltyHistoryModel(
        status: json["status"],
        message: json["message"],
        history: json["history"] == null
            ? []
            : List<History>.from(
                json["history"]!.map((x) => History.fromJson(x))),
        currencySymbol: json["currencySymbol"],
      );
}

class History {
  String? id;
  String? method;
  num? points;
  double? amount;
  String? currency;
  DateTime? createdAt;

  History({
    this.id,
    this.method,
    this.points,
    this.amount,
    this.currency,
    this.createdAt,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["_id"],
        method: json["method"],
        points: json["points"],
        amount: json["amount"]?.toDouble(),
        currency: json["currency"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );
}

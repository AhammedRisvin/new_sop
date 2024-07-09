class GetWalletHistoryModel {
  num? status;
  String? message;
  List<History>? history;
  String? currencySymbol;
  double? userWalletAmount;
  String? currencyCode;

  GetWalletHistoryModel({
    this.status,
    this.message,
    this.history,
    this.currencySymbol,
    this.userWalletAmount,
    this.currencyCode,
  });

  factory GetWalletHistoryModel.fromJson(Map<String, dynamic> json) =>
      GetWalletHistoryModel(
        status: json["status"],
        message: json["message"],
        history: json["history"] == null
            ? []
            : List<History>.from(
                json["history"]!.map((x) => History.fromJson(x))),
        currencySymbol: json["currencySymbol"],
        userWalletAmount: json["userWalletAmount"]?.toDouble(),
        currencyCode: json["currencyCode"],
      );
}

class History {
  String? id;
  double? amount;
  String? currency;
  String? source;
  DateTime? createdAt;

  History({
    this.id,
    this.amount,
    this.currency,
    this.source,
    this.createdAt,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["_id"],
        amount: json["amount"]?.toDouble(),
        currency: json["currency"],
        source: json["source"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );
}

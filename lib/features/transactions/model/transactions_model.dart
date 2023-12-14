class TransactionsModel {
  List<TransactionItem>? transactions;

  TransactionsModel({this.transactions});

  factory TransactionsModel.fromJson(Map<String, dynamic> json) =>
      TransactionsModel(
        transactions: json["data"] == null
            ? []
            : List<TransactionItem>.from(
                json["data"].map((x) => TransactionItem.fromJson(x))),
      );
}

class TransactionItem {
  int? id;
  DateTime? createdAt;
  double? amount;
  String? paymentMethod;
  String? paymentStatus;
  String? paymentId;
  String? comment;
  int? reservationId;
  int? clientId;
  int? couponId;
  int? offerId;
  String? invoice;

  TransactionItem(
      {this.id,
      this.createdAt,
      this.amount,
      this.paymentMethod,
      this.paymentStatus,
      this.paymentId,
      this.comment,
      this.reservationId,
      this.clientId,
      this.couponId,
      this.offerId,
      this.invoice});

  TransactionItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'] != null
        ? DateTime.parse(json['created_at'])
        : DateTime.now();
    amount = double.parse(json['amount'].toString());
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    paymentId = json['payment_id'];
    comment = json['comment'];
    reservationId = json['reservation_id'];
    clientId = json['client_id'];
    couponId = json['coupon_id'];
    offerId = json['offer_id'];
    invoice = json['invoice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['amount'] = amount;
    data['payment_method'] = paymentMethod;
    data['payment_status'] = paymentStatus;
    data['payment_id'] = paymentId;
    data['comment'] = comment;
    data['reservation_id'] = reservationId;
    data['client_id'] = clientId;
    data['coupon_id'] = couponId;
    data['offer_id'] = offerId;
    data['invoice'] = invoice;
    return data;
  }
}

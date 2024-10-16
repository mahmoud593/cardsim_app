class OrdersModel {
  final int total;
  final List<Order> orders;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int from;
  final int to;

  OrdersModel({
    required this.total,
    required this.orders,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.from,
    required this.to,
  });

  factory OrdersModel.fromMap(Map<String, dynamic> json) => OrdersModel(
    total: json["total"] ?? 0,
    orders: json["orders"] != null
        ? List<Order>.from(json["orders"].map((x) => Order.fromMap(x)))
        : [],
    currentPage: json["current_page"] ?? 1,
    lastPage: json["last_page"] ?? 1,
    perPage: json["per_page"] ?? 10,
    from: json["from"] ?? 0,
    to: json["to"] ?? 0,
  );

  Map<String, dynamic> toMap() => {
    "total": total,
    "orders": List<dynamic>.from(orders.map((x) => x.toMap())),
    "current_page": currentPage,
    "last_page": lastPage,
    "per_page": perPage,
    "from": from,
    "to": to,
  };
}

class Order {
  final int id;
  final String tracking;
  final String productName;
  final double productPrice;
  final int quantity;
  final double orderTotal;
  final double walletBalanceBefore;
  final double walletBalanceAfter;
  final Field field;
  final dynamic orderDetails;
  final String status;
  final String rejectReason;
  final String addedDetails;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.tracking,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.orderTotal,
    required this.walletBalanceBefore,
    required this.walletBalanceAfter,
    required this.field,
    required this.orderDetails,
    required this.status,
    required this.rejectReason,
    required this.addedDetails,
    required this.createdAt,
  });

  factory Order.fromMap(Map<String, dynamic> json) => Order(
    id: json["id"] ?? 0,
    tracking: json["tracking"] ?? '',
    productName: json["product_name"] ?? '',
    productPrice: json["product_price"] != null ? json["product_price"].toDouble() : 0.0,
    quantity: json["quantity"] ?? 0,
    orderTotal: json["order_total"] != null ? json["order_total"].toDouble() : 0.0,
    walletBalanceBefore: json["wallet_balance_before"] != null ? json["wallet_balance_before"].toDouble() : 0.0,
    walletBalanceAfter: json["wallet_balance_after"] != null ? json["wallet_balance_after"].toDouble() : 0.0,
    field: json["field"] != null ? Field.fromMap(json["field"]) : Field(name: '', value: '', valueCheckedName: null),
    orderDetails: json["order_details"],
    status: json["status"] ?? '',
    rejectReason: json["reject_reason"] ?? '',
    addedDetails: json["added_details"] ?? '',
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime.now(),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "tracking": tracking,
    "product_name": productName,
    "product_price": productPrice,
    "quantity": quantity,
    "order_total": orderTotal,
    "wallet_balance_before": walletBalanceBefore,
    "wallet_balance_after": walletBalanceAfter,
    "field": field.toMap(),
    "order_details": orderDetails,
    "status": status,
    "reject_reason": rejectReason,
    "added_details": addedDetails,
    "created_at": createdAt.toIso8601String(),
  };
}

class Field {
  final String name;
  final String value;
  final dynamic valueCheckedName;

  Field({
    required this.name,
    required this.value,
    required this.valueCheckedName,
  });

  factory Field.fromMap(Map<String, dynamic> json) => Field(
    name: json["name"] ?? '',
    value: json["value"] ?? '',
    valueCheckedName: json["value_checked_name"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "value": value,
    "value_checked_name": valueCheckedName,
  };
}

class OrderDetailsClass {
  final String additionalData;
  final String number;
  final String smsCode;

  OrderDetailsClass({
    required this.additionalData,
    required this.number,
    required this.smsCode,
  });

  factory OrderDetailsClass.fromMap(Map<String, dynamic> json) => OrderDetailsClass(
    additionalData: json["additional_data"] ?? '',
    number: json["number"] ?? '',
    smsCode: json["sms_code"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "additional_data": additionalData,
    "number": number,
    "sms_code": smsCode,
  };
}

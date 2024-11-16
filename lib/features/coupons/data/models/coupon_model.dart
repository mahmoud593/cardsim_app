class CouponsDataModel {
  final bool status;
  final int total;
  final List<CouponModel> data;

  CouponsDataModel({
    required this.status,
    required this.total,
    required this.data,
  });

  factory CouponsDataModel.fromMap(Map<String, dynamic> json) => CouponsDataModel(
    status: json["status"]?? false,
    total: json["total"] ?? -1,
    data: json["data"] == null ? [] : List<CouponModel>.from(json["data"].map((x) => CouponModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "total": total,
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
  };
}

class CouponModel {
  final int id;
  final String code;
  final dynamic amount;
  final String prevBalance;
  final String newBalance;
  final String status;
  final dynamic usedIn;
  final String createdAt;

  CouponModel({
    required this.id,
    required this.code,
    required this.amount,
    required this.prevBalance,
    required this.newBalance,
    required this.status,
    required this.usedIn,
    required this.createdAt,
  });

  factory CouponModel.fromMap(Map<String, dynamic> json) => CouponModel(
    id: json["id"]?? -1,
    code: json["code"]??"",
    amount: json["amount"]??0,
    prevBalance: json["prev_balance"]??"",
    newBalance: json["new_balance"]??"",
    status: json["status"]??"",
    usedIn: json["used_in"]??"",
    createdAt: json["created_at"]??"",
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "code": code,
    "amount": amount,
    "prev_balance": prevBalance,
    "new_balance": newBalance,
    "status": status,
    "used_in": usedIn,
    "created_at": createdAt,
  };
}
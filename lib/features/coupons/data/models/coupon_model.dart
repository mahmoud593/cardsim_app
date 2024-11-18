class CouponsDataModel {
  final bool status;
  final int total;
  final int totalCount;
  final int used;
  final int notUsed;
  final List<CouponModel> data;

  CouponsDataModel({
    required this.status,
    required this.total,
    required this.totalCount,
    required this.used,
    required this.notUsed,
    required this.data,
  });

  factory CouponsDataModel.fromMap(Map<String, dynamic> json) => CouponsDataModel(
    status: json["status"]?? false,
    total: json["total"] ?? -1,
    totalCount: json["total_count"] ?? -1,
    used: json["used"] ?? -1,
    notUsed: json["not_used"] ?? -1,
    data: json["data"] == null ? [] : List<CouponModel>.from(json["data"].map((x) => CouponModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "total": total,
    "total_count": totalCount,
    "used": used,
    "not_used": notUsed,
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
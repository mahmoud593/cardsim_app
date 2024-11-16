class TransationModel {
  final bool status;
  final int total;
  final List<TranscationData> data;

  TransationModel({
    required this.status,
    required this.total,
    required this.data,
  });

  factory TransationModel.fromMap(Map<String, dynamic> json) => TransationModel(
    status: json["status"]??false,
    total: json["total"]??0,
    data: json["data"] == null ? [] : List<TranscationData>.from(json["data"].map((x) => TranscationData.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "total": total,
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
  };
}

class TranscationData {
  final int id;
  final String actionId;
  final String action;
  final double amount;
  final int prevBalance;
  final double newBalance;

  TranscationData({
    required this.id,
    required this.actionId,
    required this.action,
    required this.amount,
    required this.prevBalance,
    required this.newBalance,
  });

  factory TranscationData.fromMap(Map<String, dynamic> json) => TranscationData(
    id: json["id"]??0,
    actionId: json["action_id"]??"",
    action: json["action"]??"",
    amount: json["amount"] ?? 0.0,
    prevBalance: json["prev_balance"]??0,
    newBalance: json["new_balance"]??0.0,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "action_id": actionId,
    "action": action,
    "amount": amount,
    "prev_balance": prevBalance,
    "new_balance": newBalance,
  };
}
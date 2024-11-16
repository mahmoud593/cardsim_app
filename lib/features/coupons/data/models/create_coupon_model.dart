class CreateCouponModel {
  final bool status;
  final String message;
  final String messageAr;

  CreateCouponModel({
    required this.status,
    required this.message,
    required this.messageAr,
  });

  factory CreateCouponModel.fromMap(Map<String, dynamic> json) => CreateCouponModel(
    status: json["status"]?? false,
    message: json["message"]?? "",
    messageAr: json["message_ar"]?? "",
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "message_ar": messageAr,
  };
}
import 'package:games_app/features/withdraws/domain/entities/create_withdraw_entity.dart';

class CreateWithdrawModel extends CreateWithdrawEntity {
  CreateWithdrawModel({
    required super.message,
    required super.messageAr,
  });

  factory CreateWithdrawModel.fromJson(Map<String, dynamic> json) {
    return CreateWithdrawModel(
      message: json['message'],
      messageAr: json['message_ar'],
    );
  }

  toJson() => {
    'message': message,
    'message_ar': messageAr,
  };


}

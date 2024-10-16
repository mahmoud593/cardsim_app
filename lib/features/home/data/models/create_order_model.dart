import '../../domain/entities/create_order_entity.dart';
import 'order_model.dart';

class CreateOrderModel extends CreateOrderEntity {
  CreateOrderModel(
    super.status,
    super.orderEntity,
    super.message,
    super.messageAr,
  );

  factory CreateOrderModel.fromJson(Map<String, dynamic> json) {
    return CreateOrderModel(
      json['status'],
      json['order_entity'] != null
          ? OrderModel.fromJson(json['order_entity'])
          : null,
      json['message'],
      json['message_ar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'order_entity': orderEntity,
      'message': message,
      'message_ar': messageAr,
    };
  }

  @override
  String toString() {
    return 'CreateOrderModel(status: $status, message: $message, messageAr: $messageAr, orderEntity: $orderEntity)';
  }
}

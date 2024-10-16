import 'order_entity.dart';

class CreateOrderEntity {
  final String status;
  final String message;
  final String messageAr;
  final OrderEntity? orderEntity;

  CreateOrderEntity(
    this.status,
    this.orderEntity,
    this.message,
    this.messageAr,
  );
}

import '../../domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  OrderModel(
    super.createdAt,
    super.id,
    super.productName,
    super.quantity,
    super.orderTotal,
    super.status,
    super.field,
  );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      json['created_at'],
      json['id'],
      json['product_name'],
      json['quantity'],
      json['order_total'],
      json['status'],
      json['field'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['id'] = id;
    data['product_name'] = productName;
    data['quantity'] = quantity;
    data['order_total'] = orderTotal;
    data['status'] = status;
    data['field'] = field;
    return data;
  }

  @override
  String toString() =>
      'OrderModel(createdAt: $createdAt, id: $id, productName: $productName, quantity: $quantity, orderTotal: $orderTotal, status: $status, field: $field)';
}

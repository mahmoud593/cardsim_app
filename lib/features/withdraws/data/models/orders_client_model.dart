import 'package:games_app/features/withdraws/domain/entities/orders_client_entity.dart';

class OrdersClientModel extends OrdersClientEntity {
  OrdersClientModel({
    required super.id,
    required super.tracking,
    required super.productName,
    required super.orderTotal,
    required super.status,
    required super.createdAt,
    required super.user,
    required super.profit,
  });

  factory OrdersClientModel.fromJson(Map<String, dynamic> json) {
    return OrdersClientModel(
      id: json['id'],
      tracking: json['tracking'],
      productName: json['product_name'],
      user: json['user'],
      orderTotal: json['order_total'],
      profit: json['profit'],
      status: json['status'],
      createdAt: json['created_at'],
    );
  }

  @override
  String toString() {
    return 'OrdersModel(id: $id, tracking: $tracking, productName: $productName, orderTotal: $orderTotal, status: $status, createdAt: $createdAt)';
  }
}

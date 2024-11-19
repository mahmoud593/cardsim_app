import '../../../home/data/models/order_model.dart';
import '../../domain/entities/client_order_entity.dart';
import 'orders_client_model.dart';

class ClientOrderModel extends ClientOrderEntity {
  ClientOrderModel({
    required super.total,
    required super.orders,
    required super.currentPage,
    required super.lastPage,
    required super.perPage,
    required super.from,
    required super.to,
  });

  factory ClientOrderModel.fromJson(Map<String, dynamic> json) =>
      ClientOrderModel(
        total: json["total"]??0,
        orders: List<OrdersClientModel>.from(
            json["orders"].map((x) => OrdersClientModel.fromJson(x))),
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        perPage: json["per_page"],
        from: json["from"],
        to: json["to"],
      );

  @override
  String toString() {
    return 'ClientOrderModel(total: $total, orders: $orders, currentPage: $currentPage, lastPage: $lastPage, perPage: $perPage, from: $from, to: $to)';
  }
}

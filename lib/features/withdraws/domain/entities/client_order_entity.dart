import 'orders_client_entity.dart';

class ClientOrderEntity {
  final int total;
  final List<OrdersClientEntity> orders;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int from;
  final int to;

  ClientOrderEntity({
    required this.total,
    required this.orders,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.from,
    required this.to,
  });
}

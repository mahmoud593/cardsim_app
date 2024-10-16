import 'package:games_app/features/orders/data/models/orders_model.dart';

abstract class OrdersRepo {
  Future<OrdersModel> getOrders({required String search, required String status});
}
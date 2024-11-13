part of 'client_order_cubit.dart';

@immutable
sealed class ClientOrderState {}

final class ClientOrderInitial extends ClientOrderState {}


final class ClientOrdersLoadingState extends ClientOrderState {}

final class ClientOrdersSuccessState extends ClientOrderState {
  final List<OrdersClientEntity> clientOrders;

  ClientOrdersSuccessState(this.clientOrders);
}

final class ClientOrdersFailureState extends ClientOrderState {
  final String message;

  ClientOrdersFailureState(this.message);
}

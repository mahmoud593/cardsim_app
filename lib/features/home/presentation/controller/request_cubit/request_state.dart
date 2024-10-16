part of 'request_cubit.dart';

@immutable
sealed class RequestState {}

final class RequestInitial extends RequestState {}

final class CheckFieldLoading extends RequestState {}

final class CheckFieldSuccess extends RequestState {
  // final CheckFieldEntity checkFieldEntity;
  // CheckFieldSuccess(this.checkFieldEntity);
}

final class CheckFieldFailure extends RequestState {
  final String error;
  CheckFieldFailure(this.error);
}

final class CreateOrderLoading extends RequestState {}

final class CreateOrderSuccess extends RequestState {
  final CreateOrderEntity createOrderEntity;
  CreateOrderSuccess(this.createOrderEntity);
}

final class CreateOrderFailure extends RequestState {
  final String error;
  CreateOrderFailure(this.error);
}

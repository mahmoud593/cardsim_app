part of 'request_cubit.dart';

@immutable
sealed class RequestState {}

final class RequestInitial extends RequestState {}

final class CheckFieldLoading extends RequestState {}

final class CheckFieldSuccess extends RequestState {
  final CheckFieldEntity checkFieldEntity;
  CheckFieldSuccess(this.checkFieldEntity);
}

final class CheckFieldFailure extends RequestState {
  final String error;
  CheckFieldFailure(this.error);
}

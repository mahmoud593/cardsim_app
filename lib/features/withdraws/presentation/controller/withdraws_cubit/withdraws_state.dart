part of 'withdraws_cubit.dart';

@immutable
sealed class WithdrawsState {}

final class WithdrawsInitial extends WithdrawsState {}

final class WithdrawsLoadingState extends WithdrawsState {}

final class WithdrawsSuccessState extends WithdrawsState {
  final List<WithdrawsDataEntity> withdraws;

  WithdrawsSuccessState(this.withdraws);
}

final class WithdrawsFailureState extends WithdrawsState {
  final String message;

  WithdrawsFailureState(this.message);
}

final class CreateWithdrawLoadingState extends WithdrawsState {}

final class CreateWithdrawSuccessState extends WithdrawsState {}

final class CreateWithdrawFailureState extends WithdrawsState {
  final String message;

  CreateWithdrawFailureState(this.message);
}

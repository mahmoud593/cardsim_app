import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/withdraws/domain/entities/create_withdraw_entity.dart';
import 'package:games_app/features/withdraws/domain/entities/withdraws_entity.dart';
import 'package:games_app/features/withdraws/domain/repos/withdraws_repo.dart';
import 'package:games_app/styles/widgets/toast.dart';

import '../../../domain/entities/withdraws_data_entity.dart';

part 'withdraws_state.dart';

class WithdrawsCubit extends Cubit<WithdrawsState> {
  WithdrawsCubit(this.withdrawsRepo) : super(WithdrawsInitial());
  final WithdrawsRepo withdrawsRepo;

  WithdrawsEntity? withdrawsEntity;
  int waitingAmountSum = 0;

  Future<void> getWithdraws() async {
    emit(WithdrawsLoadingState());
    final result = await withdrawsRepo.getWithdraws();
    result.fold(
      (l) => emit(WithdrawsFailureState(l.error)),
      (r) {
        withdrawsEntity = r;
        calculateWaitingAmountSum(r.data);
        emit(WithdrawsSuccessState(r.data));
      },
    );
  }

  void calculateWaitingAmountSum(List<WithdrawsDataEntity> data) {
    waitingAmountSum = data
        .where((withdraw) => withdraw.status == "waiting")
        .fold(0, (sum, withdraw) => sum + withdraw.amount);
  }

  CreateWithdrawEntity? createWithdrawEntity;

  Future<void> createWithdraw(int amount, String notes) async {
    emit(CreateWithdrawLoadingState());
    final result = await withdrawsRepo.createWithdraw(amount, notes);
    result.fold(
      (l) {
        customToast(title: l.error, color: Colors.red);
        emit(CreateWithdrawFailureState(l.error));
      },
      (r) {
        createWithdrawEntity = r;
        customToast(
          title: r.messageAr,
          color:
              r.messageAr == 'تم إرسال طلب السحب' ? Colors.green : Colors.grey,
        );
        emit(CreateWithdrawSuccessState());
      },
    );
  }
}

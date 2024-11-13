import 'package:dartz/dartz.dart';
import 'package:games_app/core/errors/failure.dart';
import 'package:games_app/features/withdraws/data/api/withdraws_api_services.dart';
import 'package:games_app/features/withdraws/domain/entities/client_order_entity.dart';
import 'package:games_app/features/withdraws/domain/entities/create_withdraw_entity.dart';
import 'package:games_app/features/withdraws/domain/entities/orders_client_entity.dart';
import 'package:games_app/features/withdraws/domain/entities/withdraws_data_entity.dart';

import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/withdraws_entity.dart';
import '../../domain/repos/withdraws_repo.dart';

class WithdrawsRepoImp extends WithdrawsRepo {
  final WithdrawsApiServices withdrawsApiServices;

  WithdrawsRepoImp(this.withdrawsApiServices);

  @override
  Future<Either<Failure, WithdrawsEntity>> getWithdraws() async {
    final result = await withdrawsApiServices.getWithdraws();

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, ClientOrderEntity>> getClientOrders() async {
    final result = await withdrawsApiServices.getClientOrders();

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, CreateWithdrawEntity>> createWithdraw(int amount,String notes) async {
    final result =await withdrawsApiServices.createWithdraw(amount,notes);

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}

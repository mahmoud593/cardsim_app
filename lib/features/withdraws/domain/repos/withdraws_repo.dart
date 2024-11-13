import 'package:dartz/dartz.dart';
import 'package:games_app/features/withdraws/domain/entities/client_order_entity.dart';
import 'package:games_app/features/withdraws/domain/entities/create_withdraw_entity.dart';

import '../../../../core/errors/failure.dart';
import '../entities/orders_client_entity.dart';
import '../entities/withdraws_data_entity.dart';
import '../entities/withdraws_entity.dart';

abstract class WithdrawsRepo {
  Future<Either<Failure, WithdrawsEntity>> getWithdraws();

  Future<Either<Failure,ClientOrderEntity>> getClientOrders();

  Future<Either<Failure, CreateWithdrawEntity>> createWithdraw(int amount,String notes);
}

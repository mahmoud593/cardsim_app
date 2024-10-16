import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:games_app/features/home/domain/repos/home_repo.dart';

import '../../../domain/entities/check_field_entity.dart';
import '../../../domain/entities/create_order_entity.dart';

part 'request_state.dart';

class RequestCubit extends Cubit<RequestState> {
  RequestCubit(this.homeRepo) : super(RequestInitial());
  final HomeRepo homeRepo;

  CheckFieldEntity? checkFieldEntity;
  CreateOrderEntity? createOrderEntity;

  Future<void> checkIdField(String playerId, String type) async {
    emit(CheckFieldLoading());
    final result = await homeRepo.checkField(playerId, type);

    result.fold(
      (l) => emit(CheckFieldFailure(l.error)),
      (r) {
        checkFieldEntity = r;
        emit(CheckFieldSuccess());
      },
    );
  }

  Future<void> createOrder({
    required int productId,
    required int quantity,
    required String field,
    required BuildContext context,
  }) async {
    emit(CreateOrderLoading());
    final result = await homeRepo.createOrder(
      productId,
      quantity,
      field,
    );

    result.fold(
      (l) => emit(CreateOrderFailure(l.error)),
      (r) {
        emit(CreateOrderSuccess(r));
        Fluttertoast.showToast(
          msg: r.messageAr,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor:r.message == 'Order Created Successfully' ? Colors.green : Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
    );
  }
}

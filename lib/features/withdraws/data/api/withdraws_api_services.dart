import 'package:dio/dio.dart';
import 'package:games_app/features/withdraws/data/models/orders_client_model.dart';

import '../../../../core/constants/urls.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/local/shared_preference/shared_preference.dart';
import '../../../../core/network/error_message_model.dart';

import '../../domain/entities/client_order_entity.dart';
import '../models/client_order_model.dart';
import '../models/create_withdraw_model.dart';
import '../models/withdraws_data_model.dart';
import '../models/withdraws_model.dart';

class WithdrawsApiServices {
  final Dio _dio = Dio();

  Future<WithdrawsModel> getWithdraws() async {
    final response = await _dio.get(
      UrlConstants.withdrawsUrl,
      options: Options(
        headers: {
          'Authorization': 'Bearer ${UserDataFromStorage.userTokenFromStorage}',
        },
      ),
    );
    if (response.statusCode == 200) {
      return WithdrawsModel.fromJson(response.data);
    } else {
      throw ServerExceptions(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  Future<ClientOrderModel> getClientOrders() async {
    final response = await _dio.get(
      UrlConstants.clientOrdersUrl,
      options: Options(
        headers: {
          'Authorization': 'Bearer ${UserDataFromStorage.userTokenFromStorage}',
        },
      ),
    );
    if (response.statusCode == 200) {
      return ClientOrderModel.fromJson(response.data);
    } else {
      throw ServerExceptions(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  Future<CreateWithdrawModel> createWithdraw(int amount, String notes) async {
    final response = await _dio.post(
      UrlConstants.createWithdrawUrl,
      data: {'amount': amount, 'notes': notes},
      options: Options(
        headers: {
          'Authorization': 'Bearer ${UserDataFromStorage.userTokenFromStorage}',
        },
      ),
    );
    if (response.statusCode == 200) {
      return CreateWithdrawModel.fromJson(response.data);
    } else {
      throw ServerExceptions(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
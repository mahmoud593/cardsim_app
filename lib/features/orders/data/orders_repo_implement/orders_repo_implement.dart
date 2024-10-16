import 'package:flutter/cupertino.dart';
import 'package:games_app/core/errors/exceptions.dart';
import 'package:games_app/core/network/api_handle/http_request_handler.dart';
import 'package:games_app/core/network/api_handle/urls.dart';
import 'package:games_app/core/network/error_message_model.dart';
import 'package:games_app/features/orders/data/models/orders_model.dart';
import 'package:games_app/features/orders/data/orders_repo/orders_repo.dart';

class OrdersRepoImplement extends OrdersRepo{

  @override
  Future<OrdersModel> getOrders({required String search, required String status}) async {

    final response = await HttpHelper().callService(
        url: getUserOrdersUrl(search, status),
        responseType: ResponseType.get,
        authorization: true,
    );

    // debugPrint("get orders status >***************************************> ${response}");
    return OrdersModel.fromMap(response);
  }


}
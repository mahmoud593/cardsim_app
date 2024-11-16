import 'package:flutter/cupertino.dart';
import 'package:games_app/core/network/api_handle/http_request_handler.dart';
import 'package:games_app/core/network/api_handle/urls.dart';
import 'package:games_app/features/payment_history/data/model/transcation_model.dart';
import 'package:games_app/features/payment_history/data/payment_history_repo/payment_history_repo.dart';


class PaymentHistoryRepoImplement extends PaymentHistoryRepo{
  @override
  Future<TransationModel> getPaymentHistory() async{
    final response = await HttpHelper().callService(
      url: getAllTransactionsUrl,
      responseType: ResponseType.get,
      authorization: true,
    );

    debugPrint("get Payment History status >***************************************> ${response.toString()}");
    return TransationModel.fromMap(response);
  }


}
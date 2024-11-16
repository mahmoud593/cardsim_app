import 'package:flutter/cupertino.dart';
import 'package:games_app/core/network/api_handle/http_request_handler.dart';
import 'package:games_app/features/coupons/data/models/coupon_model.dart';
import 'package:games_app/features/coupons/data/models/create_coupon_model.dart';

import '../../../../core/network/api_handle/urls.dart';
import '../coupons_repo/coupons_repo.dart';

class CouponsRepoImplement extends CouponsRepo{

  @override
  Future<CouponsDataModel> getCoupons({required String search}) async {

    final response = await HttpHelper().callService(
      url: getCouponsUrl(search),
      responseType: ResponseType.get,
      authorization: true,
    );

    debugPrint("get Coupons status >***************************************> ${response.toString()}");
    return CouponsDataModel.fromMap(response);
  }

  @override
  Future<CreateCouponModel> createCoupon({required String amount, required String quantity}) async{
    final response = await HttpHelper().callService(
      url: createCouponUrl,
      parameter: {"amount": amount, "quantity": quantity},
      responseType: ResponseType.post,
      authorization: true,
    );
    debugPrint("Create Coupons status >***************************************> ${response.toString()}");
    return CreateCouponModel.fromMap(response);
  }

}
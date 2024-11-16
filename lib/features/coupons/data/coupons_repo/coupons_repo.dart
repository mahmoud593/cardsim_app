import 'package:games_app/features/coupons/data/models/coupon_model.dart';
import 'package:games_app/features/coupons/data/models/create_coupon_model.dart';

abstract class CouponsRepo {
  Future<CouponsDataModel> getCoupons({required String search});
  Future<CreateCouponModel> createCoupon({required String amount, required String quantity});
}
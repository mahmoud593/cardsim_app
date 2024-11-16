import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/helper/material_navigation.dart';
import 'package:games_app/features/coupons/data/models/coupon_model.dart';
import 'package:games_app/features/coupons/data/models/create_coupon_model.dart';
import 'package:games_app/features/coupons/presentation/cubit/coupons_state.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/widgets/toast.dart';

import '../../data/coupons_repo_implement/coupons_repo_implement.dart';
import '../view/coupons_screen.dart';


class CouponsCubit extends Cubit<CouponsStates> {
  CouponsCubit() : super(CouponsInitialState());

  static CouponsCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();

  TextEditingController couponAmount = TextEditingController();
  TextEditingController couponCount = TextEditingController();


  CouponsDataModel couponDataModel = CouponsDataModel(
      status: false,
      total: 0,
      data: [],
  );

  Future <void> getCoupons({required String search}) async {
    couponDataModel = CouponsDataModel(
      status: false,
      total: 0,
      data: [],
    );
    emit(GetCouponsLoadingState());
    try {
      couponDataModel = await CouponsRepoImplement().getCoupons(search: search);
      debugPrint("get Coupons >***************************************> ${couponDataModel.data.length}");
      debugPrint("get Coupons >***************************************> ${couponDataModel.toString()}");
      emit(GetCouponsSuccessState());
    } catch (e) {
      emit(GetCouponsErrorState());
      debugPrint("get Copons error >***************************************> ${e
          .toString()}");
    }
  }

  CreateCouponModel createCouponModel = CreateCouponModel(status: false, message: "", messageAr: "");

  Future<void> createCoupons({required BuildContext context,required String amount, required String quantity}) async {
    emit(CreateCouponLoadingState());
    try {
      createCouponModel = await CouponsRepoImplement().createCoupon(amount: amount, quantity: quantity);
      if(createCouponModel.status == true){
        customToast(title: createCouponModel.messageAr, color: ColorManager.success);
        couponAmount.clear();
        couponCount.clear();
        customPushReplacement(context, const CouponsScreen());
      }else{
        customToast(title:createCouponModel.messageAr, color: ColorManager.error);
      }
      emit(CreateCouponSuccessState());
    } catch (e) {
      debugPrint("Create Copons error >***************************************> ${e
          .toString()}");
      emit(CreateCouponErrorState());
    }
  }


}
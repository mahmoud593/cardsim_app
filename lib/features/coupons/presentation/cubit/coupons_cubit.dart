import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/coupons/presentation/cubit/coupons_state.dart';


class CouponsCubit extends Cubit<CouponsStates> {
  CouponsCubit() : super(CouponsInitialState());

  static CouponsCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();

  TextEditingController couponAmount = TextEditingController();
  TextEditingController couponCount = TextEditingController();




}
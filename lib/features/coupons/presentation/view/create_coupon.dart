import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/features/coupons/presentation/cubit/coupons_cubit.dart';
import 'package:games_app/features/coupons/presentation/cubit/coupons_state.dart';
import 'package:games_app/features/coupons/presentation/view/coupons_screen.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/default_button.dart';
import 'package:games_app/styles/widgets/default_text_field.dart';
class CreateCoupon extends StatelessWidget {
  const CreateCoupon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CouponsCubit, CouponsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'أنشاء قسيمة',
              style: TextStyles.textStyle24Medium,
            ),
            centerTitle: true,
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,

            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.02),
              child:  Form(
                key: CouponsCubit.get(context).formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeConfig.height * 0.05),

                    DefaultTextField(
                      controller: CouponsCubit.get(context).couponAmount,
                      hintText: 'القيمة (أقل قيمة 5)',
                      validator: (value) {
                        return "القيمة يجب ان تكون عدد واحد على الاقل";
                      },
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      fillColor: Colors.transparent,
                    ),

                    SizedBox(height: SizeConfig.height * 0.02),

                    DefaultTextField(
                      controller: CouponsCubit.get(context).couponCount,
                      hintText: 'العدد',
                      validator: (value) {
                        return "العدد يجب ان يكون عدد واحد على الاقل";
                      },
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      fillColor: Colors.transparent,
                    ),


                    SizedBox(height: SizeConfig.height * 0.05),

                    DefaultButton(
                      onPressed: (){
                        if(CouponsCubit.get(context).formKey.currentState!.validate()){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const CouponsScreen()));
                        }
                      },
                      borderRadius: BorderRadius.circular(SizeConfig.height*0.01),
                      text: "تأكيد الطلب",
                      backgroundColor: ColorManager.success,
                      haveIcon: false,
                      textStyle: TextStyles.textStyle14Medium.copyWith(
                          color: ColorManager.white
                      ),
                      width: SizeConfig.width,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

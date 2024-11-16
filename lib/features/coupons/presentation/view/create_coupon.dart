import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/features/coupons/presentation/cubit/coupons_cubit.dart';
import 'package:games_app/features/coupons/presentation/cubit/coupons_state.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/default_button.dart';
import 'package:games_app/styles/widgets/default_text_field.dart';
import 'package:games_app/styles/widgets/loading_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class CreateCoupon extends StatelessWidget {
  const CreateCoupon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CouponsCubit, CouponsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is CreateCouponLoadingState? true : false,
          progressIndicator: const LoadingAnimationWidget(),
          color: Colors.transparent,
          child: Scaffold(
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
                          if(value == null || value.isEmpty){
                            return "القيمة يجب ان تكون عدد واحد على الاقل";
                          }
                          else if(int.parse(value!) < 5){
                            return "القيمة يجب ان تكون القيمة 5 او اكبر من 5";
                          }else{
                            return null;
                          }
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
                          if(value == null || value.isEmpty) {
                            return "العدد يجب ان يكون عدد واحد على الاقل";
                          }else{
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        fillColor: Colors.transparent,
                      ),


                      SizedBox(height: SizeConfig.height * 0.05),

                      DefaultButton(
                        onPressed: () async {
                          if(CouponsCubit.get(context).formKey.currentState!.validate()){
                            await CouponsCubit.get(context).createCoupons(amount: CouponsCubit.get(context).couponAmount.text, quantity: CouponsCubit.get(context).couponCount.text, context: context);
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
          ),
        );
      },
    );
  }
}

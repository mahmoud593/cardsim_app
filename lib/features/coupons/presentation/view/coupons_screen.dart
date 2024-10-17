import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/core/helper/material_navigation.dart';
import 'package:games_app/features/coupons/presentation/cubit/coupons_cubit.dart';
import 'package:games_app/features/coupons/presentation/cubit/coupons_state.dart';
import 'package:games_app/features/coupons/presentation/view/create_coupon.dart';
import 'package:games_app/features/coupons/presentation/view/widgets/coupons_card_widget.dart';
import 'package:games_app/features/coupons/presentation/view/widgets/coupons_carousel_view.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:games_app/styles/widgets/custom_search_field.dart';
import 'package:games_app/styles/widgets/default_button.dart';

class CouponsScreen extends StatelessWidget {
  const CouponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CouponsCubit, CouponsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'القسائم',
              style: TextStyles.textStyle24Medium,
            ),
            centerTitle: true,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            //color: ColorManager.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.02),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: SizeConfig.height * 0.01,),

                  const CustomSearchField(
                    hintText: "البحث...",
                    suffixIcon: Icons.search,
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

                  const CouponsCarouselView(),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

                  DefaultButton(
                    onPressed: (){
                      customPushNavigator(context, const CreateCoupon());
                    },
                    borderRadius: BorderRadius.circular(SizeConfig.height*0.01),
                    text: "شراء قسائم",
                    backgroundColor: ColorManager.success,
                    haveIcon: true,
                    icon: Icons.card_membership,
                    textStyle: TextStyles.textStyle14Medium.copyWith(
                        color: ColorManager.white
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

                  Expanded(
                    child: ListView(
                      children: const [
                        CouponsCard(
                          username: 'Visa',
                          amount: 100.00,
                          status: 'completed',
                          coupon: '12345',
                          createdAt:  '2023-10-06 16:20:00',
                          buyedAtDate: '2023-10-06 16:20:00',
                        ),
                        CouponsCard(
                          username: 'Visa',
                          amount: 100.00,
                          status: 'pending',
                          coupon: '12345',
                          createdAt:  '2023-10-06 16:20:00',
                          buyedAtDate: '2023-10-06 16:20:00',
                        ),
                        // Add more CouponsCard widgets here
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

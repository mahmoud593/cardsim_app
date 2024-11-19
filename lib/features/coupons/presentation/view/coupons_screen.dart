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
import 'package:games_app/styles/widgets/loading_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {

  @override
  void initState() {
    super.initState();
    CouponsCubit.get(context).getCoupons(search: "");
  }

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
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            //color: ColorManager.white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: SizeConfig.height * 0.01,
                  ),
                  CustomSearchField(
                    hintText: "البحث...",
                    suffixIcon: Icons.search,
                    onChanged: (value) async {
                      await CouponsCubit.get(context).getCoupons(search: value);
                    },
                    onSubmitted: (value) async {
                      await CouponsCubit.get(context).getCoupons(search: value);
                    },
                    onClear: () async {
                      await CouponsCubit.get(context).getCoupons(search: "");
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  CouponsCarouselView(
                      total: CouponsCubit.get(context).couponDataModel.total,
                      used: CouponsCubit.get(context).couponDataModel.used,
                      unused: CouponsCubit.get(context).couponDataModel.notUsed),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  DefaultButton(
                    onPressed: () {
                      customPushNavigator(context, const CreateCoupon());
                    },
                    borderRadius:
                        BorderRadius.circular(SizeConfig.height * 0.01),
                    text: "شراء قسائم",
                    backgroundColor: ColorManager.success,
                    haveIcon: true,
                    icon: Icons.card_membership,
                    textStyle: TextStyles.textStyle14Medium
                        .copyWith(color: ColorManager.white),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Expanded(
                    child: ModalProgressHUD(
                      inAsyncCall: state is GetCouponsLoadingState,
                      progressIndicator: const LoadingAnimationWidget(),
                      color: Colors.transparent,
                      child: CouponsCubit.get(context)
                              .couponDataModel
                              .data
                              .isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: CouponsCubit.get(context)
                                  .couponDataModel
                                  .data
                                  .length,
                              itemBuilder: (context, index) => CouponsCard(
                                username: CouponsCubit.get(context)
                                    .couponDataModel
                                    .data[index]
                                    .usedIn,
                                amount: CouponsCubit.get(context)
                                    .couponDataModel
                                    .data[index]
                                    .amount
                                    .toString(),
                                status: CouponsCubit.get(context)
                                    .couponDataModel
                                    .data[index]
                                    .status,
                                coupon: CouponsCubit.get(context)
                                    .couponDataModel
                                    .data[index]
                                    .code,
                                createdAt: CouponsCubit.get(context)
                                    .couponDataModel
                                    .data[index]
                                    .createdAt,
                                buyedAtDate: CouponsCubit.get(context)
                                    .couponDataModel
                                    .data[index]
                                    .createdAt,
                              ),
                            )
                          : Center(
                              child: Text(
                                'لا يوجد بيانات لعرضها',
                                style: TextStyles.textStyle18Medium,
                              ),
                            ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

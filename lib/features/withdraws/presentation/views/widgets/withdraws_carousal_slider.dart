import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/core/constants/app_session.dart';
import 'package:games_app/features/withdraws/presentation/controller/client_order_cubit/client_order_cubit.dart';
import 'package:games_app/features/withdraws/presentation/controller/withdraws_cubit/withdraws_cubit.dart';
import 'package:games_app/features/withdraws/presentation/views/widgets/withdraws_carousal_Item.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../generated/assets.dart';

class WithdrawsCarousalSlider extends StatelessWidget {
  const WithdrawsCarousalSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 160,
        viewportFraction: MediaQuery.of(context).size.width > 600 ? 0.3 : 0.6,
        enlargeCenterPage: true,
        autoPlay: true,
        enableInfiniteScroll: false,
        pauseAutoPlayInFiniteScroll: false,
      ),
      items: [
         WithdrawsCarousalItem(
          image:  Assets.imagesDollarSquare,
          value: AppSession.userInfoModel!.distProfit!,
          title: 'الأرباح',
        ),
        BlocBuilder<WithdrawsCubit, WithdrawsState>(
          builder: (context, state) {
            if (state is WithdrawsLoadingState) {
              return const Skeletonizer(
                enabled: true,
                child: WithdrawsCarousalItem(
                  image: Assets.imagesDollarSquare,
                  value: '...',
                  title: 'قيد المراجعة',
                ),
              );
            } else if (state is WithdrawsSuccessState) {
              var amountSum = context.read<WithdrawsCubit>().waitingAmountSum;
              return WithdrawsCarousalItem(
                image: Assets.imagesDollarSquare,
                value: '$amountSum\$',
                title: 'قيد المراجعة',
              );
            } else if (state is WithdrawsFailureState) {
              // Error state
              return const WithdrawsCarousalItem(
                image: Assets.imagesDollarSquare,
                value: 'Error loading data',
                title: 'قيد المراجعة',
              );
            } else {
              return const WithdrawsCarousalItem(
                image: Assets.imagesDollarSquare,
                value: 'N/A',
                title: 'قيد المراجعة',
              );
            }
          },
        ),
        BlocBuilder<ClientOrderCubit, ClientOrderState>(
          builder: (context, state) {
            var clientOrderEntity =
                context.read<ClientOrderCubit>().clientOrderEntity;
            if (state is ClientOrdersLoadingState) {
              return const Skeletonizer(
                enabled: true,
                child: WithdrawsCarousalItem(
                  image: Assets.imagesDeviceTablet,
                  value: '...',
                  title: 'عدد العمليات',
                ),
              );
            } else if (state is ClientOrdersSuccessState &&
                clientOrderEntity != null) {
              return WithdrawsCarousalItem(
                image: Assets.imagesDeviceTablet,
                value: '${clientOrderEntity.total}',
                title: 'عدد العمليات',
              );
            } else if (state is ClientOrdersFailureState) {
              return const WithdrawsCarousalItem(
                image: Assets.imagesDeviceTablet,
                value: 'N/A',
                title: 'عدد العمليات',
              );
            } else {
              return const WithdrawsCarousalItem(
                image: Assets.imagesDeviceTablet,
                value: 'N/A',
                title: 'عدد العمليات',
              );
            }
          },
        ),
      ],
    );
  }
}

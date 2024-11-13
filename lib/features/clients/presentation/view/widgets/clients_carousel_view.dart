import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/clients/presentation/cubit/client_cubit.dart';
import 'package:games_app/features/clients/presentation/cubit/client_state.dart';
import 'package:games_app/features/coupons/presentation/view/widgets/coupon_card_count_widget.dart';

class ClientsCarouselView extends StatelessWidget {
  const ClientsCarouselView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientCubit,ClientState>(
      builder: (context, state) {
        return CarouselSlider(
          options: CarouselOptions(
            height: 80,
            viewportFraction: MediaQuery.of(context).size.width > 600 ? 0.3 : 0.6,
            enlargeCenterPage: true,
            autoPlay: true,
          ),
          items:  [
            CouponCardCountWidget(count: ClientCubit.get(context).clientsList.length, title: 'عدد العملاء',),
            const CouponCardCountWidget(count: 0, title: 'مجموع الرصيد',),
          ],
        );
      },
    );
  }
}
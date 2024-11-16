import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:games_app/features/coupons/presentation/view/widgets/coupon_card_count_widget.dart';

class CouponsCarouselView extends StatelessWidget {
  final int total;
  final int used;
  final int unused;
  const CouponsCarouselView({super.key, required this.total, required this.used, required this.unused});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 80,
        viewportFraction: MediaQuery.of(context).size.width > 600 ? 0.3 : 0.6,
        enlargeCenterPage: true,
        autoPlay: true,
      ),
      items:  [
        CouponCardCountWidget(count: total, title: 'عدد القسائم',),
        CouponCardCountWidget(count: total, title: 'تم استخدامها',),
        CouponCardCountWidget(count: total, title: 'لم يتم استخدامها',),
      ],
    );
  }
}
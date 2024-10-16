import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:games_app/features/coupons/presentation/view/widgets/coupon_card_count_widget.dart';

class CouponsCarouselView extends StatelessWidget {
  const CouponsCarouselView({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 80,
        viewportFraction: MediaQuery.of(context).size.width > 600 ? 0.3 : 0.6,
        enlargeCenterPage: true,
        autoPlay: true,
      ),
      items: const [
        CouponCardCountWidget(count: 2, title: 'عدد القسائم',),
        CouponCardCountWidget(count: 0, title: 'تم استخدامها',),
        CouponCardCountWidget(count: 2, title: 'لم يتم استخدامها',),
      ],
    );
  }
}
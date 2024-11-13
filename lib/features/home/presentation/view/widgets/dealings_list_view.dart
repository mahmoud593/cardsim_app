import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:games_app/features/home/presentation/view/widgets/dealings_list_view_item.dart';

class DealingsListView extends StatelessWidget {
  const DealingsListView({super.key});

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
        DealingsListViewItem(value: 'test.00\$', title: 'الرصيد'),
        DealingsListViewItem(value: 'test', title: 'الطلبات قيد الانتظار'),
        DealingsListViewItem(value: 'test.00\$', title: 'عمليات قيد الانتظار'),
        DealingsListViewItem(value: 'test', title: 'طلبات مرفوضه'),
        DealingsListViewItem(value: 'test', title: 'جميع الطلبات'),
      ],
    );
  }
}
/*SizedBox(
      height: 80,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return const DealingsListViewItem();
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: 16,
            );
          },
          itemCount: 5),
    )*/

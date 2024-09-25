import 'package:flutter/material.dart';
import 'package:games_app/core/constants/constants.dart';

class DealingsListViewItem extends StatelessWidget {
  const DealingsListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Constants.defaultRadius),
        border: Border.all(color: const Color(0xffE0E0E0), width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(right: 12),
        title: const Text(
          '0',
          style: TextStyle(
            fontSize: 25,
            height: 1,
            fontWeight: FontWeight.bold,

          ),
        ),
        subtitle: const Text('طلبات قيد الانتظار'),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ),
    );
  }
}

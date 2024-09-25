import 'package:flutter/material.dart';

import '../../../../../generated/assets.dart';

class RequestOrderListViewItem extends StatelessWidget {
  const RequestOrderListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Image.asset(
            Assets.imagesCat,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 30,
              color: Colors.black54,
              child: const Center(
                child: Text(
                  'Ahlan, حسب الطلب',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              color: Colors.black.withOpacity(0.5),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '0.000054\$',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Text(
                    '0.000054\$',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ), // Semi-transparent for better visibility
            ),
          ),
        ],
      ),
    );
  }
}

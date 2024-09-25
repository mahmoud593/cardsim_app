import 'package:flutter/material.dart';

class RequestOrderBlueContainer extends StatelessWidget {
  const RequestOrderBlueContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xffEDF1FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 0.4,
          color: Colors.blueAccent,
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(

            Icons.info_outline,
            color: Colors.blueAccent,
          ),
          Expanded(
            child: Text(
              'هذا المنتج يعمل بشكل آلي على مدار الساعة',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }
}
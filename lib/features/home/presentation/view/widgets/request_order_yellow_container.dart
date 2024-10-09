import 'package:flutter/material.dart';

class RequestOrderYellowContainer extends StatelessWidget {
  const RequestOrderYellowContainer({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xffFAEDED),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 0.4,
          color: Colors.orange,
        ),
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange,
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.orange,
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

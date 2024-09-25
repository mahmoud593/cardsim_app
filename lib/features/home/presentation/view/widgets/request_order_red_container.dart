import 'package:flutter/material.dart';

class RequestOrderRedContainer extends StatelessWidget {
  const RequestOrderRedContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xffFAEDED),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 0.4,
          color: Colors.redAccent,
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.not_interested,
            color: Colors.redAccent,
            size: 12,
          ),
          Expanded(
            child: Text(
              'تعميم هام: بالنسبة للعبة ببجي نحن مسؤولين عن عدد الشدات الواصلة للزبون فقط لا غير ولسنا مسؤولين عن أية عروض داخل اللعبة',
              style: TextStyle(
                color: Colors.redAccent,
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
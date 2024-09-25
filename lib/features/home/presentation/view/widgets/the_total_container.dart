import 'package:flutter/material.dart';

import '../../../../../styles/colors/color_manager.dart';

class TheTotalContainer extends StatelessWidget {
  const TheTotalContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      decoration: const BoxDecoration(
        color: ColorManager.primary,
      ),
      alignment: AlignmentDirectional.centerStart,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: const Text(
        '0',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

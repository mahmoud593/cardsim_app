import 'package:flutter/material.dart';

import '../../../../../styles/colors/color_manager.dart';

class PlayerIdSearchSection extends StatelessWidget {
  const PlayerIdSearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                decoration: const InputDecoration(
                  hintText: 'رقم اللاعب',
                  hintStyle: TextStyle(
                    color: Color(0xFF949D9E),
                  ),
                  border: InputBorder.none,
                  fillColor: ColorManager.primary,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: const Text(
                'ابحث',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          style: const TextStyle(color: Colors.white),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          decoration: const InputDecoration(
            hintStyle: TextStyle(
              color: Color(0xFF949D9E),
            ),
            border: InputBorder.none,
            fillColor: ColorManager.primary,
            filled: true,
          ),
        )
      ],
    );
  }
}

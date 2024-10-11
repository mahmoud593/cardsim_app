import 'package:flutter/material.dart';
import 'package:games_app/features/home/domain/entities/products_entity.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

import '../../../../../styles/colors/color_manager.dart';

class PlayerIdSearchSection extends StatelessWidget {
  const PlayerIdSearchSection({super.key, required this.productsEntity});

  final ProductsEntity productsEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: productsEntity.field!.name,
                style: TextStyles.textStyle14Medium,
              ),
               TextSpan(
                text: ' (إجباري)',
                style:TextStyles.textStyle14Medium.copyWith(color: Colors.red) ,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(
                  hintText: productsEntity.field!.name,
                  hintStyle: const TextStyle(
                    color: Color(0xFF949D9E),
                  ),
                  border: InputBorder.none,
                  fillColor: ColorManager.primary,
                  filled: true,
                ),
              ),
            ),
            if (productsEntity.field!.fieldCheck == true) ...[
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
            ]
          ],
        ),
        if (productsEntity.field!.fieldCheckType != '') ...[
          const SizedBox(
            height: 8,
          ),
          if(productsEntity.field!.fieldCheckRequired == true) ...[
            const SizedBox(height: 8,),
            const Text(
              'يرجى التحقق من رقم اللاعب قبل إرسال الطلب',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8,),
          ],
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
        ]
      ],
    );
  }
}

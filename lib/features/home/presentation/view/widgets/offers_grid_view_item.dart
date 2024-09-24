import 'package:flutter/material.dart';
import 'package:games_app/core/constants/constants.dart';

import '../../../../../generated/assets.dart';

class OffersGridViewItem extends StatelessWidget {
  const OffersGridViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 120,
            width: 150,
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 30,
                  spreadRadius: -30,
                  offset: Offset(0, 5))
            ]),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Constants.defaultRadius),
              ),
              surfaceTintColor: Colors.white,
              elevation: 10,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'fdkjfd',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 25,
              left: 8.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  Assets.imagesCat,
                  scale: 1.88,
                ),
              ))
        ],
      ),
    );
  }
}

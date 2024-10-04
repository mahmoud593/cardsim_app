import 'package:flutter/material.dart';
import 'package:games_app/generated/assets.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/constants/constants.dart';

class LoadingGridView extends StatelessWidget {
  const LoadingGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        clipBehavior: Clip.none,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
          MediaQuery.of(context).orientation.index == 0 ? 2 : 3,
          childAspectRatio: 1.4,
          mainAxisSpacing: 55,
          crossAxisSpacing: 0.0,
        ),
        itemBuilder: (context, index) {
          return const Center(
              child: LoadingGridViewItem());
        });
  }
}

class LoadingGridViewItem extends StatelessWidget {
  const LoadingGridViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
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
                          'dummy',
                          style: TextStyle(fontSize: 14),
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
            ),
          )
        ],
      ),
    );
  }
}




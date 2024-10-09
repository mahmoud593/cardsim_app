import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:games_app/core/constants/constants.dart';
import 'package:games_app/core/helper/material_navigation.dart';
import 'package:games_app/features/home/domain/entities/companies_entity.dart';
import 'package:games_app/features/home/presentation/view/widgets/request_order_screen.dart';

class OffersGridViewItem extends StatelessWidget {
  const OffersGridViewItem({super.key, required this.companiesEntity});

  final CompaniesEntity companiesEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        customPushNavigator(
            context,
            RequestOrderScreen(
              companiesEntity: companiesEntity,
            ));
      },
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          companiesEntity.name,
                          style: const TextStyle(fontSize: 14),
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
              child: CachedNetworkImage(
                imageUrl: companiesEntity.image,
                scale: 1.88,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          )
        ],
      ),
    );
  }
}

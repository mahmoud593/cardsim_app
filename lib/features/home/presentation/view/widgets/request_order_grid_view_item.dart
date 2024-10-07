import 'package:flutter/material.dart';
import 'package:games_app/features/home/domain/entities/products_entity.dart';

class RequestOrderListViewItem extends StatelessWidget {
  const RequestOrderListViewItem({super.key, required this.productsEntity});

  final ProductsEntity productsEntity;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Image.network(
            productsEntity.image,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black54,
              padding:  const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      productsEntity.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,

                      ),
                    ),
                  ),
                ],
              ),
            )
            ,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 45,
              color: Colors.black.withOpacity(0.5),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${productsEntity.price}\$',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Text(
                    '${productsEntity.price}LE',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

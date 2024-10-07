import 'package:games_app/features/home/domain/entities/field_entity.dart';
import 'package:games_app/features/home/domain/entities/quantity_entity.dart';

class ProductsEntity {
  final int id;
  final String name;
  final String price;
  final QuantityEntity? quantity;
  final FieldEntity? field;
  final String status;
  final String image;

  ProductsEntity({
    required this.id,
    required this.name,
    required this.price,
    this.quantity,
    this.field,
    required this.status,
    required this.image,
  });
}

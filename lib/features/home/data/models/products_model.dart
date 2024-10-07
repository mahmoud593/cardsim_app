import 'package:games_app/features/home/data/models/quantity_model.dart';

import '../../domain/entities/products_entity.dart';
import 'field_model.dart';

class ProductsModel extends ProductsEntity {
  ProductsModel(
      {required super.id,
      required super.name,
      required super.price,
      required super.quantity,
      required super.field,
      required super.status,
      required super.image});

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantite'] != null
          ? QuantityModel.fromJson(json['quantite'])
          : null,
      field: json['field'] != null
          ? FieldModel.fromJson(json['field'])
          : null,
      status: json['status'],
      image: json['image'],
    );
  }

  @override
  String toString() =>
      'ProductsModel(id: $id, name: $name, price: $price, quantity: $quantity, field: $field, status: $status, image: $image)';
}

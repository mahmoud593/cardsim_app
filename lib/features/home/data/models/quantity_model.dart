import '../../domain/entities/quantity_entity.dart';

class QuantityModel extends QuantityEntity {
  QuantityModel({ super.min,  super.max});

  factory QuantityModel.fromJson(Map<String, dynamic> json) {
    return QuantityModel(
      min: json['min'] as int?,
      max: json['max'] as int?,
    );
  }

  @override
  String toString() => 'QuantityModel(min: $min, max: $max)';
}
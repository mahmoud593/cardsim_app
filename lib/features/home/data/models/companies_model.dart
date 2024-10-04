import '../../domain/entities/companies_entity.dart';

class CompaniesModel extends CompaniesEntity {
  CompaniesModel({
    required super.name,
    required super.image,
    required super.id,
    required super.category,
  });

  factory CompaniesModel.fromJson(Map<String, dynamic> json) {
    return CompaniesModel(
      name: json['name'],
      image: json['image'],
      id: json['id'],
      category: json['category'],
    );
  }

  @override
  String toString() =>
      'CompaniesModel(name: $name, image: $image, id: $id, category: $category)';
}

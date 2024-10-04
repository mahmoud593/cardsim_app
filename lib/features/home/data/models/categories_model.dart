import '../../domain/entities/categories_entity.dart';

class CategoriesModel extends CategoriesEntity {
  CategoriesModel({
    required super.id,
    required super.name,
    required super.image,
    required super.slug,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      slug: json['slug'],
    );
  }

  @override
  String toString() =>
      'CategoriesModel(id: $id, name: $name, image: $image), slug: $slug)';
}

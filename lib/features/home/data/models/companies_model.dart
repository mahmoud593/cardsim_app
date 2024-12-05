import 'package:games_app/features/home/data/models/notes_model.dart';

import '../../domain/entities/companies_entity.dart';

class CompaniesModel extends CompaniesEntity {
  CompaniesModel({
    required super.name,
    required super.image,
    required super.id,
    required super.category,
    required super.status,
    super.notes,
  });

  factory CompaniesModel.fromJson(Map<String, dynamic> json) {
    return CompaniesModel(
      name: json['name'],
      image: json['image'],
      id: json['id'],
      category: json['category'],
      status: json['status'],
      notes: (json['notes'] is List)
          ? (json['notes'] as List<dynamic>)
          .map((noteJson) => NotesModel.fromJson(noteJson))
          .toList()
          : [],
    );
  }

  @override
  String toString() =>
      'CompaniesModel(name: $name, image: $image, id: $id, category: $category, notes: $notes)';
}

import 'notes_entity.dart';

class CompaniesEntity {
  final String name;
  final String image;
  final int id;
  final String category;
  final String status;
  final List<NotesEntity>? notes;

  CompaniesEntity({
    required this.name,
    required this.image,
    required this.id,
    required this.category,
    required this.status,
    this.notes,
  });

}

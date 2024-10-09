import 'notes_entity.dart';

class CompaniesEntity {
  final String name;
  final String image;
  final int id;
  final String category;
  final List<NotesEntity>? notes;

  CompaniesEntity({
    required this.name,
    required this.image,
    required this.id,
    required this.category,
    this.notes,
  });

}

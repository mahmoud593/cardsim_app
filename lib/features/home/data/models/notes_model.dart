import '../../domain/entities/notes_entity.dart';

class NotesModel extends  NotesEntity{
  NotesModel(super.id, super.type, super.text);

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      json['id'],
      json['type'],
      json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'text': text,
    };
  }

  @override
  String toString() {
    return 'NotesModel(id: $id, type: $type, text: $text)';
  }

}
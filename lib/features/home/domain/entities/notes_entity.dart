class NotesEntity{

  final int? id;
  final String? type;
  final String? text;

  NotesEntity(this.id, this.type, this.text);

  @override
  String toString() {
    return 'NotesEntity(id: $id, type: $type, text: $text)';
  }
}
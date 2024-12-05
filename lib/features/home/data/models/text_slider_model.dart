import 'package:games_app/features/home/domain/entities/text_slider_entity.dart';

class TextSliderModel extends TextSliderEntity{
  TextSliderModel({required super.id, required super.content});

  factory TextSliderModel.fromJson(Map<String, dynamic> json) {
    return TextSliderModel(
      id: json['id'],
      content: json['content'],
    );
  }
  @override
  String toString() {
    return 'TextSliderModel{id: $id, content: $content}';
  }
}
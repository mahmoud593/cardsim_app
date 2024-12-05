import '../../domain/entities/image_slider_entity.dart';

class ImageSliderModel extends ImageSliderEntity {
  ImageSliderModel({
    required super.id,
    required super.image,
    required super.imageUrl,
  });

  factory ImageSliderModel.fromJson(Map<String, dynamic> json) => ImageSliderModel(
        id: json['id'],
        image: json['image'],
        imageUrl: json['image_url'],
      );
  
}

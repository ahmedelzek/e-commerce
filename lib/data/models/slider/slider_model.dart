import '../../../domain/entities/slider/slider_entity.dart';

class SliderModel extends SliderEntity {
  const SliderModel({
    super.id,
    super.title,
    super.description,
    super.imagePath,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      imagePath: json['image_path'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image_path': imagePath,
    };
  }
}

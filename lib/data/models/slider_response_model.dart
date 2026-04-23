import '../../domain/entities/slider_response_entity.dart';
import 'slider_model.dart';

class SliderResponseModel extends SliderResponseEntity {
  const SliderResponseModel({
    required super.status,
    required super.sliders,
  });

  factory SliderResponseModel.fromJson(Map<String, dynamic> json) {
    return SliderResponseModel(
      status: json['status'] as bool,
      sliders: (json['sliders'] as List<dynamic>)
          .map((e) => SliderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'sliders': sliders
          .map((e) => (e as SliderModel).toJson())
          .toList(),
    };
  }
}
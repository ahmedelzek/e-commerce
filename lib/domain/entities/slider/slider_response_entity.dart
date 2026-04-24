import 'slider_entity.dart';

class SliderResponseEntity {
  final bool status;
  final List<SliderEntity> sliders;

  const SliderResponseEntity({
    required this.status,
    required this.sliders,
  });
}
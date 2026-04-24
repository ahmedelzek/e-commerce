import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/entities/slider/slider_response_entity.dart';

abstract class GetSliderRepo{
  Future<Either<String, SliderResponseEntity>> getSliders();
}
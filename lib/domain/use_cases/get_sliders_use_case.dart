import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/entities/slider_response_entity.dart';
import 'package:e_commerce/domain/contract/get_slider_repo.dart';

class GetSliderUseCase {
  final GetSliderRepo repo ;
  GetSliderUseCase({required this.repo});
  Future<Either<String, SliderResponseEntity>> call()=> repo.getSliders();
}
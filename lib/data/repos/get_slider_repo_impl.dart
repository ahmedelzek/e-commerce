import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/network/api_helper.dart';
import 'package:e_commerce/core/network/end_points.dart';
import 'package:e_commerce/data/models/slider_response_model.dart';
import 'package:e_commerce/domain/entities/slider_response_entity.dart';
import 'package:e_commerce/domain/contract/get_slider_repo.dart';

import '../../core/network/api_response.dart';

class GetSlidersRepoImpl extends GetSliderRepo {
  final APIHelper apiHelper;

  GetSlidersRepoImpl({required this.apiHelper});

  @override
  Future<Either<String, SliderResponseEntity>> getSliders() async {
    try {
      var result = await apiHelper.getRequest(
        endPoint: EndPoints.getSliders,
      );

      if (result.status) {
        var sliderResponse = SliderResponseModel.fromJson(
          result.data as Map<String, dynamic>,
        );

        return Right(sliderResponse);
      } else {
        return left(result.message);
      }
    } catch (e) {
      return left(ApiResponse.fromError(e).message);
    }
  }
}

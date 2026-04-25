import 'package:dartz/dartz.dart';
import 'package:e_commerce/data/models/category/category_response_model.dart';
import 'package:e_commerce/domain/contract/category_repo.dart';
import 'package:e_commerce/domain/entities/category/category_response_entity.dart';

import '../../core/network/api_helper.dart';
import '../../core/network/api_response.dart';
import '../../core/network/end_points.dart';

class CategoryRepoImpl extends CategoryRepo {
  final APIHelper apiHelper;

  CategoryRepoImpl({required this.apiHelper});

  @override
  Future<Either<String, CategoryResponseEntity>> getCategories() async {
    try {
      var result = await apiHelper.getRequest(endPoint: EndPoints.categories);

      if (result.status) {
        var categoryResponse = CategoryResponseModel.fromJson(
          result.data as Map<String, dynamic>,
        );

        return Right(categoryResponse);
      } else {
        return left(result.message);
      }
    } catch (e) {
      return left(ApiResponse.fromError(e).message);
    }
  }
}

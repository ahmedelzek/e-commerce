import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/network/api_helper.dart';
import 'package:e_commerce/data/models/product/product_model_response.dart';
import 'package:e_commerce/domain/contract/product_repo.dart';
import 'package:e_commerce/domain/entities/product/product_entity_response.dart';

import '../../core/network/api_response.dart';
import '../../core/network/end_points.dart';

class ProductRepoImpl extends ProductRepo {
  final APIHelper apiHelper;

  ProductRepoImpl({required this.apiHelper});

  @override
  Future<Either<String, ProductResponseEntity>> getProducts() async {
    try {
      var result = await apiHelper.getRequest(endPoint: EndPoints.products);

      if (result.status) {
        var productResponse = ProductResponseModel.fromJson(
          result.data as Map<String, dynamic>,
        );

        return Right(productResponse);
      } else {
        return left(result.message);
      }
    } catch (e) {
      return left(ApiResponse.fromError(e).message);
    }
  }
}

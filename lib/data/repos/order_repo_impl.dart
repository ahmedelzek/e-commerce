import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/network/api_helper.dart';
import 'package:e_commerce/core/network/api_response.dart';
import 'package:e_commerce/core/network/end_points.dart';
import 'package:e_commerce/data/models/order/order_item_model.dart';
import 'package:e_commerce/data/models/order/order_requset_model.dart';
import 'package:e_commerce/data/models/order/orders_model.dart';
import 'package:e_commerce/data/models/order/place_order_response_model.dart';
import 'package:e_commerce/domain/contract/order_repo.dart';
import 'package:e_commerce/domain/entities/order/order_item_entity.dart';
import 'package:e_commerce/domain/entities/order/orders_entity.dart';
import 'package:e_commerce/domain/entities/order/place_order_response_entity.dart';

import '../../domain/entities/order/order_requast_entity.dart';

class OrderRepoImpl extends OrderRepo {
  final APIHelper apiHelper;

  OrderRepoImpl({required this.apiHelper});


  @override
  Future<Either<String, PlaceOrderResponseEntity>> placeOrder(
      List<OrderItemRequestEntity> items,
      ) async {
    try {
      final body = {
        'items': items
            .map((e) => OrderItemRequestModel(
          productId: e.productId,
          quantity: e.quantity,
        ).toJson())
            .toList(),
      };

      final result = await apiHelper.postRequest(
        endPoint: EndPoints.placeOrder,
        data: body,
        isFormData: false,
      );

      if (result.status) {
        return Right(
          PlaceOrderResponseModel.fromJson(result.data as Map<String, dynamic>),
        );
      }
      return Left(result.message);
    } catch (e) {
      return Left(ApiResponse.fromError(e).message);
    }
  }


  @override
  Future<Either<String, PlaceOrderResponseEntity>> cancelOrder(
      int orderId,
      ) async {
    try {
      final result = await apiHelper.postRequest(
        endPoint: EndPoints.cancelOrder,
        data: {'order_id': orderId},
      );

      if (result.status) {
        return Right(
          PlaceOrderResponseModel.fromJson(result.data as Map<String, dynamic>),
        );
      }
      return Left(result.message);
    } catch (e) {
      return Left(ApiResponse.fromError(e).message);
    }
  }


  @override
  Future<Either<String, PlaceOrderResponseEntity>> completeOrder(
      int orderId,
      ) async {
    try {
      final result = await apiHelper.postRequest(
        endPoint: EndPoints.completeOrder,
        data: {'order_id': orderId},
      );

      if (result.status) {
        return Right(
          PlaceOrderResponseModel.fromJson(result.data as Map<String, dynamic>),
        );
      }
      return Left(result.message);
    } catch (e) {
      return Left(ApiResponse.fromError(e).message);
    }
  }


  @override
  Future<Either<String, OrdersEntity>> getOrders() async {
    try {
      final result = await apiHelper.getRequest(
        endPoint: EndPoints.getOrders,
      );

      if (result.status) {
        return Right(
          OrdersModel.fromJson(result.data as Map<String, dynamic>),
        );
      }
      return Left(result.message);
    } catch (e) {
      return Left(ApiResponse.fromError(e).message);
    }
  }
}
import 'package:e_commerce/domain/use_cases/get_orders_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/cansel_order_use_case.dart';
import '../../../domain/use_cases/complete_order_use_case.dart';
import 'my_orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUseCase getOrdersUseCase;
  final CancelOrderUseCase cancelOrderUseCase;
  final CompleteOrderUseCase completeOrderUseCase;

  OrdersCubit({
    required this.getOrdersUseCase,
    required this.cancelOrderUseCase,
    required this.completeOrderUseCase,
  }) : super(OrdersInitialState()) {
    getOrders();
  }

  static OrdersCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> getOrders() async {
    emit(OrdersLoadingState());

    final result = await getOrdersUseCase();
    result.fold(
      (error) => emit(OrdersErrorState(error: error)),
      (orders) => emit(OrdersSuccessState(orders: orders)),
    );
  }
  Future<void> cancelOrder(int orderId) async {
    emit(OrdersLoadingState());
    final result = await cancelOrderUseCase(orderId);
    result.fold(
          (error) => emit(OrdersErrorState(error: error)),
          (_) => getOrders(),
    );
  }

  Future<void> completeOrder(int orderId) async {
    emit(OrdersLoadingState());
    final result = await completeOrderUseCase(orderId);
    result.fold(
          (error) => emit(OrdersErrorState(error: error)),
          (_) => getOrders(),
    );
  }
}

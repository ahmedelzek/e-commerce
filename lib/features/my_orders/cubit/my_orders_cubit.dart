import 'package:e_commerce/domain/use_cases/get_orders_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'my_orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUseCase getOrdersUseCase;

  OrdersCubit({required this.getOrdersUseCase}) : super(OrdersInitialState()) {
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
}
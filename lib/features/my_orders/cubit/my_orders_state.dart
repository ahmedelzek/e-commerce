import 'package:e_commerce/domain/entities/order/orders_entity.dart';

abstract class OrdersState {}

class OrdersInitialState extends OrdersState {}
class OrdersLoadingState extends OrdersState {}
class OrdersErrorState extends OrdersState {
  final String error;
  OrdersErrorState({required this.error});
}
class OrdersSuccessState extends OrdersState {
  final OrdersEntity orders;
  OrdersSuccessState({required this.orders});
}
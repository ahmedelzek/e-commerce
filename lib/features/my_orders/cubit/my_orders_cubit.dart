import 'package:e_commerce/domain/use_cases/get_orders_use_case.dart';
import 'package:e_commerce/features/my_orders/cubit/my_orders_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  final GetOrdersUseCase getOrdersUseCase;
  MyOrdersCubit({required this.getOrdersUseCase}) : super(MyOrdersInitialState());

  static MyOrdersCubit get(context) => BlocProvider.of(context);
}

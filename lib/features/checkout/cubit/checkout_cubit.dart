import 'package:e_commerce/domain/entities/order/order_item_entity.dart';
import 'package:e_commerce/features/checkout/cubit/checkout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/place_order_use_case.dart';
import '../../cart/cubit/cart_cubit.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final PlaceOrderUseCase placeOrderUseCase;
  final CartCubit cartCubit;

  CheckoutCubit({required this.placeOrderUseCase, required this.cartCubit})
    : super(CheckoutInitialState());

  static CheckoutCubit get(context) => BlocProvider.of(context);

  checkout(List<OrderItemEntity> items) async {
    emit(CheckoutLoadingState());
    var result = await placeOrderUseCase.call(items);
    result.fold((error) => emit(CheckoutErrorState(error: error)), (
      success,
    ) async {
      print('--- Checkout error: $success');

      await cartCubit.clearCart();
      emit(CheckoutSuccessState(success: success.message));
    });
  }
}

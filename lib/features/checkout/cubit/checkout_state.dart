abstract class CheckoutState {}

class CheckoutInitialState extends CheckoutState {}

class CheckoutLoadingState extends CheckoutState {}

class CheckoutErrorState extends CheckoutState {
  final String error;
  CheckoutErrorState({required this.error});
}

class CheckoutSuccessState extends CheckoutState {
  final String success;
  CheckoutSuccessState({required this.success});
}

abstract class MyOrdersState {}

class MyOrdersInitialState extends MyOrdersState {}

class MyOrdersLoadingState extends MyOrdersState {}

class MyOrdersErrorState extends MyOrdersState {
  final String error;
  MyOrdersErrorState({required this.error});
}

class MyOrdersSuccessState extends MyOrdersState {}

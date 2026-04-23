import 'package:e_commerce/domain/use_cases/get_sliders_use_case.dart';
import 'package:e_commerce/features/master/pages/home/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetSliderUseCase getSliderUseCase;

  HomeCubit({required this.getSliderUseCase}) : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  getData() async {
    emit(HomeLoadingState());
    var result = await getSliderUseCase.call();
    result.fold(
      (error) => emit(HomeErrorState(error: error)),
      (success) => emit(HomeSuccessState(sliderEntity: success.sliders)),
    );
  }
}

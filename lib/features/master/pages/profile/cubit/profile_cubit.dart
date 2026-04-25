import 'package:e_commerce/domain/use_cases/get_user_use_case.dart';
import 'package:e_commerce/features/master/pages/profile/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_router/app_router.dart';
import '../../../../../core/app_router/app_router_keys.dart';
import '../../../../../core/cache/cache_helper.dart';
import '../../../../../core/cache/cache_keys.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserUseCase getUserUseCase;

  ProfileCubit({required this.getUserUseCase}) : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  getUserData() async {
    emit(ProfileLoadingState());
    var result = await getUserUseCase.getUser();

    result.fold(
      (error) => emit(ProfileErrorState(error: error)),
      (response) => emit(ProfileSuccessState(user: response.user)),
    );
  }
  void logout() async {
    await CacheHelper.removeValue(CacheKeys.accessToken);
    await CacheHelper.removeValue(CacheKeys.refreshToken);
    appRouter.go(AppRouterKeys.authKey);
  }
}

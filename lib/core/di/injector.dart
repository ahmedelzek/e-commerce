import 'package:e_commerce/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';

import '../../data/repos/auth_repo_impl.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../../domain/use_cases/register_use_case.dart';
import '../../features/auth/cubit/login/login_cubit.dart';
import '../../features/auth/cubit/register/register_cubit.dart';
import '../network/api_helper.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {

  await APIHelper.init();
  sl.registerLazySingleton<APIHelper>(() => APIHelper());

  //Repos
  sl.registerLazySingleton<AuthRepo>(
        () => AuthRepoImpl(apiHelper: sl()),
  );

  //UseCases
  sl.registerFactory(() => LoginUseCase(repo: sl()));
  sl.registerFactory(() => RegisterUseCase(repo: sl()));

  //Cubits
  sl.registerFactory(() => LoginCubit(loginUseCase: sl()));
  sl.registerFactory(() => RegisterCubit(registerUseCase: sl()));
}
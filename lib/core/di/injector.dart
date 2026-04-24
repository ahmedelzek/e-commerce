import 'package:e_commerce/data/repos/get_slider_repo_impl.dart';
import 'package:e_commerce/data/repos/product_repo_impl.dart';
import 'package:e_commerce/domain/contract/auth_repo.dart';
import 'package:e_commerce/domain/contract/get_slider_repo.dart';
import 'package:e_commerce/domain/contract/products_repo.dart';
import 'package:e_commerce/domain/use_cases/get_products_use_case.dart';
import 'package:e_commerce/domain/use_cases/get_sliders_use_case.dart';
import 'package:e_commerce/features/master/pages/home/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../data/repos/auth_repo_impl.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../../domain/use_cases/register_use_case.dart';
import '../../features/auth/cubit/login/login_cubit.dart';
import '../../features/auth/cubit/register/register_cubit.dart';
import '../app_router/app_router.dart';
import '../network/api_helper.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  await initRouter();
  await APIHelper.init();
  sl.registerLazySingleton<APIHelper>(() => APIHelper());

  //Repos
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(apiHelper: sl()));
  sl.registerLazySingleton<GetSliderRepo>(
    () => GetSlidersRepoImpl(apiHelper: sl()),
  );
  sl.registerLazySingleton<ProductRepo>(() => ProductRepoImpl(apiHelper: sl()));

  //UseCases
  sl.registerFactory(() => LoginUseCase(repo: sl()));
  sl.registerFactory(() => RegisterUseCase(repo: sl()));
  sl.registerFactory(() => GetSliderUseCase(repo: sl()));
  sl.registerFactory(() => GetProductsUseCase(repo: sl()));

  //Cubits
  sl.registerFactory(() => LoginCubit(loginUseCase: sl()));
  sl.registerFactory(() => RegisterCubit(registerUseCase: sl()));
  sl.registerFactory(
    () => HomeCubit(getSliderUseCase: sl(), getProductsUseCase: sl()),
  );
}
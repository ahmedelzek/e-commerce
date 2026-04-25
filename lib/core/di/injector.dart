import 'package:e_commerce/data/repos/cart_repo_impl.dart';
import 'package:e_commerce/data/repos/category_repo_impl.dart';
import 'package:e_commerce/data/repos/get_slider_repo_impl.dart';
import 'package:e_commerce/data/repos/product_repo_impl.dart';
import 'package:e_commerce/data/repos/user_repo_impl.dart';
import 'package:e_commerce/domain/contract/auth_repo.dart';
import 'package:e_commerce/domain/contract/cart_repo.dart';
import 'package:e_commerce/domain/contract/category_repo.dart';
import 'package:e_commerce/domain/contract/get_slider_repo.dart';
import 'package:e_commerce/domain/contract/product_repo.dart';
import 'package:e_commerce/domain/contract/user_repo.dart';
import 'package:e_commerce/domain/use_cases/get_categories_use_case.dart';
import 'package:e_commerce/domain/use_cases/get_products_use_case.dart';
import 'package:e_commerce/domain/use_cases/get_sliders_use_case.dart';
import 'package:e_commerce/domain/use_cases/get_user_use_case.dart';
import 'package:e_commerce/domain/use_cases/update_profile_use_case.dart';
import 'package:e_commerce/features/master/pages/home/cubit/home_cubit.dart';
import 'package:e_commerce/features/master/pages/profile/cubit/profile_cubit.dart';
import 'package:e_commerce/features/my_profile/cubit/update_profile_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/models/cart/cart_item_hive_model.dart';
import '../../data/repos/auth_repo_impl.dart';
import '../../domain/use_cases/cart_use_cases.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../../domain/use_cases/register_use_case.dart';
import '../../features/auth/cubit/login/login_cubit.dart';
import '../../features/auth/cubit/register/register_cubit.dart';
import '../../features/cart/cubit/cart_cubit.dart';
import '../app_router/app_router.dart';
import '../local_data_source/cart_local_data_source.dart';
import '../network/api_helper.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  await APIHelper.init();
  await initRouter();

  // Hive
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemHiveModelAdapter());

  sl.registerLazySingleton<APIHelper>(() => APIHelper());

  // DataSource
  final cartLocalDataSource = CartLocalDataSource();
  await cartLocalDataSource.init();
  sl.registerLazySingleton(() => cartLocalDataSource);

  // Repos
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(apiHelper: sl()));
  sl.registerLazySingleton<GetSliderRepo>(
        () => GetSlidersRepoImpl(apiHelper: sl()),
  );
  sl.registerLazySingleton<ProductRepo>(() => ProductRepoImpl(apiHelper: sl()));
  sl.registerLazySingleton<CategoryRepo>(
        () => CategoryRepoImpl(apiHelper: sl()),
  );
  sl.registerLazySingleton<UserRepo>(() => UserRepoImpl(apiHelper: sl()));
  sl.registerLazySingleton<CartRepo>(
        () => CartRepoImpl(localDataSource: sl()),
  );

  // UseCases
  sl.registerFactory(() => LoginUseCase(repo: sl()));
  sl.registerFactory(() => RegisterUseCase(repo: sl()));
  sl.registerFactory(() => GetSliderUseCase(repo: sl()));
  sl.registerFactory(() => GetProductsUseCase(repo: sl()));
  sl.registerFactory(() => GetCategoriesUseCase(repo: sl()));
  sl.registerFactory(() => GetUserUseCase(repo: sl()));
  sl.registerFactory(() => UpdateProfileUseCase(repo: sl()));
  sl.registerFactory(() => GetCartItemsUseCase(repo: sl()));
  sl.registerFactory(() => AddToCartUseCase(repo: sl()));
  sl.registerFactory(() => RemoveFromCartUseCase(repo: sl()));
  sl.registerFactory(() => UpdateQuantityUseCase(repo: sl()));
  sl.registerFactory(() => ClearCartUseCase(repo: sl()));

  // Cubits
  sl.registerFactory(() => LoginCubit(loginUseCase: sl()));
  sl.registerFactory(() => RegisterCubit(registerUseCase: sl()));
  sl.registerFactory(
        () => HomeCubit(
      getSliderUseCase: sl(),
      getProductsUseCase: sl(),
      getCategoriesUseCase: sl(),
    ),
  );
  sl.registerFactory(() => ProfileCubit(getUserUseCase: sl()));
  sl.registerFactory(() => UpdateProfileCubit(updateProfileUseCase: sl()));
  sl.registerLazySingleton(() => CartCubit(
    getCartItemsUseCase: sl(),
    addToCartUseCase: sl(),
    removeFromCartUseCase: sl(),
    updateQuantityUseCase: sl(),
    clearCartUseCase: sl(),
  ));
}
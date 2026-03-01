import 'package:auth_api_app/core/networking/dio_consumer.dart';
import 'package:auth_api_app/feature/auth/data/local_data_source/shared_pref.dart';
import 'package:auth_api_app/feature/auth/data/repos/auth_repo.dart';
import 'package:auth_api_app/feature/auth/data/repos/auth_repo_impl.dart';
import 'package:auth_api_app/feature/auth/presentation/manger/login_cubit.dart';
import 'package:auth_api_app/feature/home/data/repos/product_repo_impl.dart';
import 'package:auth_api_app/feature/home/data/repos/products_repo.dart';
import 'package:auth_api_app/feature/home/presentation/manger/product_cubit.dart';
import 'package:get_it/get_it.dart';

final getit = GetIt.instance;
void init() {
  getit.registerLazySingleton<ApiService>(() => ApiService());

  getit.registerLazySingleton<LocalDateSource>(() => LocalDateSource());
  getit.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      localDateSource: getit<LocalDateSource>(),
      apiService: getit<ApiService>(),
    ),
  );

  getit.registerFactory<ProductsRepo>(
    () => ProductsRepoImpl(getit<ApiService>(), getit<LocalDateSource>()),
  );

  getit.registerFactory<ProductCubit>(
    () => ProductCubit(getit<ProductsRepo>()),
  );

  getit.registerFactory<LoginCubit>(() => LoginCubit(getit<AuthRepo>()));
}

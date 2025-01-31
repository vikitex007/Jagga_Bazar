import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jagga_bazar/app/shared_prefs/token_shared_prefs.dart';
import 'package:jagga_bazar/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:jagga_bazar/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/network/api_service.dart';
import '../../core/network/hive_service.dart';
import '../../features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import '../../features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import '../../features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import '../../features/auth/domain/use_case/login_usecase.dart';
import '../../features/auth/domain/use_case/register_usecase.dart';
import '../../features/auth/presentation/view_model/login/login_bloc.dart';
import '../../features/auth/presentation/view_model/register/register_bloc.dart';
import '../../features/home/presentation/view_model/home_cubit.dart';
import '../../features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();


  // await _initBatchDependencies();
  // await _initCourseDependencies();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();

  await _initSplashScreenDependencies();
}

Future <void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}


_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initApiService() {
  // Remote Data Source
  getIt.registerLazySingleton<Dio>(
        () => ApiService(Dio()).dio,
  );
}


 _initRegisterDependencies() {
  //============================Data Source===================================
  // init local data source
  getIt.registerLazySingleton(
        () => AuthLocalDataSource(getIt<HiveService>()),
  );

  //remote DataSource
  getIt.registerLazySingleton(() => AuthRemoteDataSource(getIt<Dio>()));

  //===========================Repository =======================================


  // init local repository
  getIt.registerLazySingleton(
        () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );
//remote Repository
  getIt.registerLazySingleton(
        () =>
        AuthRemoteRepository(
          getIt<AuthRemoteDataSource>(),
        ),
  );


  //===========================Use case Repository =======================================

  // register use usecase
  getIt.registerLazySingleton<RegisterUseCase>(
        () =>
        RegisterUseCase(
          getIt<AuthRemoteRepository>(),
        ),
  );

  //upload image Usecase
  getIt.registerLazySingleton<UploadImageUsecase>(
          () =>
          UploadImageUsecase(
            getIt<AuthRemoteRepository>(),
          )
  );

  getIt.registerFactory<RegisterBloc>(
        () =>
        RegisterBloc(
          registerUseCase: getIt(),
          uploadImageUsecase: getIt(),
        ),
  );
}


_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
        () => HomeCubit(),
  );
}

_initLoginDependencies() async {
  //==========================Token Shared preferences===========================
  getIt.registerLazySingleton<TokenSharedPrefs>(
        () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  //=============================Usecase========================================
  getIt.registerLazySingleton<LoginUseCase>(
  () => LoginUseCase(
  getIt<AuthRemoteRepository>(),
  getIt<TokenSharedPrefs>(),
  ),
  );

  getIt.registerFactory<LoginBloc>(
  () => LoginBloc(
  registerBloc: getIt<RegisterBloc>(),
  homeCubit: getIt<HomeCubit>(),
  loginUseCase: getIt<LoginUseCase>(),
  )
  ,
  );

}


_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
        () => SplashCubit(getIt<LoginBloc>()),
  );
}
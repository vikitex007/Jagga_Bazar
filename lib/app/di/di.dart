import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jagga_bazar/app/shared_prefs/token_shared_prefs.dart';
import 'package:jagga_bazar/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:jagga_bazar/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:jagga_bazar/features/favourite/presentation/view_model/favourite_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/network/api_service.dart';
import '../../core/network/hive_service.dart';
import '../../features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import '../../features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import '../../features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import '../../features/auth/domain/repository/auth_repository.dart';
import '../../features/auth/domain/use_case/get_profile_usecase.dart';
import '../../features/auth/domain/use_case/login_usecase.dart';
import '../../features/auth/domain/use_case/register_usecase.dart';
import '../../features/auth/presentation/view_model/login/login_bloc.dart';
import '../../features/auth/presentation/view_model/profile/profile_bloc.dart';
import '../../features/auth/presentation/view_model/register/register_bloc.dart';
import '../../features/favourite/data/repository/fav_repo.dart';
import '../../features/favourite/domain/repository/favourite_repository.dart';
import '../../features/favourite/domain/use_case/add_to_favourite.dart';
import '../../features/favourite/domain/use_case/get_favourite.dart';
import '../../features/favourite/domain/use_case/remove_from_favourite.dart';
import '../../features/home/presentation/view_model/home_cubit.dart';
import '../../features/post/data/data_source/localdatasource/post_local_datasource.dart';
import '../../features/post/data/data_source/remotedatasource/post_remote_datasource.dart';
import '../../features/post/data/repository/post_local_repository.dart';
import '../../features/post/data/repository/post_remote_repository.dart';
import '../../features/post/domain/use_case/create_post_usecase.dart';
import '../../features/post/domain/use_case/delete_post_usecase.dart';
import '../../features/post/domain/use_case/get_all_post_usecase.dart';
import '../../features/post/domain/use_case/upload_image_usecase.dart';
import '../../features/post/presentation/view_model/post_bloc.dart';
import '../../features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();



   _initFavouriteDependencies();

  await _initPostDependencies();
  await _initDashboardDependencies();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initProfileDependencies();



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


//=============================Dashboard=========================
_initDashboardDependencies() {

}




//===========================favourite=================================
void _initFavouriteDependencies() {
  getIt.registerLazySingleton<FavouriteRepository>(
        () => FavouriteRepositoryImpl(getIt<HiveService>()),
  );

  getIt.registerLazySingleton<GetFavouritePosts>(
        () => GetFavouritePosts(getIt<FavouriteRepository>()),
  );

  getIt.registerLazySingleton<AddToFavourite>(
        () => AddToFavourite(getIt<FavouriteRepository>()),
  );

  getIt.registerLazySingleton<RemoveFromFavourite>(
        () => RemoveFromFavourite(getIt<FavouriteRepository>()),
  );

  getIt.registerFactory<FavouriteBloc>(
        () => FavouriteBloc(
      getFavourites: getIt<GetFavouritePosts>(),
      addToFavourite: getIt<AddToFavourite>(),
      removeFromFavourite: getIt<RemoveFromFavourite>(),
    ),
  );
}


//============================POST==========================
_initPostDependencies(){
  // =========================== Data Sources ===========================

// Local Data Source for Post
  getIt.registerFactory<PostLocalDataSource>(
          () => PostLocalDataSource(hiveService: getIt<HiveService>())
  );

// Remote Data Source for Post
  getIt.registerLazySingleton<PostRemoteDataSource>(
        () => PostRemoteDataSource(dio: getIt<Dio>()),
  );

// =========================== Repository ===========================

// Local Repository for Post
  getIt.registerLazySingleton<PostLocalRepository>(
          () => PostLocalRepository(postLocalDataSource: getIt<PostLocalDataSource>())
  );

// Remote Repository for Post
  getIt.registerLazySingleton<PostRemoteRepository>(
          () => PostRemoteRepository(remoteDataSource: getIt<PostRemoteDataSource>())
  );

// =========================== Usecases ===========================

// Usecase for creating a Post
  getIt.registerLazySingleton<CreatePostUseCase>(
          () => CreatePostUseCase(postRepository: getIt<PostRemoteRepository>())
  );

// Usecase for getting all Posts
  getIt.registerLazySingleton<GetAllPostUseCase>(
          () => GetAllPostUseCase(postRepository: getIt<PostRemoteRepository>())
  );

// Usecase for deleting a Post
  getIt.registerLazySingleton<DeletePostUseCase>(
        () => DeletePostUseCase(
      postRepository: getIt<PostRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );
  getIt.registerLazySingleton<UploadImageUseCase>(
          () =>
          UploadImageUseCase(
            getIt<PostRemoteRepository>(),
          )
  );

// =========================== Bloc ===========================

// Bloc for managing Post-related states
  getIt.registerFactory<PostBloc>(
        () => PostBloc(
      createPostUseCase: getIt<CreatePostUseCase>(),
      getAllPostUseCase: getIt<GetAllPostUseCase>(),
      deletePostUseCase: getIt<DeletePostUseCase>(),
          uploadImageUseCase:getIt<UploadImageUseCase>(),
    ),
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
  getIt.registerFactory<HomeCubit>(() => HomeCubit());
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



//==================== profile ===============================

 _initProfileDependencies() {
   getIt.registerLazySingleton<UpdateProfileUseCase>(
         () => UpdateProfileUseCase(getIt<IAuthRepository>()),
   );

   getIt.registerFactory<ProfileBloc>(
         () => ProfileBloc(
       updateProfileUseCase: getIt<UpdateProfileUseCase>(),
     ),
   );


 }


_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
        () => SplashCubit(getIt<LoginBloc>()),
  );
}
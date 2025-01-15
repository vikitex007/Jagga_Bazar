//
// import 'package:get_it/get_it.dart';
//
// final getIt  = GetIt.instance;
//
// Future<void> initDependencies() async {
//   // First initialize hive service
//   await _initHiveService();
//
//   // await _initBatchDependencies();
//   // await _initCourseDependencies();
//   await _initHomeDependencies();
//   await _initRegisterDependencies();
//   await _initLoginDependencies();
//
//   // await _initSplashScreenDependencies();
// }
//
// _initHiveService() {
//   getIt.registerLazySingleton<HiveService>(() => HiveService());
// }
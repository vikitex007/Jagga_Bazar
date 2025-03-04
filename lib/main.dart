// import 'package:flutter/cupertino.dart';
//
// import 'app/app.dart';
// import 'app/di/di.dart';
// import 'core/network/hive_service.dart';
//
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await HiveService.init();
//   await initDependencies();
//   runApp(
//     App(),
//   );
//
//
// }
import 'package:flutter/material.dart';
import 'app/app.dart';
import 'app/di/di.dart';
import 'core/network/hive_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/favourite/presentation/view_model/favourite_event.dart';
import 'features/home/presentation/view_model/home_cubit.dart';
import 'features/favourite/presentation/view_model/favourite_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<HomeCubit>()), // HomeCubit global
        BlocProvider(create: (_) => getIt<FavouriteBloc>()..add(LoadFavourites())), // Global FavouriteBloc
      ],
      child: const App(),
    ),
  );
}


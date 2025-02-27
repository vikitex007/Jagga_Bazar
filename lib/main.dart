import 'package:flutter/cupertino.dart';

import 'app/app.dart';
import 'app/di/di.dart';
import 'core/network/hive_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  await initDependencies();
  runApp(
    App(),
  );


}


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'app/app.dart';
// import 'app/di/di.dart';
// import 'core/network/hive_service.dart';
// import 'features/home/presentation/view_model/home_cubit.dart';
// import 'features/favourite/presentation/view_model/favourite_bloc.dart';
// import 'features/post/presentation/view_model/post_bloc.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await HiveService.init();  // ✅ Ensure Hive database is initialized
//   await initDependencies();  // ✅ Ensure dependencies are initialized
//
//   runApp(
//     MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (context) => getIt<HomeCubit>()),
//         BlocProvider(create: (context) => getIt<FavouriteBloc>()),
//         BlocProvider(create: (context) => getIt<PostBloc>()),
//       ],
//       child: const App(), // ✅ Ensure App is properly wrapped
//     ),
//   );
// }

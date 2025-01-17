import 'package:flutter/cupertino.dart';

import 'app/app.dart';
import 'app/di/di.dart';
import 'core/network/hive_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  // WidgetsFlutterBinding.ensureInitailized();
  await initDependencies();
  runApp(
    App(),
  );


}
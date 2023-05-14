import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather/core/injection/injection.dart';
import 'package:weather/core/navigator/iflutter_navigator.dart';
import 'package:weather/features/app/presentation/home/view/home_screen.dart';

Future<void> main() async {
  configureDependencies();
  await initGetStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: getIt<IFlutterNavigator>().navigatorKey,
      title: 'Flutter Demo',
      home: const HomeScreen(),
    );
  }
}

Future<void> initGetStorage() async {
  await GetStorage.init();
}

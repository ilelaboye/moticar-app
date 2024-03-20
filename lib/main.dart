import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moticar/widgets/colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'services/hivekeys.dart';
import 'splash/splashscreen/splash_screen.dart';

Future<void> main() async {

  await Hive.initFlutter();
  await Hive.openBox(HiveKeys.appBox);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) async {
      runApp(
        const ProviderScope(child: MyApp()),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.yellow),
          useMaterial3: true,
          fontFamily: "Neulis",
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontFamily: 'Neulis'),
          )),
      home: const SplashScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moticar/Home/bottom_bar.dart';
import 'package:moticar/auth/add_car.dart';
import 'package:moticar/widgets/colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moticar/widgets/loader.dart';
import 'package:rive/rive.dart';
import 'auth/signup/sign_2.dart';
import 'auth/signup/sign_3.dart';
import 'services/hivekeys.dart';
import 'splash/splashscreen/splash_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 65.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = AppColors.appThemeColor
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.red.withOpacity(0)
    ..userInteractions = false
    ..dismissOnTap = false
    ..indicatorWidget = Container(
      height: 130,
      width: 130,
      padding: EdgeInsets.all(20),
      // color: Colors.green,
      child: RiveAnimation.asset(
        'assets/images/preloader.riv',
      ),
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
      builder: EasyLoading.init(),
      theme: ThemeData(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            // largeSizeConstraints: BoxConstraints.tight(10),
            backgroundColor: AppColors.yellow),
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.yellow),
        useMaterial3: true,
        fontFamily: "NeulisAlt",
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'NeulisAlt'),
        ),
      ),
      home:

          // BottomHomePage()
          // SignUpPage3(token: '',)

          const SplashScreen(),
    );
  }
}

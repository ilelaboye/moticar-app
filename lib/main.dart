import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moticar/widgets/colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rive/rive.dart';
import 'services/hivekeys.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'splash/splashscreen/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//  Un-used
// import 'Home/profile/company_info.dart';
// import 'Home/profile/mileage_set_reminder.dart';
// import 'Home/profile/new_mileage.dart';
// import 'Home/profile/notification_sett.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyADgGHREIxlS6hKn61UDEvbm3y-fce4iR4',
    appId: '899782617587',
    messagingSenderId: 'use-moticar',
    projectId: 'use-moticar',
    storageBucket: 'use-moticar.appspot.com',
  ));
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
    ..textColor = Colors.white
    ..maskColor = Colors.red.withOpacity(0)
    ..userInteractions = false
    ..dismissOnTap = false
    ..textAlign = TextAlign.start
    ..textPadding = EdgeInsets.zero
    ..indicatorWidget = Container(
      height: 100,
      width: 130,
      padding: const EdgeInsets.all(0),
      // color: Colors.green,
      child: const RiveAnimation.asset(
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
      title: 'Moticar',
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
          // const NotifyMotPage()

          const SplashScreen(),
    );
  }
}


//  return FutureBuilder<bool>(
//           future: checkUserLoggedIn(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               // Show a loading indicator while checking the user's login status.
//               return const CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               // Handle any errors that occurred during the check.
//               return const Center(
//                 child: Text('Error occurred'),
//               );
//             } else {
//               final bool userLoggedIn = snapshot.data ?? false;
//               // Determine the initial route based on the user's login status.
//               final List<PageRouteInfo> initialRoute = userLoggedIn
//                   ? [const PageRouteInfo('WelcomeRoute')]
//                   : [const PageRouteInfo('OnBoardingScreen')];

//               return ChangeNotifierProvider(
//                 create: (context) => Themprovider(),
//                 builder: (context, child) {
//                   final themeProvider =
//                       Provider.of<Themprovider>(context).themeData;
//                   return MaterialApp.router(
//                     debugShowCheckedModeBanner: false,
//                     title: 'Party Time',
//                     theme: themeProvider,
//                     // darkTheme: darkTheme,
//                     // themeMode: themeProvider,
//                     routerDelegate: _appRouter.delegate(
//                         initialRoutes: initialRoute,
//                         ),
//                     routeInformationParser: _appRouter.defaultRouteParser(),
//                   );
//                 },
//               );
//             }
//           },
//         );
// import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:moticar/models/onboarding.dart';
import 'package:moticar/providers/authentication.dart';
import 'package:moticar/widgets/flushbar.dart';
import 'package:rive/rive.dart';

// import '../../router/app_router.gr.dart';
import '../../../widgets/app_texts.dart';
import '../../../widgets/colors.dart';
import 'onboarding.dart';
import 'onboarding_screen2.dart';

// @RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    getOnboardingScreen(context);
  }

  Future<void> getOnboardingScreen(BuildContext context) async {
    Authentication provider = Authentication();
    var res = await provider.getOnboardingScreen(context);
    IOnboarding data = IOnboarding.fromMap(res['data']);
    if (!res['status']) {
      Alert.showNotificationError(
        message: 'Invalid email address',
        context: context,
        notificationType: 1,
      );
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      if (data.images.length > 0) {
        return OnBoardingScreenPage(screens: res['data']);
      } else {
        return OnBoardingScreenPageFailed();
      }
    }));

    //  if (context.mounted) {
    //   if (res["status"] == true && res["data"]) {
    //     Navigator.push(context, MaterialPageRoute(builder: (context) {
    //       return OnBoardingScreenPage(screens: res['data']['data']);
    //     }));
    //   }
    // }
  }

  @override
  void dispose() {
    _controller.reverse().whenComplete(() {
      _controller.dispose();
      super.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yellow,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        color: AppColors.yellow,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
              width: 250,
              child: RiveAnimation.asset(
                'assets/images/splashscreenanim.riv',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.0, left: 50, right: 50),
              child: MoticarText(
                  text:
                      'Every kobo of your car \nexpenses \nis just a tap away!',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontColor: AppColors.appThemeColor),
            ),
          ],
        ),
      ),
    );
  }
}

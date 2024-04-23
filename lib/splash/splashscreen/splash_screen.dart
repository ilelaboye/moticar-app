// import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

// import '../../router/app_router.gr.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import 'new_onboardIntro.dart';
import 'onboard_screen.dart';

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
    _nextPage();
  }

  Future _nextPage() async {
    await Future.delayed(const Duration(seconds: 3), () {
      // context.router.push(const LoginRouteCopy());
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const OnBoardingScreenPage();
      }));

      //
    });
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

            // const SizedBox(),
            // AnimatedBuilder(
            //     animation: _animation,
            //     builder: (context, child) {
            //       return Transform.scale(
            //           scale: _animation.value,
            //           child:   const Column(
            //             children: [
            //               // Image.asset(
            //               //   'assets/images/moticar.png',
            //               //   height: 150,
            //               //   width: 150,
            //               // ),

            //                SizedBox(
            //                 height: 150,
            //                 width: 150,
            //                 child: RiveAnimation.asset(
            //                   'assets/images/splashscreenanim.riv',
            //                 ),
            //               ),

            //                  Padding(
            //                 padding:
            //                     EdgeInsets.only(top: 50.0, left: 50, right: 50),
            //                 child: MoticarText(
            //                     text:
            //                         'Every kobo of your car \nexpenses \nis just a tap away!',
            //                     fontSize: 13,
            //                     fontWeight: FontWeight.w500,
            //                     fontColor: AppColors.appThemeColor),
            //               ),

            //             ],
            //           ));
            //     }),
          ],
        ),
      ),
    );
  }
}

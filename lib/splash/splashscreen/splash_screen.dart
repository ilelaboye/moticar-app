// import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

// import '../../router/app_router.gr.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
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
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _nextPage();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInQuad),
    );
    _controller.forward();
  }

  Future _nextPage() async {
    await Future.delayed(const Duration(seconds: 2), () {
      // context.router.push(const LoginRouteCopy());
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const OnBoardingScreenPage();
      }));
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
        color: AppColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(),

            AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.scale(
                      scale: _animation.value,
                      child: Image.asset(
                        'assets/images/moticar.png',
                        height: 100,
                        width: 100,
                      ));
                }),

                SizedBox(height: 10,),

                const Padding(
                  padding: EdgeInsets.all(50.0),
                  child: MoticarText(text: 'Every kobo of your car expenses is just a tap away!', fontSize: 15, fontWeight: FontWeight.w600,
                   fontColor: AppColors.appThemeColor),
                ),

                  
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import '../../widgets/page_indicator.dart';
import 'intro_page_2.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({super.key});

  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> with TickerProviderStateMixin {
  //lottie controller
  late final AnimationController lottiecontroller;

  @override
  void initState() {
    super.initState();
    lottiecontroller = AnimationController(
      vsync: this,
    );
  }

  // bool bank = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.appThemeColor,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  alignment: Alignment.bottomCenter,
                  child: Image.asset('assets/images/barcode.png',
                      height: MediaQuery.of(context).size.height * 0.39),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Welcome to Estoteric \n Scan-Out",
                          textAlign: TextAlign.center,
                          // maxLines: 2,
                          style: TextStyle(fontFamily: "Onest",
                              fontSize: 22,
                              height: 1.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white)),
                      const Text(
                          "Discover a smarter way to shop! Scan items, \n make secure payments, and enjoy a hassle-free \n checkout experience",
                          textAlign: TextAlign.center,
                          // maxLines: 3,
                          softWrap: true,
                          style: TextStyle(fontFamily: "Onest",
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white)),
                      const PageIndicator(
                          indicatorColor: AppColors.successYellow,
                          currentPage: 1,
                          totalPages: 3),
                      MoticarLoginButton(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const IntroPage2();
                          }));
                          // context.router.push(const LoginRouteCopy());
                        },
                        child: const MoticarText(
                          fontColor: AppColors.textGrey,
                          text: 'Next',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

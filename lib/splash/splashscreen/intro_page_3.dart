import 'package:flutter/material.dart';

import '../../auth/login-android.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import '../../widgets/page_indicator.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({super.key});

  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> with TickerProviderStateMixin {
  //lottie controller
  late final AnimationController lottiecontroller;

  @override
  void initState() {
    super.initState();
    lottiecontroller = AnimationController(
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const SizedBox(
                //   height: 30,
                // ),

                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    'assets/images/invoice.png',
                    // height: 400,
                    width: 350,
                  ),
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Effortless Record-Keeping! \n Auto Receipts!",
                          textAlign: TextAlign.center,
                          // maxLines: 2,
                          style: TextStyle(fontFamily: "Onest",
                              fontSize: 22,
                              height: 1.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.green)),
                      const Text(
                          "Say goodbye to paper clutter. Auto Receipts \n gives you immediate access to purchased details after each transaction - try it now!",
                          textAlign: TextAlign.center,
                          // maxLines: 3,
                          softWrap: true,
                          style: TextStyle(fontFamily: "Onest",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black)),
                      const PageIndicator(
                          indicatorColor: AppColors.appThemeColor,
                          currentPage: 3,
                          totalPages: 3),
                      MoticarButton(
                        height: 60,
                        width: MediaQuery.of(context).size.width - 30,
                        onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context){
                              return const LoginPage();
                            }));
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MoticarText(
                              fontColor: AppColors.white,
                              text: 'Start Shopping',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: AppColors.white,
                              size: 19,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}

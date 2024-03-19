
import 'package:flutter/material.dart';


import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import '../../widgets/page_indicator.dart';
import 'intro_page_3.dart';

class IntroPage2 extends StatefulWidget {
  const IntroPage2({super.key});

  @override
  State<IntroPage2> createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2> with TickerProviderStateMixin {
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
          color: AppColors.successYellow,
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
                    'assets/images/qr-code.png',
                    // height: 400,
                    width: 350,
                  ),
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Effortless Shopping with \n Estoteric Scan-Out",
                          textAlign: TextAlign.center,
                          // maxLines: 2,
                          style: TextStyle(fontFamily: "Onest",
                              fontSize: 22,
                              height: 1.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.green)),
                      const Text(
                          "Skip checkout lines – effortlessly scan and add \n items to your virtual cart as you shop. Try it now \n to revolutionize your shopping!",
                          textAlign: TextAlign.center,
                          // maxLines: 3,
                          softWrap: true,
                          style: TextStyle(fontFamily: "Onest",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black)),
                      const PageIndicator(
                          indicatorColor: AppColors.appThemeColor,
                          currentPage: 2,
                          totalPages: 3),
                      MoticarButton(
                        height: 60,
                        width: MediaQuery.of(context).size.width - 30,
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const IntroPage3();
                          }));
                        },
                        child: const MoticarText(
                          fontColor: AppColors.white,
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

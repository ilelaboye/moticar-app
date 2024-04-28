import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moticar/Home/bottom_bar.dart';

import '../widgets/app_texts.dart';
import '../widgets/colors.dart';

class FirstKnow extends StatefulWidget {
  const FirstKnow({
    super.key,
  });

  @override
  State<FirstKnow> createState() => _FirstKnowState();
}

class _FirstKnowState extends State<FirstKnow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.diaColor,
      body: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Color(0xff101828)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),

              //
              //image
              Padding(
                padding: const EdgeInsets.only(
                    top: 15.0, left: 30, right: 30, bottom: 15),
                child: Container(
                    // height: 200,
                    // width: double.infinity,
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Image.asset("assets/images/first2know.png")),
              ),

              const Padding(
                padding: EdgeInsets.only(left: 45.0, right: 45, top: 15),
                child: Text(
                  "Be the first to know",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "NeulisAlt",
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: AppColors.appThemeColor,
                  ),
                ),
              ),

              // const SizedBox(height: 8),

              // Add your terms and conditions content here
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Enable push notifiation and never miss out on:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "NeulisAlt",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.appThemeColor,
                  ),
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/insights.svg',
                            height: 30,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            "Personalised insights",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.appThemeColor),
                          ),
                        ],
                      ),
                    ),
                    //
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/timely.svg',
                            height: 30,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: const Text(
                              "Timely information on price & volatility change",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: "NeulisAlt",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.appThemeColor),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //prices
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/alerts.svg',
                            height: 30,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: const Text(
                              "Custom price alerts to detect product prices",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: "NeulisAlt",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.appThemeColor),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //updates
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/updates.svg',
                            height: 30,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: const Text(
                              "Product announcements, market updates etc",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: "NeulisAlt",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.appThemeColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MoticarLoginButton(
                  myColor: AppColors.appThemeColor,
                  borderColor: AppColors.diaColor,
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: const Color(
                              0xff242424), // Set background color to black
                          title: const Text(
                            '“moticar” would like to send you notifications',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          content: const Text(
                            'Notifications may include alerts, sounds and icon badges. These can be configured in Settings.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Arial',
                              color: Color(0xff929292),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Do not allow',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff1154CC),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Navigator.pop(context);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const BottomHomePage();
                                }));
                              },
                              child: const Text(
                                'Allow',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff1154CC),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const MoticarText(
                    fontColor: AppColors.white,
                    text: 'Allow Notifications',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MoticarLoginButton(
                  myColor: Colors.transparent,
                  borderColor: const Color(0xff006C70),
                  onTap: () async {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return AddCarPage4(
                    //     imagePath: 'assets/images/car_ai.png',
                    //     carName: widget.carName,
                    //     petrol: widget.petrol,
                    //     gearbox: widget.gearbox,
                    //     model: widget.model,
                    //   );
                    // }));
                  },
                  child: const MoticarText(
                    fontColor: Color(0xff006C70),
                    text: 'Remind me later',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

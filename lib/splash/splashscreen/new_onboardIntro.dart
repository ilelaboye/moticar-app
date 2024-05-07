import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../auth/login/login_email.dart';
import '../../auth/signup/signup.dart';
import '../../services/auth_services.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';

class OnBoardingScreenPage extends StatefulWidget {
  const OnBoardingScreenPage({
    super.key,
    required this.screens,
  });
  final Map<String, dynamic> screens;
  @override
  State<OnBoardingScreenPage> createState() => _OnBoardingScreenPageState();
}

class _OnBoardingScreenPageState extends State<OnBoardingScreenPage>
    with SingleTickerProviderStateMixin {
  //controller to keep track of the no of pages....
  final PageController _controller = PageController();
  bool onLastPage = false;
  //lottie controller

// Handle login result

  @override
  void initState() {
    super.initState();
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
            padding:
                const EdgeInsets.only(top: 35, left: 10, right: 10, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MoticarText(
                    text: widget.screens['text']['title'],
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    fontColor: Colors.white),
                Padding(
                  padding: EdgeInsets.only(
                      left: 50.0, right: 50, top: 15, bottom: 20),
                  child: Text(widget.screens['text']['description'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          height: 1.2,
                          fontWeight: FontWeight.w400,
                          color: AppColors.white)),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.48,
                  child: PageView(
                    onPageChanged: (value) {
                      setState(() {
                        onLastPage = (value == widget.screens['images'].length);
                      });
                    },
                    controller: _controller,
                    children: widget.screens['images']
                        .map<Widget>((e) => Image.network(e['image']))
                        .toList(),
                    // children: [
                    //   Image.asset("assets/images/step1.png"),
                    //   Image.asset("assets/images/step2.png"),
                    //   Image.asset("assets/images/step3.png"),
                    //   Image.asset("assets/images/step4.png"),
                    // ],
                  ),
                ),

                // PageView(child: )),

                const SizedBox(
                  height: 10,
                ),

                // const PageIndicator(
                //     indicatorColor: AppColors.successYellow,
                //     currentPage: 1,
                //     totalPages: 3),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MoticarLoginButton(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const SignUpPage();
                        }));
                      },
                      child: const MoticarText(
                        fontColor: AppColors.appThemeColor,
                        text: 'Sign up & get started',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    //other social media buttons

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //facebook, google and twitter

                        OtherLoginButton(
                          onTap: () {
                            // AuthService.signInwithFacebook(context);
                          },
                          child: SvgPicture.asset(
                            "assets/svgs/faceB.svg",
                            height: 32,
                          ),
                        ),

                        OtherLoginButton(
                            onTap: () {
                              AuthService.signInwithGoogle(context);
                            },
                            child: SvgPicture.asset("assets/svgs/Google.svg")),

                        OtherLoginButton(
                          onTap: () {
                            // AuthService.signInWithTwitter(context);
                          },
                          child: SvgPicture.asset("assets/svgs/x.svg"),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    //login button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const MoticarText(
                          fontColor: Colors.white,
                          text: "Already have an account?",
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),

                        //
                        TextButton(
                          child: const MoticarText(
                            fontColor: AppColors.lightGreen,
                            text: 'Sign in',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const LoginPage();
                            }));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OtherLoginButton extends StatelessWidget {
  const OtherLoginButton(
      {super.key, required this.child, this.myColor, required this.onTap});
  final Widget child;
  final void Function() onTap;
  final Color? myColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: myColor ?? Colors.white,
              shape: BoxShape.circle,
              border: Border.all(width: 1.2, color: AppColors.newGrey)),
          child: child),
    );
  }
}

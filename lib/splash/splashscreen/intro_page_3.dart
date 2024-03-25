// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:moticar/splash/splashscreen/intro_page_4.dart';

// import '../../auth/login/login_email.dart';
// import '../../auth/signup/signup.dart';
// import '../../widgets/app_texts.dart';
// import '../../widgets/colors.dart';
// import 'intro_page_1.dart';

// class IntroPage3 extends StatefulWidget {
//   const IntroPage3({super.key});

//   @override
//   State<IntroPage3> createState() => _IntroPage3State();
// }

// class _IntroPage3State extends State<IntroPage3> with TickerProviderStateMixin {
//   //lottie controller
//   late final AnimationController lottiecontroller;

//   @override
//   void initState() {
//     super.initState();
//     lottiecontroller = AnimationController(
//       vsync: this,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           color: AppColors.appThemeColor,
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           child: Padding(
//             padding:
//                 const EdgeInsets.only(top: 35, left: 10, right: 10, bottom: 20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 const MoticarText(
//                     text: "How moticar works",
//                     fontSize: 30,
//                     fontWeight: FontWeight.w500,
//                     fontColor: Colors.white),
//                 const Padding(
//                   padding: EdgeInsets.only(
//                       left: 50.0, right: 50, top: 15, bottom: 20),
//                   child: Text(
//                       "Get all the insights to your car in 4 easy steps!",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           fontFamily: "NeulisAlt",
//                           fontSize: 18,
//                           fontStyle: FontStyle.normal,
//                           height: 1.2,
//                           fontWeight: FontWeight.w400,
//                           color: AppColors.white)),
//                 ),

//                 SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.48,
//                     child: Image.asset("assets/images/step3.png")),

//                 const SizedBox(
//                   height: 20,
//                 ),

//                 // const PageIndicator(
//                 //     indicatorColor: AppColors.successYellow,
//                 //     currentPage: 1,
//                 //     totalPages: 3),
//                 Column(
//                   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     MoticarLoginButton(
//                       onTap: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return const SignUpPage();
//                         }));
//                         // context.router.push(const LoginRouteCopy());
//                       },
//                       child: const MoticarText(
//                         fontColor: AppColors.appThemeColor,
//                         text: 'Sign up & get started',
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),

//                     const SizedBox(
//                       height: 8,
//                     ),

//                     //other social media buttons

//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         //facebook, google and twitter

//                         OtherLoginButton(
//                           onTap: () {},
//                           child: SvgPicture.asset(
//                             "assets/svgs/faceB.svg",
//                             height: 32,
//                           ),
//                         ),

//                         OtherLoginButton(
//                             onTap: () {},
//                             child: SvgPicture.asset("assets/svgs/Google.svg")),

//                         OtherLoginButton(
//                           onTap: () {},
//                           child: SvgPicture.asset("assets/svgs/x.svg"),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(
//                       height: 12,
//                     ),

//                     //login button
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const MoticarText(
//                           fontColor: Colors.white,
//                           text: "Already have an account?",
//                           fontSize: 16,
//                           fontStyle: FontStyle.normal,
//                           fontWeight: FontWeight.w400,
//                         ),

//                         //
//                         TextButton(
//                           child: const MoticarText(
//                             fontColor: AppColors.lightGreen,
//                             text: 'Sign in',
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                           onPressed: () {
//                              Navigator.push(context,
//                                 MaterialPageRoute(builder: (context) {
//                               return const LoginPage();
//                             }));
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

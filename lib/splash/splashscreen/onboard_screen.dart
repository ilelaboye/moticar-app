// import 'package:flutter/material.dart';
// import 'intro_page_1.dart';
// import 'intro_page_2.dart';
// import 'intro_page_3.dart';
// import 'intro_page_4.dart';

// // @RoutePage()
// class OnBoardingScreenPage extends StatefulWidget {
//   const OnBoardingScreenPage({super.key});

//   @override
//   State<OnBoardingScreenPage> createState() => _OnBoardingScreenPageState();
// }

// class _OnBoardingScreenPageState extends State<OnBoardingScreenPage>
//     with SingleTickerProviderStateMixin {
//   //controller to keep track of the no of pages....
//   final PageController _controller = PageController();
//   bool onLastPage = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           SizedBox(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             child: PageView(
//               onPageChanged: (value) {
//                 setState(() {
//                   onLastPage = (value == 2);
//                 });
//               },
//               controller: _controller,
//               children: const [IntroPage1(), IntroPage2(), IntroPage3(), IntroPage4()],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

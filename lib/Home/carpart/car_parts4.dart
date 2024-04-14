// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:moticar/widgets/page_indicator.dart';
// import 'package:rive/rive.dart';

// // import '../../providers/app_providers.dart';
// import '../../widgets/app_texts.dart';
// import '../../widgets/colors.dart';

// class AddCarPart4 extends StatefulHookConsumerWidget {
//   const AddCarPart4( 
//       {super.key,
//       required this.carParts,
//       required this.partImage,
//       required this.partCategory,
//     required  this.productName,
//     required this.brand,
//     required this.quantity,
//     required this.condition, 
//     required this.description,
//     required this.amount,
//     required this.measurements,
//       });

//   final String carParts,quantity, partImage, partCategory, productName, brand, condition, description, amount, measurements;

//   @override
//   ConsumerState<AddCarPart4> createState() => _AddCarPart4State();
// }

// class _AddCarPart4State extends ConsumerState<AddCarPart4> {


//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final state = ref.watch(profileProvider);
//     // final model = ref.read(profileProvider.notifier);
//     return Scaffold(
//       backgroundColor: const Color(0xffEEF5F5),
//       appBar: AppBar(
//         title: const Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Add Car part",
//               style: TextStyle(
//                 fontFamily: "NeulisAlt",
//                 fontSize: 16,
//                 fontStyle: FontStyle.normal,
//                 color: AppColors.white,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             Text(
//               "Select the part of the car you want to add",
//               style: TextStyle(
//                 fontFamily: "NeulisAlt",
//                 fontSize: 12,
//                 fontStyle: FontStyle.normal,
//                 color: AppColors.indieC,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//         elevation: 1,
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios_new_rounded,
//             size: 20,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: AppColors.appThemeColor,
//         shadowColor: Colors.white,
//         surfaceTintColor: Colors.white,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             flex: 5,
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     // ignore: prefer_const_constructors
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Row(
//                           children: [
//                             PageIndicator(
//                                 currentPage: 3,
//                                 indicatorColor: AppColors.indieC,
//                                 inactiveIndicatorColor: Color(0xffD7E2E4),
//                                 totalPages: 4),
//                           ],
//                         ),
//                         const Center(
//                           child: Text(
//                             "This is what we got from you",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 fontFamily: "NeulisAlt",
//                                 fontSize: 20,
//                                 fontStyle: FontStyle.normal,
//                                 fontWeight: FontWeight.w700,
//                                 color: AppColors.appThemeColor),
//                           ),
//                         ),

//                         // ${}
//                         const SizedBox(height: 20),

//                         Center(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Row(
//                                 children: [
//                                   //image
//                                   // SvgPicture.asset(widget.imagePath),
//                                   const SizedBox(width: 8),
//                                   Text(
//                                     widget.carParts,
//                                     // textAlign: TextAlign.center,
//                                     style: const TextStyle(
//                                         fontFamily: "NeulisAlt",
//                                         fontSize: 14,
//                                         fontStyle: FontStyle.normal,
//                                         fontWeight: FontWeight.w400,
//                                         color: Color(0xff00343F)),
//                                   ),
//                                 ],
//                               ),

//                               //icon

//                               const Icon(Icons.arrow_forward_ios_rounded,
//                                   color: Color(0xff101828)),

//                               //partCategory
//                               Text(
//                                 widget.partCategory,
//                                 // textAlign: TextAlign.center,
//                                 style: const TextStyle(
//                                     fontFamily: "NeulisAlt",
//                                     fontSize: 14,
//                                     fontStyle: FontStyle.normal,
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xff006C70)),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),

//                     //
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.10,
//                       child: Center(
//                         child: Container(
//                           // height: MediaQuery.of(context).size.height * 0.4,
//                           width: MediaQuery.of(context).size.width,
//                           decoration:   BoxDecoration(
//                               color: Colors.white,
//                               // color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               border: const Border(
//                                   top: BorderSide(
//                                       color: Color(0xffEEF5F5), width: 4))),
//                           padding: const EdgeInsets.all(8),
//                           child: MoticarLoginButton(
//                             myColor: AppColors.indieC,
//                             borderColor: AppColors.indieC,
//                             onTap: () async {
//                                 showDialog(
//                                   context: context,
//                                   barrierDismissible: true,
//                                   builder: (context) {
//                                     return Center(
//                                       child: AlertDialog(
//                                         backgroundColor:
//                                             AppColors.appThemeColor,
//                                         shadowColor: AppColors.appThemeColor,
//                                         content: Container(
//                                           padding: const EdgeInsets.all(20),
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                           ),
//                                           child: const Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               // const SpinKitWave(
//                                               //   color: AppColors.appThemeColor,
//                                               //   size: 30.0,
//                                               // ),

//                                               SizedBox(
//                                                 height: 100,
//                                                 width: 100,
//                                                 child: RiveAnimation.asset(
//                                                   'assets/images/preloader.riv',
//                                                 ),
//                                               ),
//                                               SizedBox(height: 8),
//                                               Text('Processing, please wait.',
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                       color: Colors.white))
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 );

//                                 await Future.delayed(
//                                     const Duration(seconds: 3));

//                                 Navigator.pop(context);

//                                 // Navigator.push(context, MaterialPageRoute(
//                                 //   builder: (context) {
//                                 //     return AddCarPage2(
//                                 //         imagePath: selectedImage,
//                                 //         carName: selectedCarName);
//                                 //   },
//                                 // ));

//                                 //
//                             },
//                             child: const MoticarText(
//                               fontColor: AppColors.appThemeColor,
//                               text: 'Continue',
//                               fontSize: 16,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           //bottom
//         ],
//       ),
//     );
//   }
// }

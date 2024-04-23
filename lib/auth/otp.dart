// // ignore_for_file: use_build_context_synchronously

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:moticar/widgets/eard_dialog.dart';

// import 'package:pinput/pinput.dart';

// import '../widgets/appBar.dart';
// import '../widgets/app_texts.dart';
// import '../widgets/colors.dart';

// class VerificationPage extends StatefulWidget {
//   const VerificationPage({
//     super.key,
//     required this.email,
//   });

//   final String email;

//   @override
//   State<StatefulWidget> createState() => _VerificationPage();
// }

// class _VerificationPage extends State<VerificationPage> {
//   final otpController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   bool isLoading = false;

//   static const focusedBorderColor = AppColors.appThemeColor;
//   static const fillColor = AppColors.white;
//   static const borderColor = AppColors.textGrey;

//   final defaultPinTheme = PinTheme(
//     width: 56,
//     height: 56,
//     textStyle: const TextStyle(
//       fontFamily: "Onest",
//       fontSize: 16,
//       color: AppColors.black,
//     ),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(5),
//       border: Border.all(color: borderColor),
//     ),
//   );

//   late Timer _timer;
//   int _start = 120;

//   void startTimer() {
//     _timer = Timer.periodic(
//       const Duration(seconds: 1),
//       (Timer timer) {
//         if (_start == 0) {
//           setState(() {
//             timer.cancel();
//           });
//         } else {
//           setState(() {
//             _start--;
//           });
//         }
//       },
//     );
//   }

//   @override
//   void initState() {
//     // startTimer();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     otpController.dispose();
//     _timer.cancel();
//     // phoneController.dispose();
//     // nameController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final model = ref.read(registerViewmodelProvider.notifier);
//     // final state = ref.watch(registerViewmodelProvider);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: const MoticarAppBar(
//         title: ' ',
//       ),
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               const SizedBox(height: 20),
//               //
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ListTile(
//                           contentPadding: EdgeInsets.all(6),
//                           title: Text(
//                             'Verify OTP',
//                             style: TextStyle(
//                               fontFamily: "Onest",
//                               fontSize: 25,
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.appThemeColor,
//                             ),
//                           ),
//                         ),

//                         // const SizedBox(height: 10),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     Form(
//                       key: _formKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // const SizedBox(height: 25),
//                           const Padding(
//                             padding:
//                                 EdgeInsets.only(top: 8.0, left: 8, right: 25),
//                             child: Text(
//                               'A 4-digit OTP code has been sent to ',
//                               style: TextStyle(
//                                 fontFamily: "Onest",
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 color: AppColors.textGrey,
//                               ),
//                             ),
//                           ),

//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               children: [
//                                 Text(
//                                   '${widget.email} ',
//                                   style: const TextStyle(
//                                     fontFamily: "Onest",
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                     color: AppColors.appThemeColor,
//                                   ),
//                                 ),
//                                 const Text(
//                                   'Enter the code below',
//                                   style: TextStyle(
//                                     fontFamily: "Onest",
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400,
//                                     color: AppColors.textGrey,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           const SizedBox(height: 20),

//                           const Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Text(
//                               'Enter OTP',
//                               style: TextStyle(
//                                 fontFamily: "Onest",
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 color: AppColors.black,
//                               ),
//                             ),
//                           ),

//                           //
//                           Padding(
//                             padding: const EdgeInsets.all(6.0),
//                             child: Pinput(
//                               length: 4,
//                               onTapOutside: (event) {
//                                 FocusManager.instance.primaryFocus?.unfocus();
//                               },
//                               listenForMultipleSmsOnAndroid: true,
//                               // androidSmsAutofillMethod:
//                               //     AndroidSmsAutofillMethod.smsUserConsentApi,
//                               controller: otpController,
//                               defaultPinTheme: defaultPinTheme.copyWith(
//                                 decoration:
//                                     defaultPinTheme.decoration!.copyWith(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(5),
//                                   border: Border.all(color: AppColors.textGrey),
//                                 ),
//                               ),
//                               // defaultPinTheme,
//                               validator: (pin) {
//                                 // if (pin == '123456') return null;
//                                 if (pin == '000000') {
//                                   return 'Default PIN cannot be used';
//                                 }
//                                 return null;
//                               },
//                               hapticFeedbackType:
//                                   HapticFeedbackType.lightImpact,
//                               onCompleted: (pin) {
//                                 debugPrint('onCompleted: $pin');
//                               },
//                               onChanged: (value) {
//                                 debugPrint('onChanged: $value');
//                               },
//                               cursor: Column(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Container(
//                                     margin: const EdgeInsets.only(bottom: 9),
//                                     width: 22,
//                                     height: 1,
//                                     color: focusedBorderColor,
//                                   ),
//                                 ],
//                               ),
//                               focusedPinTheme: defaultPinTheme.copyWith(
//                                 decoration:
//                                     defaultPinTheme.decoration!.copyWith(
//                                   borderRadius: BorderRadius.circular(5),
//                                   border: Border.all(color: focusedBorderColor),
//                                 ),
//                               ),
//                               submittedPinTheme: defaultPinTheme.copyWith(
//                                 decoration:
//                                     defaultPinTheme.decoration!.copyWith(
//                                   color: fillColor,
//                                   borderRadius: BorderRadius.circular(5),
//                                   border: Border.all(color: focusedBorderColor),
//                                 ),
//                               ),
//                               errorPinTheme: defaultPinTheme.copyBorderWith(
//                                 border: Border.all(color: Colors.redAccent),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(
//                 height: 40,
//               ),

//               //
//               Column(
//                 children: [
//                   MoticarButton(
//                     height: 55,
//                     width: MediaQuery.of(context).size.width - 30,
//                     onTap: () async {
//                       if (_formKey.currentState!.validate()) {
//                         showDialog(
//                           context: context,
//                           barrierDismissible: true,
//                           builder: (context) {
//                             return Center(
//                               child: AlertDialog(
//                                 backgroundColor: Colors.white,
//                                 shadowColor: Colors.white,
//                                 content: Container(
//                                   padding: const EdgeInsets.all(20),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: const Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       SpinKitWave(
//                                         color: AppColors.green,
//                                         size: 30.0,
//                                       ),
//                                       SizedBox(height: 8),
//                                       Text(
//                                         'Validation in progress, please wait...',
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                           fontFamily: "Onest",
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         );

//                         await Future.delayed(const Duration(milliseconds: 800));

//                         // Navigator.push(context,
//                         //     MaterialPageRoute(builder: (context) {
//                         //   return PersonalAcctOpenPage(
//                         //       );
//                         // }));
//                         await showDialog(
//                             context: context,
//                             builder: (context) {
//                               return MoticarDialog(
//                                 // icon: Icon(Icons.check),
//                                 title: "Success",
//                                 subtitle: "success message",
//                                 onTap: () {
//                                   // Navigator.push(context,
//                                   //     MaterialPageRoute(builder: (context) {
//                                   //   return const DashboardScafford();
//                                   // }));
//                                 },
//                                 buttonColor: AppColors.appThemeColor,
//                               );
//                             });
//                       }
//                     },
//                     child: isLoading
//                         ? const Center(
//                             child: CircularProgressIndicator(),
//                           )
//                         : const Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               MoticarText(
//                                 fontColor: AppColors.white,
//                                 text: 'Verify Email',
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                               SizedBox(width: 8),
//                               Icon(Icons.arrow_forward_sharp,
//                                   color: Colors.white),
//                             ],
//                           ),
//                   ),

//                   //
//                   const SizedBox(height: 20),

//                   //resend button
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const MoticarText(
//                         fontColor: AppColors.textGrey,
//                         text: 'Didn’t get the OTP Code? ',
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                       ),

//                       //
//                       TextButton(
//                         child: MoticarText(
//                           fontColor: AppColors.appThemeColor,
//                           text:
//                               'Resend in ${_start ~/ 60}:${(_start % 60).toString().padLeft(2, '0')}',
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                         onPressed: () {
//                           startTimer();
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),

//               const SizedBox(
//                 height: 20,
//               )

//               //
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moticar/auth/login/login_email.dart';
import 'package:moticar/widgets/appBar.dart';
import 'package:moticar/widgets/page_indicator.dart';
import 'package:rive/rive.dart';

import '../../providers/app_providers.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import '../../widgets/eard_dialog.dart';
import 'sign_3.dart';

class SignUpPage3Postal extends StatefulHookConsumerWidget {
  const SignUpPage3Postal( {super.key, required this.token,
  });
  final String token;

  @override
  ConsumerState<SignUpPage3Postal> createState() => _SignUpPage3PostalState();
}

class _SignUpPage3PostalState extends ConsumerState<SignUpPage3Postal> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final postalController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    postalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    final model = ref.read(profileProvider.notifier);
    return Scaffold(
      backgroundColor: const Color(0xffEEF5F5),
      appBar: const MoticarAppBar(title: 'Sign up to moticar'),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      PageIndicator(
                          currentPage: 3,
                          indicatorColor: AppColors.indieC,
                          inactiveIndicatorColor: Color(0xffD7E2E4),
                          totalPages: 4),
                    ],
                  ),

                  //
                  const MoticarText(
                      text: "Your Address",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontColor: AppColors.appThemeColor),
                  const Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 20, right: 50),
                    child: Text(
                        "These details are used to verify your identity and keep your details safe",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: "NeulisAlt",
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            height: 1.2,
                            fontWeight: FontWeight.w400,
                            color: AppColors.appThemeColor)),
                  ),

                  //switch to phone number instead
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return  SignUpPage3(
                              token: widget.token
                            );
                          }));
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 20,
                              color: AppColors.indieC,
                            ),

                            //
                            MoticarText(
                              fontColor: AppColors.lightGreen,
                              text: 'Enter address manually',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 8.0, bottom: 8, left: 3),
                          child: MoticarText(
                              text: "Postal Code",
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontColor: AppColors.appThemeColor),
                        ),
                        //email
                        TextFormField(
                          controller: postalController,
                          keyboardType: TextInputType.emailAddress,
                          onTapOutside: (event) {
                            FocusScope.of(context)
                                .unfocus(); // Close the keyboard
                          },
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(
                              fontFamily: "NeulisAlt",
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                              fontSize: 14),
                          onSaved: (value) {},
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColors.red, width: 1.5),
                            ),
                            hintText: 'Enter Postal Code',

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Color(0xffD0D5DD), width: 1.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: AppColors.appThemeColor)),
                            filled: true,
                            fillColor: Colors.white,
                            // hintText: 'Enter your password',
                            hintStyle: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontWeight: FontWeight.w400,
                                color: Color(0xffC1C3C3),
                                letterSpacing: 1.2,
                                fontSize: 14),
                          ),
                        ),

                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),

              // Spacer(),

              //
              Column(
                children: [
                  // const SizedBox(
                  //   height: 40,
                  // ),

                  //button
                  MoticarLoginButton(
                    myColor: AppColors.fadeWhite,
                    borderColor: AppColors.skipColor,
                    onTap: () async {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return const SignUpPage2();
                      // }));
                    },
                    child: const MoticarText(
                      fontColor: AppColors.skipColor,
                      text: 'Skip',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  //create an account
                   MoticarLoginButton(
                    myColor: AppColors.indieC,
                    borderColor: AppColors.indieC,
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        final String postal = postalController.text;
                        // final String address2 = address2Control.text;
                        // final String newCountry = selectedCountry.toString();
                        // final String land = landmarkControl.text;
                        // phoneController.text;

                        if (postal.isNotEmpty) {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return Center(
                                child: AlertDialog(
                                  backgroundColor: AppColors.appThemeColor,
                                  shadowColor: AppColors.appThemeColor,
                                  content: Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: RiveAnimation.asset(
                                            'assets/images/preloader.riv',
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        Text(
                                            'Uploading your address, please wait.',
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.white))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );

                          await Future.delayed(const Duration(seconds: 2));

                          Navigator.pop(context);

                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return SignUpPage4(
                          //       address1: address1,
                          //       address2: address2,
                          //       newCountry: newCountry,
                          //       state: selectedStatez.toString(),
                          //       lga: selectedLGA.toString(),
                          //       land: land,
                          //       token: widget.token);
                          // }));
                        } else {
                          // Show dialog if any required fields are empty
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return MoticarDialog(
                                icon: const Icon(Icons.info_rounded,
                                    color: AppColors.appThemeColor, size: 50),
                                title: '',
                                subtitle: 'All Fields are required to proceed',
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                buttonColor: AppColors.appThemeColor,
                                textColor: AppColors.white,
                                buttonText: "Dismiss",
                              );
                            },
                          );
                        }
                      }
                    },
                    child: const MoticarText(
                      fontColor: AppColors.appThemeColor,
                      text: 'Continue',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),


                  //
                  const SizedBox(
                    height: 10,
                  ),

                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const MoticarText(
                        fontColor: AppColors.textGrey,
                        text: "Can’t remember it?",
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w300,
                      ),

                      //
                      TextButton(
                        child: const MoticarText(
                          fontColor: AppColors.appThemeColor,
                          text: 'Enter address manually',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SignUpPage3(
                              token: widget.token
                            );
                          }));
                        },
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

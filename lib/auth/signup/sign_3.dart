// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:moticar/auth/login-android.dart';
import 'package:moticar/auth/login/login_email.dart';
import 'package:moticar/widgets/appBar.dart';
import 'package:moticar/widgets/page_indicator.dart';

import '../../providers/app_providers.dart';
import '../../services/hivekeys.dart';
import '../../services/localdatabase.dart';
import '../../splash/splashscreen/intro_page_1.dart';
import '../../utils/validator.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import '../../widgets/eard_dialog.dart';
import 'sign_2.dart';

class SignUpPage3 extends StatefulHookConsumerWidget {
  const SignUpPage3({super.key});

  @override
  ConsumerState<SignUpPage3> createState() => _SignUpPage3State();
}

class _SignUpPage3State extends ConsumerState<SignUpPage3> {
  bool hasLogged = HiveStorage.get(HiveKeys.hasLoggedIn) ?? false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final emailController = TextEditingController(
      text: HiveStorage.get(HiveKeys.hasLoggedIn) ?? false
          ? HiveStorage.get(HiveKeys.userEmail)
          : '');
  final phoneController = TextEditingController(
      // text: HiveStorage.get(HiveKeys.hasLoggedIn) ?? false
      //     ? HiveStorage.get(HiveKeys.userPassword)
      //     : ''
      );
  String email = '', password = '';

  // bool _isObscure = false;
  bool _isCheckboxChecked = false;
  bool _isButtonClicked = false;

  bool _isChecked = false;
  String? _emailError;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    final model = ref.read(profileProvider.notifier);
    return Scaffold(
      backgroundColor: const Color(0xffEEF5F5),
      appBar: const MoticarAppBar(title: 'Sign up to moticar'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Row(
                  children: [
                    PageIndicator(
                        currentPage: 3,
                        indicatorColor: AppColors.indieC,
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
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          height: 1.2,
                          fontWeight: FontWeight.w300,
                          color: AppColors.appThemeColor)),
                ),

                 //switch to phone number instead
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      // Navigator.push(context,
                                      //     MaterialPageRoute(builder: (context) {
                                      //   return const LoginPhonePage();
                                      // }));
                                    },
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.phone_iphone_rounded,
                                          size: 20,
                                          color: AppColors.lightGreen,
                                        ),
                                  
                                        //
                                        MoticarText(
                                          fontColor: AppColors.lightGreen,
                                          text: 'Use phone number instead',
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
                        padding: EdgeInsets.only(top: 8.0, bottom: 8, left: 3),
                        child: MoticarText(
                            text: "Address",
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            fontColor: AppColors.appThemeColor),
                      ),
                      //email
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        onTapOutside: (event) {
                          FocusScope.of(context)
                              .unfocus(); // Close the keyboard
                        },
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(
                            fontFamily: "NeulisAlt",
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            fontSize: 16),
                      

                        onSaved: (value) {
                          email = value!;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: AppColors.red, width: 1.5),
                          ),
                          hintText: 'Street address line 1',
                          errorText: _emailError, // Show the error message here

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
 TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        onTapOutside: (event) {
                          FocusScope.of(context)
                              .unfocus(); // Close the keyboard
                        },
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(
                            fontFamily: "NeulisAlt",
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            fontSize: 16),
                      

                        onSaved: (value) {
                          email = value!;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: AppColors.red, width: 1.5),
                          ),
                          hintText: 'Street address line 2',
                          errorText: _emailError, // Show the error message here

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

//coutry and state
 Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 3),
                                child: MoticarText(
                                    text: "Country",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    fontColor: AppColors.appThemeColor),
                              ),
                              //email
                              TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                onTapOutside: (event) {
                                  FocusScope.of(context)
                                      .unfocus(); // Close the keyboard
                                },
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    fontFamily: "NeulisAlt",
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                    fontSize: 16),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: AppColors.red, width: 1.5),
                                  ),
                                  hintText: 'Street address 1',
                                  errorText:
                                      _emailError, // Show the error message here

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
                            ],
                          ),
                        ),
                      ),
                      //
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 3),
                                child: MoticarText(
                                    text: "State",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    fontColor: AppColors.appThemeColor),
                              ),
                              //email
                              TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                onTapOutside: (event) {
                                  FocusScope.of(context)
                                      .unfocus(); // Close the keyboard
                                },
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    fontFamily: "NeulisAlt",
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                    fontSize: 16),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: AppColors.red, width: 1.5),
                                  ),
                                  hintText: 'Street address 1',
                                  errorText:
                                      _emailError, // Show the error message here

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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  //local gov
                  const SizedBox(height: 15,),
                  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 3),
                                child: MoticarText(
                                    text: "Local Goverment Area",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    fontColor: AppColors.appThemeColor),
                              ),
                              //email
                              TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                onTapOutside: (event) {
                                  FocusScope.of(context)
                                      .unfocus(); // Close the keyboard
                                },
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    fontFamily: "NeulisAlt",
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                    fontSize: 16),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: AppColors.red, width: 1.5),
                                  ),
                                  hintText: 'Street address 1',
                                  errorText:
                                      _emailError, // Show the error message here

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
                            ],
                          ),

                          //landmark
                           Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 3),
                                child: MoticarText(
                                    text: "Landmark",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    fontColor: AppColors.appThemeColor),
                              ),
                              //email
                              TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                onTapOutside: (event) {
                                  FocusScope.of(context)
                                      .unfocus(); // Close the keyboard
                                },
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    fontFamily: "NeulisAlt",
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                    fontSize: 16),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: AppColors.red, width: 1.5),
                                  ),
                                  hintText: 'Enter closest landmark to your address',
                                  errorText:
                                      _emailError, // Show the error message here

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
                            ],
                          ),




                      
                    ],
                  ),
                ),

                //stay signed in
               
                const SizedBox(
                  height: 12,
                ),

                //checks field
               
               

                //password
              ]),

              //
              Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  //button
                  MoticarLoginButton(
                    myColor: AppColors.fadeWhite,
                    borderColor: AppColors.indieC,
                    onTap: () async {
                      setState(() {
                        _isButtonClicked = true;
                      });
                     
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return const SignUpPage2();
                      }));

                      

                    },
                    child: const MoticarText(
                      fontColor: AppColors.appThemeColor,
                      text: 'Skip',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  //create an account
                  MoticarLoginButton(
                    myColor: AppColors.indieC,
                    borderColor: AppColors.indieC,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const LoginPage();
                      }));
                    },
                    child: const MoticarText(
                      fontColor: AppColors.appThemeColor,
                      text: 'Continue',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
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
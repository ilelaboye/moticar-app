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
import 'package:moticar/auth/signup/sign_3.dart';
import 'package:moticar/widgets/appBar.dart';
import 'package:moticar/widgets/page_indicator.dart';
import 'package:moticar/widgets/pass_strength_indicator.dart';

import '../../providers/app_providers.dart';
import '../../services/hivekeys.dart';
import '../../services/localdatabase.dart';
import '../../splash/splashscreen/intro_page_1.dart';
import '../../utils/validator.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import '../../widgets/eard_dialog.dart';
import 'signup.dart';

class SignUpPage2 extends StatefulHookConsumerWidget {
  const SignUpPage2({super.key});

  @override
  ConsumerState<SignUpPage2> createState() => _SignUpPage2State();
}

class _SignUpPage2State extends ConsumerState<SignUpPage2> {
  bool _isObscure = true;
  final passwordController = TextEditingController(
      // text: HiveStorage.get(HiveKeys.hasLoggedIn) ?? false
      //     ? HiveStorage.get(HiveKeys.userPassword)
      //     : ''
      );

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Row(
                  children: [
                    PageIndicator(
                        currentPage: 2,
                        indicatorColor: AppColors.indieC,
                        totalPages: 4),
                  ],
                ),

                //
                const MoticarText(
                    text: "More About You",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontColor: AppColors.appThemeColor),

                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: CircleAvatar(
                    backgroundColor: AppColors.diaColor,
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: CircleAvatar(
                        backgroundColor: AppColors.avaterColor,
                        child: Icon(Icons.person),
                      ),
                    ),
                  ),
                ),

                Form(
                  key: _formKey,
                  child: Row(
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
                                    text: "First Name",
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
                                  hintText: 'Enter first Name',
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
                                    text: "Last Name",
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
                                  hintText: 'Enter Last Name',
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
                ),

                //preffered

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8, left: 3),
                      child: MoticarText(
                          text: "Preferred Name (optional)",
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          fontColor: AppColors.appThemeColor),
                    ),
                    //email
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus(); // Close the keyboard
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
                        hintText: 'Any alias name would work',
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
                  ],
                ),
              ]),
              const SizedBox(
                height: 5,
              ),
              const Text(
                  "Afterall, who needs to be reminded of their names every single time",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.divider,
                    fontFamily: "NeulisAlt",
                  )),

              const SizedBox(
                height: 15,
              ),

              //password
              const Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8, left: 3),
                child: MoticarText(
                    text: "Password",
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    fontColor: AppColors.textColor),
              ),
              TextFormField(
                controller: passwordController,
                obscureText: _isObscure,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus(); // Close the keyboard
                },
                textInputAction: TextInputAction.done,
                style: const TextStyle(
                    fontFamily: "NeulisAlt",
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    PasswordValidator.validatePassword(value!),
                onSaved: (value) {
                  password = value!;
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  hintText: 'Enter your password',

                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color(0xffD0D5DD), width: 1.5)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: AppColors.appThemeColor)),
                  filled: true,
                  fillColor: Colors.white,
                  // hintText: 'Enter your password',
                  hintStyle: const TextStyle(
                      fontFamily: "NeulisAlt",
                      fontWeight: FontWeight.w400,
                      color: Color(0xffC1C3C3),
                      letterSpacing: 1.2,
                      fontSize: 14),

                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: Icon(
                        _isObscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: _isObscure
                            ? AppColors.oldGrey
                            : Colors.black.withOpacity(0.55)),
                  ),
                ),
              ),

              //password strength indicator
              const PassStrenghtIndicator(
                        currentPage: 1,
                        indicatorColor: AppColors.passStrength,
                        totalPages: 4),

//confirm password

              const Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8, left: 3),
                child: MoticarText(
                    text: "Confirm Password",
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    fontColor: AppColors.textColor),
              ),
              TextFormField(
                controller: passwordController,
                obscureText: _isObscure,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus(); // Close the keyboard
                },
                textInputAction: TextInputAction.done,
                style: const TextStyle(
                    fontFamily: "NeulisAlt",
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    PasswordValidator.validatePassword(value!),
                onSaved: (value) {
                  password = value!;
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  hintText: 'Enter your password',

                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color(0xffD0D5DD), width: 1.5)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: AppColors.appThemeColor)),
                  filled: true,
                  fillColor: Colors.white,
                  // hintText: 'Enter your password',
                  hintStyle: const TextStyle(
                      fontFamily: "NeulisAlt",
                      fontWeight: FontWeight.w400,
                      color: Color(0xffC1C3C3),
                      letterSpacing: 1.2,
                      fontSize: 14),

                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: Icon(
                        _isObscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: _isObscure
                            ? AppColors.oldGrey
                            : Colors.black.withOpacity(0.55)),
                  ),
                ),
              ),

              //
              Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  //button
                  MoticarLoginButton(
                    myColor: AppColors.indieC,
                    borderColor: AppColors.indieC,
                    onTap: () {
                      setState(() {
                        _isButtonClicked = true;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const SignUpPage3();
                      }));
                    },
                    child: const MoticarText(
                      fontColor: AppColors.appThemeColor,
                      text: 'Continue',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),

          //forgot details
        ),
      ),
    );
  }

  // Function to show bottom sheet with terms and conditions
  void _showTermsAndConditionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Add your terms and conditions here
                Text(
                  'Terms and Conditions',
                  style: TextStyle(
                    fontFamily: "NeulisAlt",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(height: 10),
                // Add your terms and conditions content here
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam congue ligula et eros bibendum, sit amet dapibus justo dignissim.',
                  style: TextStyle(
                    fontFamily: "NeulisAlt",
                    fontSize: 14,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //verify otp modal
  void _showOTPVerificationPage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
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
                      top: 30.0, left: 40, right: 40, bottom: 20),
                  child: Image.asset("assets/images/verify_motic.png"),
                ),
                // Add your terms and conditions here
                const Text(
                  'Terms and Conditions',
                  style: TextStyle(
                    fontFamily: "NeulisAlt",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 10),
                // Add your terms and conditions content here
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam congue ligula et eros bibendum, sit amet dapibus justo dignissim.',
                  style: TextStyle(
                    fontFamily: "NeulisAlt",
                    fontSize: 14,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../../splash/splashscreen/new_onboardIntro.dart';
import '../../utils/validator.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import '../../widgets/eard_dialog.dart';
import '../../widgets/pin_field.dart';
import 'sign_2.dart';

class SignUpPage extends StatefulHookConsumerWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  bool hasLogged = HiveStorage.get(HiveKeys.hasLoggedIn) ?? false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final emailController = TextEditingController(
      text: HiveStorage.get(HiveKeys.hasLoggedIn) ?? false
          ? HiveStorage.get(HiveKeys.userEmail)
          : '');
  final phoneController = TextEditingController();
  String email = '', password = '';

  // bool _isObscure = false;
  bool _isCheckboxChecked = false;
  bool _isButtonClicked = false;

  bool _isChecked = false;
  String? _emailError;

  String? completePhoneNumber;

  List<String> pinValues = List.filled(5, '');

  void updatePinValue(int index, String value) {
    setState(() {
      pinValues[index] = value;
    });
  }

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
                        currentPage: 1,
                        indicatorColor: AppColors.indieC,
                        inactiveIndicatorColor: Color(0xffD7E2E4),
                        totalPages: 4),
                  ],
                ),

                //
                const MoticarText(
                    text: "Your Login Details",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontColor: AppColors.appThemeColor),
                const Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 20),
                  child: Text(
                      "We’ll be using your email and phone number as the main log in credentials",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          height: 1.2,
                          fontWeight: FontWeight.w300,
                          color: AppColors.appThemeColor)),
                ),

                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8, left: 3),
                        child: MoticarText(
                            text: "Email",
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
                        // validator: (value) =>
                        //     EmailValidator.validateEmail(value!),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            setState(() {
                              _emailError = 'Email address is required';
                            });
                            return 'Email address is required';
                          } else if (!value.contains('@') ||
                              !value.contains('.')) {
                            setState(() {
                              _emailError = 'Enter a valid email address';
                            });
                            return 'Enter a valid email address';
                          }
                          setState(() {
                            _emailError = null;
                          });
                          return null;
                        },

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
                          hintText: 'Enter your email address',
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

                      //
                      // _emailError ?
                      Visibility(
                        visible: _emailError != null,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xffede9e9),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 12, top: 8, bottom: 8, right: 12),
                                decoration: BoxDecoration(
                                    color: AppColors.red,
                                    borderRadius: BorderRadius.circular(16)),
                                child: const Text(
                                  'Error',
                                  style: TextStyle(
                                    fontFamily: "NeulisAlt",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                _emailError ??
                                    '', // Show the error message here
                                style: const TextStyle(
                                  fontFamily: "NeulisAlt",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      //password
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8, left: 3),
                        child: MoticarText(
                            text: "Phone number",
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            fontColor: AppColors.appThemeColor),
                      ),
                      IntlPhoneField(
                        controller: phoneController,
                        style: const TextStyle(
                            fontFamily: "NeulisAlt",
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            fontSize: 16),
                        // validator: (value) =>
                        //     PhoneNumberValidator.validatePhoneNumber(value as String),
                        decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          errorBorder: InputBorder.none,
                          hintText: 'Enter your phone number',

                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Color(0xffD0D5DD), width: 1.5)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: AppColors.appThemeColor),
                          ),
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
                        initialCountryCode: 'NG',
                        onChanged: (phone) {
                          print(phone.completeNumber);
                          completePhoneNumber = phone.completeNumber;
                        },
                      ),
                    ],
                  ),
                ),

                //stay signed in
                Row(
                  children: [
                    Transform.scale(
                      scale: 0.8,
                      child: CupertinoSwitch(
                        value: state.stayLoggedIn,
                        activeColor: AppColors.yellow,
                        trackColor: AppColors.appThemeColor,
                        thumbColor: AppColors.white,
                        onChanged: (value) {
                          model.stayLoggedIN(value);
                        },
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(
                        height: 60,
                        // width: double.infinity,
                        child: ListTile(
                          title: Text(
                            "Remember me",
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textColor,
                                letterSpacing: 1.2,
                                fontSize: 14),
                          ),
                          subtitle: Text(
                            "Save my login details for next time.",
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textGrey,
                                letterSpacing: 1.2,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                const SizedBox(
                  height: 12,
                ),

                //checks field
                Row(
                  children: [
                    Checkbox.adaptive(
                        value: _isChecked,
                        activeColor: AppColors.indieC,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _isChecked = !_isChecked;
                          });
                        }),

                    //
                    const Text(
                      "I want to receive offers & updates",
                      style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor,
                          letterSpacing: 1.2,
                          fontSize: 14),
                    ),
                  ],
                ),

                //
                Row(
                  children: [
                    Checkbox.adaptive(
                      value: _isCheckboxChecked,
                      activeColor: AppColors.indieC,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _isCheckboxChecked = value ?? false;
                          if (_isCheckboxChecked) {
                            // Proceed with further actions if checkbox is checked
                          }
                        });
                        if (value ?? false) {
                          _showTermsAndConditionsBottomSheet(context);
                        }
                      },
                    ),

                    //
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text(
                          "I agree the terms of use & the privacy policy",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: "NeulisAlt",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor,
                              letterSpacing: 1.2,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: _isButtonClicked && !_isCheckboxChecked,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xffede9e9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 12, top: 8, bottom: 8, right: 12),
                          decoration: BoxDecoration(
                              color: AppColors.red,
                              borderRadius: BorderRadius.circular(16)),
                          child: const Text(
                            'Error',
                            style: TextStyle(
                              fontFamily: "NeulisAlt",
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          'Please read and accept the terms of use & privacy policy',
                          style: TextStyle(
                            fontFamily: "NeulisAlt",
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: AppColors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

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
                    myColor: AppColors.indieC,
                    borderColor: AppColors.indieC,
                    onTap: () async {
                      setState(() {
                        _isButtonClicked = true;
                      });
                      if (_formKey.currentState!.validate()) {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return const IntroPage2();
                        // }));

                        if (_isCheckboxChecked) {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return Center(
                                child: AlertDialog(
                                  backgroundColor: Colors.white,
                                  shadowColor: Colors.white,
                                  content: Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SpinKitWave(
                                          color: AppColors.appThemeColor,
                                          size: 30.0,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Processing, please wait.',
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );

                          await Future.delayed(
                              const Duration(milliseconds: 1000));
                        }

                        Navigator.pop(context);

                        _showOTPVerificationPage(context);
                      }

                      //push to page 2
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return const SignUpPage2();
                      // }));

                      // context.router.push(const LoginRouteCopy());
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

                  //create an account
                  MoticarLoginButton(
                    myColor: AppColors.white,
                    borderColor: AppColors.white,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const LoginPage();
                      }));
                      // context.router.push(const LoginRouteCopy());
                    },
                    child: const MoticarText(
                      fontColor: Color(0xff006C70),
                      text: 'Sign in',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  //using
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1.5,
                            color: AppColors.divider,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "or try using any of your social account",
                          style: TextStyle(
                              fontFamily: "NeulisAlt",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textGrey,
                              letterSpacing: 1.5,
                              fontSize: 13),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1.5,
                            color: AppColors.divider,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //others
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //facebook, google and twitter

                      OtherLoginButton(
                        myColor: Colors.transparent,
                        onTap: () {},
                        child: SvgPicture.asset(
                          "assets/svgs/faceB.svg",
                          height: 31,
                        ),
                      ),

                      OtherLoginButton(
                          myColor: Colors.transparent,
                          onTap: () {},
                          child: SvgPicture.asset("assets/svgs/Google.svg")),

                      OtherLoginButton(
                        onTap: () {},
                        myColor: Colors.transparent,
                        child: SvgPicture.asset("assets/svgs/x.svg"),
                      ),
                    ],
                  ),

                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const MoticarText(
                        fontColor: AppColors.textGrey,
                        text: "Already have an account?",
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w300,
                      ),

                      //
                      TextButton(
                        child: const MoticarText(
                          fontColor: AppColors.appThemeColor,
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
      backgroundColor: AppColors.diaColor,
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
                      top: 10.0, left: 40, right: 40, bottom: 20),
                  child: Image.asset("assets/images/verify_motic.png"),
                ),

                const Text(
                  "Enter Verification Code",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "NeulisAlt",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.textColor,
                  ),
                ),

                const SizedBox(height: 20),

                // Add your terms and conditions here
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: "NeulisAlt",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.textColor,
                    ),
                    children: [
                      const TextSpan(
                        text: "We have sent a code to ",
                      ),
                      TextSpan(
                        text: emailController.text,
                        // completePhoneNumber.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                // Add your terms and conditions content here
                const Text(
                  'Please enter it below',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "NeulisAlt",
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.textColor,
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PinField(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                      ),
                      onChanged: (value) => updatePinValue(0, value),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    PinField(
                      onChanged: (value) => updatePinValue(1, value),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    PinField(
                      onChanged: (value) => updatePinValue(2, value),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    PinField(
                      onChanged: (value) => updatePinValue(3, value),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    PinField(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                      ),
                      onChanged: (value) => updatePinValue(4, value),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 15,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MoticarLoginButton(
                    myColor: AppColors.appThemeColor,
                    borderColor: AppColors.diaColor,
                    onTap: () async {
                       Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return   SignUpPage2(
                          pin: "  "
                        );
                      }));
                    },
                    child: const MoticarText(
                      fontColor: AppColors.white,
                      text: 'Continue',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MoticarText(
                      fontColor: AppColors.appThemeColor,
                      text: "Didn’t get the code?",
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),

                    //
                    TextButton(
                      child: const MoticarText(
                        fontColor: AppColors.appThemeColor,
                        text: 'Send it again',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                      onPressed: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return const LoginPage();
                        // }));
                      },
                    ),
                  ],
                ),

                const SizedBox(
                  height: 45,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

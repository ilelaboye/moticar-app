// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moticar/auth/login/login_email.dart';
import 'package:moticar/auth/signup/sign_3.dart';
import 'package:moticar/widgets/appBar.dart';
import 'package:moticar/widgets/page_indicator.dart';
import 'package:moticar/widgets/pass_strength_indicator.dart';
import 'package:rive/rive.dart';

import '../../providers/app_providers.dart';
import '../../services/hivekeys.dart';
import '../../services/localdatabase.dart';
import '../../utils/validator.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../widgets/eard_dialog.dart';
import '../../widgets/image_picker_bottom_sheet.dart';
import '../../widgets/picked_image_display.dart';

class SignUpPage2 extends StatefulHookConsumerWidget {
  const SignUpPage2({
    super.key,
    required this.email,
  });
  final String email;

  @override
  ConsumerState<SignUpPage2> createState() => _SignUpPage2State();
}

class _SignUpPage2State extends ConsumerState<SignUpPage2> {
  bool _isObscure = true;
  final passwordController = TextEditingController();

  bool hasLogged = HiveStorage.get(HiveKeys.hasLoggedIn) ?? false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final firstController = TextEditingController();
  final lastNameController = TextEditingController();
  final preferControl = TextEditingController();
  final passWControl = TextEditingController();
  final confamControl = TextEditingController();
  String email = '', password = '';

  // bool _isObscure = false;
  bool _isConfirmObscure = true;
  // _isConfirmObscure

  bool _isChecked = false;
  String? _emailError;

  bool _showPasswordStrength = false; // Define _showPasswordStrength variable

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    firstController.dispose();
    lastNameController.dispose();
    preferControl.dispose();
    passWControl.dispose();
    confamControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    final model = ref.read(profileProvider.notifier);
    var images = useState(XFile(''));
    final _imagePicker = ref.read(imagePickerService);
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
                        inactiveIndicatorColor: Color(0xffD7E2E4),
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
                  height: 15,
                ),

                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // showModalBottomSheet(
                        //   // backgroundColor: Colors.transparent,
                        //   barrierColor: Colors.black.withOpacity(0.5),
                        //   context: context,
                        //   builder: (context) => ImagePickerWidget(
                        //     picker: _imagePicker,
                        //     imageList: images,
                        //     onImageSelected: () {},
                        //   ),
                        //   // context: context,
                        // );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (images.value.path.isNotEmpty)
                            PickedImageDisplay(
                              imageList: images,
                              isDark: false,
                            ),
                          if (images.value.path.isEmpty)
                            Container(
                              height: 120,
                              width: 120,
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0xffb8f2f4),
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff7AE6EB),

                                  // borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.person_3_outlined,
                                    size: 45,
                                    color: AppColors.appThemeColor,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    //
                    Positioned(
                      bottom: 10,
                      left: MediaQuery.of(context).size.width * 0.520,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            // backgroundColor: Colors.transparent,
                            barrierColor: Colors.black.withOpacity(0.5),
                            context: context,
                            builder: (context) => ImagePickerWidget(
                              picker: _imagePicker,
                              imageList: images,
                              onImageSelected: () {},
                            ),
                            // context: context,
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          padding: const EdgeInsets.all(3),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                color: Color(0xff002D36),
                                shape: BoxShape.circle),
                            child: SvgPicture.asset(
                              'assets/svgs/camera-01.svg',
                              height: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                //
                const SizedBox(
                  height: 12,
                ),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                                        text: "First Name",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        fontColor: AppColors.textColor),
                                  ),
                                  //email
                                  SizedBox(
                                    height: 55,
                                    child: TextFormField(
                                      controller: firstController,
                                      keyboardType: TextInputType.name,
                                      // onTapOutside: (event) {
                                      //   FocusScope.of(context)
                                      //       .unfocus(); // Close the keyboard
                                      // },
                                      textInputAction: TextInputAction.next,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      style: const TextStyle(
                                          fontFamily: "NeulisAlt",
                                          color: AppColors.textColor,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.2,
                                          fontSize: 15),
                                      validator: (value) =>
                                          FieldValidaor.validateEmptyfield(
                                              value!),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: AppColors.red, width: 1.5),
                                        ),
                                        hintText: 'Enter first Name',
                                        // errorText:
                                        //     _emailError, // Show the error message here

                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Color(0xffD0D5DD),
                                              width: 1.5),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color:
                                                    AppColors.appThemeColor)),
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
                                        fontColor: AppColors.textColor),
                                  ),
                                  //email
                                  SizedBox(
                                    height: 55,
                                    child: TextFormField(
                                      controller: lastNameController,
                                      keyboardType: TextInputType.name,
                                      // onTapOutside: (event) {
                                      //   FocusScope.of(context)
                                      //       .unfocus(); // Close the keyboard
                                      // },
                                      textCapitalization:
                                          TextCapitalization.words,
                                      validator: (value) =>
                                          FieldValidaor.validateEmptyfield(
                                              value!),
                                      textInputAction: TextInputAction.next,
                                      style: const TextStyle(
                                          fontFamily: "NeulisAlt",
                                          color: AppColors.textColor,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.2,
                                          fontSize: 15),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: AppColors.red, width: 1.5),
                                        ),
                                        hintText: 'Enter Last Name',
                                        // errorText:
                                        //     _emailError, // Show the error message here

                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Color(0xffD0D5DD),
                                              width: 1.5),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color:
                                                    AppColors.appThemeColor)),
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      //
                      const SizedBox(
                        height: 12,
                      ),

                      //preffered

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 8.0, bottom: 8, left: 3),
                            child: MoticarText(
                                text: "Preferred Name (optional)",
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontColor: AppColors.textColor),
                          ),
                          //email
                          SizedBox(
                            height: 55,
                            child: TextFormField(
                              controller: preferControl,
                              keyboardType: TextInputType.name,
                              // onTapOutside: (event) {
                              //   FocusScope.of(context).unfocus(); // Close the keyboard
                              // },
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(
                                  fontFamily: "NeulisAlt",
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2,
                                  fontSize: 15),
                              // validator: (value) =>
                              //     FieldValidaor.validateEmptyfield(value!),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppColors.red, width: 1.5),
                                ),
                                hintText: 'Any alias name would work',
                                // errorText:
                                //     _emailError, // Show the error message here

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
                          ),

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
                            padding:
                                EdgeInsets.only(top: 8.0, bottom: 8, left: 3),
                            child: MoticarText(
                                text: "Password",
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontColor: AppColors.textColor),
                          ),
                          Listener(
                            onPointerDown: (_) {
                              if (passwordController.text.isNotEmpty) {
                                setState(() {
                                  _showPasswordStrength = true;
                                });
                              }
                            },
                            child: SizedBox(
                              height: 55,
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: _isObscure,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                // onTapOutside: (event) {
                                //   FocusScope.of(context).unfocus(); // Close the keyboard
                                // },
                                textInputAction: TextInputAction.done,
                                style: const TextStyle(
                                    fontFamily: "NeulisAlt",
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.2,
                                    fontSize: 15),
                                // autovalidateMode: AutovalidateMode.onUserInteraction,
                                // validator: (value) =>
                                //     PasswordValidator.validatePassword(value!),
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      password = value!;
                                      _showPasswordStrength = true;
                                    });
                                  } else {
                                    setState(() {
                                      _showPasswordStrength = false;
                                    });
                                  }
                                },
                                onSaved: (value) {},
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  hintText: 'Enter your password',

                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0xffD0D5DD),
                                          width: 1.5)),
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
                            ),
                          ),

                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      ),

                      //
                      //password strength indicator
                      if (_showPasswordStrength)
                        PasswordStrengthIndicator(
                          password: passwordController.text,
                        ),

                      const SizedBox(
                        height: 12,
                      ),

//confirm password

                      const Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8, left: 3),
                        child: Row(
                          children: [
                            MoticarText(
                                text: "Confirm Password",
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontColor: AppColors.textColor),
                          ],
                        ),
                      ),
                      TextFormField(
                        controller: confamControl,
                        obscureText: _isConfirmObscure,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        // onTapOutside: (event) {
                        //   FocusScope.of(context).unfocus(); // Close the keyboard
                        // },
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(
                            fontFamily: "NeulisAlt",
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.2,
                            fontSize: 15),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            ConfirmPasswordValidator.validateConfirmPassword(
                                value, passwordController.text),
                        onSaved: (value) {
                          // confirmPassword = value!;
                        },
                        decoration: InputDecoration(
                          // border: InputBorder.none,
                          // errorBorder: InputBorder.none,
                           border: InputBorder.none,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: AppColors.red, width: 0.5),
                          ),
                          hintText: 'Confirm your password',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Color(0xffD0D5DD), width: 1.5)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColors.appThemeColor)),
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: const TextStyle(
                              fontFamily: "NeulisAlt",
                              fontWeight: FontWeight.w400,
                              color: Color(0xffC1C3C3),
                              letterSpacing: 1.2,
                              fontSize: 14),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isConfirmObscure = !_isConfirmObscure;
                              });
                            },
                            icon: Icon(
                                _isConfirmObscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: _isConfirmObscure
                                    ? AppColors.oldGrey
                                    : Colors.black.withOpacity(0.55)),
                          ),
                        ),
                      ),

                      //
                    ],
                  ),
                ),
              ]),

              //
              Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  //button
                  Consumer(builder: (context, ref, child) {
                    final model = ref.read(registerViewmodelProvider.notifier);

                    return MoticarLoginButton(
                      myColor: AppColors.indieC,
                      borderColor: AppColors.indieC,
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          final String firstName = firstController.text;
                          final String lastName = lastNameController.text;
                          final String nickname = preferControl.text;
                          final String passW = password;
                          final String confam = confamControl.text;

                          if (firstName.isNotEmpty &&
                              lastName.isNotEmpty &&
                              // nickname.isNotEmpty &&
                              passW.isNotEmpty &&
                              // images.value.path.isNotEmpty &&
                              confam.isNotEmpty) {
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
                                          // const SpinKitWave(
                                          //   color: AppColors.appThemeColor,
                                          //   size: 30.0,
                                          // ),

                                          SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: RiveAnimation.asset(
                                              'assets/images/preloader.riv',
                                            ),
                                          ),

                                          SizedBox(height: 12),

                                          Text('You are getting there...',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );

                            await Future.delayed(const Duration(seconds: 2));

                            // Navigator.pop(context);

                            String imagePath = images.value.path;

                            FormData formData = FormData.fromMap({
                              'email': widget.email,
                              'first_name': firstName,
                              'last_name': lastName,
                              'preferred_name': nickname,
                              'password': passW,
                              'image': await MultipartFile.fromFile(imagePath,
                                  filename: 'image'),
                            });

                            // All fields are filled, attempt sign-up
                            final signUpResult = await model.signUp(
                              formData: formData,
                            );

                            // Check the result of sign-up
                            if (signUpResult.successMessage.isNotEmpty) {
                              final newToken =
                                  ref.read(registerViewmodelProvider).token;

                              print("my new  $newToken");
                              // Sign-up successful, show success dialog
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => MoticarDialog(
                                  buttonColor: AppColors.appThemeColor,
                                  textColor: AppColors.white,
                                  buttonText: "Continue",
                                  subtitle: signUpResult.successMessage,
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return SignUpPage3(
                                          token: newToken.toString());
                                    }));
                                  },
                                ),
                              );
                            } else if (signUpResult.errorMessage.isNotEmpty) {
                              // Sign-up failed, show error dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return MoticarDialog(
                                    icon: const Icon(Icons.error_outline_sharp,
                                        color: AppColors.red, size: 50),
                                    title: '',
                                    subtitle: signUpResult.errorMessage,
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    buttonColor: AppColors.red,
                                    textColor: AppColors.white,
                                    buttonText: "Dismiss",
                                  );
                                },
                              );
                            }
                          } else {
                            // Show dialog if any required fields are empty
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return MoticarDialog(
                                  icon: const Icon(Icons.info_rounded,
                                      color: AppColors.appThemeColor, size: 50),
                                  title: '',
                                  subtitle:
                                      'All Fields are required to proceed',
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
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  }),

                  const SizedBox(
                    height: 10,
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
                          fontWeight: FontWeight.w700,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const LoginPage();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
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

  // verify otp modal
  // void _showOTPVerificationPage(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return SingleChildScrollView(
  //         child: Container(
  //           padding: const EdgeInsets.all(20),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.stretch,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   IconButton(
  //                     icon: const Icon(Icons.close, color: Color(0xff101828)),
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                   ),
  //                 ],
  //               ),

  //               //
  //               //image
  //               Padding(
  //                 padding: const EdgeInsets.only(
  //                     top: 30.0, left: 40, right: 40, bottom: 20),
  //                 child: Image.asset("assets/images/verify_motic.png"),
  //               ),
  //               // Add your terms and conditions here
  //               const Text(
  //                 'Terms and Conditions',
  //                 style: TextStyle(
  //                   fontFamily: "NeulisAlt",
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 18,
  //                   color: AppColors.textColor,
  //                 ),
  //               ),
  //               const SizedBox(height: 10),
  //               // Add your terms and conditions content here
  //               const Text(
  //                 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam congue ligula et eros bibendum, sit amet dapibus justo dignissim.',
  //                 style: TextStyle(
  //                   fontFamily: "NeulisAlt",
  //                   fontSize: 14,
  //                   color: AppColors.textColor,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}

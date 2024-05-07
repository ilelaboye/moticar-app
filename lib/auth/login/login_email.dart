// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moticar/Home/bottom_bar.dart';
import 'package:moticar/auth/signup/sign_2.dart';
import 'package:moticar/auth/signup/signup.dart';
import 'package:moticar/providers/auth_provider.dart';
import 'package:moticar/providers/authentication.dart';
import 'package:moticar/services/auth_services.dart';
import 'package:moticar/widgets/appBar.dart';
import 'package:moticar/widgets/auth/verifyResetToken.dart';
import 'package:moticar/widgets/bottom_sheet_service.dart';
import 'package:moticar/widgets/eard_loader.dart';
import 'package:moticar/widgets/flushbar.dart';
import 'package:moticar/widgets/loader.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rive/rive.dart';

import '../../providers/app_providers.dart';
import '../../services/hivekeys.dart';
import '../../services/localdatabase.dart';
import '../../splash/splashscreen/new_onboardIntro.dart';
import '../../utils/validator.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import '../../widgets/eard_dialog.dart';
import 'login_phone.dart';

class LoginPage extends StatefulHookConsumerWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool hasLogged = HiveStorage.get(HiveKeys.hasLoggedIn) ?? false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final emailController = TextEditingController(
      text: HiveStorage.get(HiveKeys.hasLoggedIn) ?? false
          ? HiveStorage.get(HiveKeys.userEmail)
          : '');
  final passwordController = TextEditingController(
      // text: HiveStorage.get(HiveKeys.hasLoggedIn) ?? false
      //     ? HiveStorage.get(HiveKeys.userPassword)
      //     : ''
      );

  String email = '', password = '';
  bool _isObscure = true;

  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    final model = ref.read(profileProvider.notifier);
    return Scaffold(
      backgroundColor: const Color(0xffEEF5F5),
      appBar: const MoticarAppBar(title: 'Sign in to moticar'),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 77,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const MoticarText(
                      text: "Enter Your Login Details",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontColor: AppColors.appThemeColor),
                  const Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 20),
                    child: Text("Glad to have you back",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "NeulisAlt",
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            // height: 1.2,
                            fontWeight: FontWeight.w400,
                            color: AppColors.appThemeColor)),
                  ),

                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 8.0, bottom: 4, left: 3),
                          child: MoticarText(
                              text: "Email",
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontColor: AppColors.textColor),
                        ),
                        //email
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          onTapOutside: (event) {
                            // FocusScope.of(context)
                            //     .unfocus(); // Close the keyboard
                          },
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(
                              fontFamily: "NeulisAlt",
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              EmailValidator.validateEmail(value!),
                          onSaved: (value) {
                            password = value!;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            hintText: 'Enter your email address',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 11),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Color(0xffD0D5DD), width: 1)),
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

                        //switch to phone number instead
                        // TextButton(
                        //   onPressed: () {
                        //     Navigator.push(context,
                        //         MaterialPageRoute(builder: (context) {
                        //       return const LoginPhonePage();
                        //     }));
                        //   },
                        //   child: const Row(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     children: [
                        //       Icon(
                        //         Icons.phone_iphone_rounded,
                        //         size: 20,
                        //         color: AppColors.lightGreen,
                        //       ),

                        //       //
                        //       MoticarText(
                        //         fontColor: AppColors.lightGreen,
                        //         text: 'Use phone number instead',
                        //         fontSize: 13,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        const SizedBox(height: 20),

                        //password
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 8.0, bottom: 4, left: 3),
                          child: MoticarText(
                              text: "Password",
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontColor: AppColors.textColor),
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: _isObscure,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          onTapOutside: (event) {
                            FocusScope.of(context)
                                .unfocus(); // Close the keyboard
                          },
                          textInputAction: TextInputAction.done,
                          style: const TextStyle(
                              fontFamily: "NeulisAlt",
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          // validator: (value) =>
                          //     PasswordValidator.validatePassword(value!),
                          onSaved: (value) {
                            password = value!;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            hintText: 'Enter password',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 11),
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
                              "Stay signed in",
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

                  //email field

                  //password
                ]),

                // SizedBox(
                //   height: 50,
                // ),

                //
                Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const MoticarText(
                          fontColor: AppColors.appThemeColor,
                          text: "Forgotten Details?",
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),

                        //
                        TextButton(
                          child: const MoticarText(
                            fontColor: AppColors.appThemeColor,
                            text: 'Recover it',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          onPressed: () {
                            showMoticarBottomSheet(
                                context: context,
                                child: ForgotPassword(),
                                radius: 0,
                                isDismissible: true,
                                background: true);
                          },
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    //Login
                    Consumer(builder: (context, ref, child) {
                      final model = ref.read(loginViewModelProvider.notifier);
                      return MoticarLoginButton(
                        myColor: AppColors.indieC,
                        borderColor: AppColors.indieC,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            final String myEmail = emailController.text;
                            final String myPass = passwordController.text;

                            // if(myEmail.isNotEmpty && myPass.isNotEmpty){
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
                                          SizedBox(height: 8),
                                          Text('Welcome to Moticar',
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

                            await Future.delayed(const Duration(seconds: 3));

                            // All fields are filled, attempt sign-up
                            final signUpResult = await model.login(
                              formData: {
                                'email': emailController.text,
                                'password': passwordController.text,
                              },
                            );

                            if (signUpResult.successMessage.isNotEmpty) {
                              Navigator.pop(context);

                              // Sign-up successful, show success dialog
                              await Future.delayed(
                                  const Duration(milliseconds: 100), () async {
                                await HiveStorage.put(
                                    HiveKeys.userEmail, emailController.text);
                                await HiveStorage.put(HiveKeys.userPassword,
                                    passwordController.text);
                                await HiveStorage.put(
                                    HiveKeys.hasLoggedIn, true);
                              });
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const BottomHomePage();
                              }));
                            } else if (signUpResult.errorMessage.isNotEmpty) {
                              Navigator.pop(context);
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
                                    },
                                    buttonColor: AppColors.red,
                                    textColor: AppColors.white,
                                    buttonText: "Dismiss",
                                  );
                                },
                              );
                            }
                          }

                          // context.router.push(const LoginRouteCopy());
                        },
                        child: const MoticarText(
                          fontColor: AppColors.appThemeColor,
                          text: 'Login',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    }),

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
                          return const SignUpPage();
                        }));
                        // context.router.push(const LoginRouteCopy());
                      },
                      child: const MoticarText(
                        fontColor: Color(0xff006C70),
                        text: 'Create an account',
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
                            width: 8,
                          ),
                          Text(
                            "or try using any of your social account",
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textGrey,
                                letterSpacing: 1.5,
                                fontSize: 10),
                          ),
                          SizedBox(
                            width: 8,
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
                          onTap: () {
                            AuthService.signInwithFacebook(context);
                          },
                          child: SvgPicture.asset(
                            "assets/svgs/faceB.svg",
                            height: 31,
                          ),
                        ),

                        OtherLoginButton(
                            onTap: () {
                              AuthService.signInwithGoogle(context);
                            },
                            child: SvgPicture.asset("assets/svgs/Google.svg")),

                        OtherLoginButton(
                          onTap: () {
                            AuthService.signInWithTwitter(context);
                          },
                          child: SvgPicture.asset("assets/svgs/x.svg"),
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
      ),
    );
  }
}

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final emailController = TextEditingController(text: 'ilela@gmail.com');
  String email = '';

  void forgotPassword() async {
    final form = _formKey.currentState!;

    if (form.validate()) {
      form.save();
      EasyLoading.show(status: 'Loading');
      Authentication provider = Authentication();

      print('entered');
      print(email);
      final res = await provider.forgotPassword(context, email);
      if (res['status']) {
        EasyLoading.dismiss();
        print('yes true');
        Alert.showNotification(
          message: "Reset code sent successfully",
          notificationType: 0,
          context: context,
        );
        showMoticarBottom(
            context: context,
            child: FractionallySizedBox(
              heightFactor: 0.8,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: ForgotPasswordTokenVerification(
                  emailController: emailController.text,
                ),
              ),
            ));
      }
    } else {
      Alert.showNotificationError(
        message: 'Invalid email address',
        context: context,
        notificationType: 1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 15,
          right: 15,
          top: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Forgot Password',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColors.appThemeColor),
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 4, left: 3),
                  child: MoticarText(
                      text: "Email",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontColor: AppColors.textColor),
                ),
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
                      fontSize: 16),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => EmailValidator.validateEmail(value!),
                  onSaved: (value) {
                    email = value!;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: AppColors.appThemeColor)),
                    // errorBorder: InputBorder.none,
                    hintText: 'Enter your email address',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 11),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: Color(0xffD0D5DD), width: 1)),
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
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
          MoticarLoginButton(
            myColor: AppColors.appThemeColor,
            borderColor: AppColors.white,
            onTap: () {
              forgotPassword();
              // context.router.push(const LoginRouteCopy());
            },
            child: const MoticarText(
              fontColor: Colors.white,
              text: 'Send Code',
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

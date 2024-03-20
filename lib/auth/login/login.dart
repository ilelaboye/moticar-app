import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moticar/widgets/appBar.dart';

import '../../providers/app_providers.dart';
import '../../services/hivekeys.dart';
import '../../services/localdatabase.dart';
import '../../splash/splashscreen/intro_page_1.dart';
import '../../utils/validator.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';

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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                fontFamily: "Neulis",
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
                                  EdgeInsets.only(top: 8.0, bottom: 8, left: 3),
                              child: MoticarText(
                                  text: "Email",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  fontColor: AppColors.textColor),
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
                                  fontFamily: "Neulis",
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) =>
                                  EmailValidator.validateEmail(value!),
                              onSaved: (value) {
                                password = value!;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                hintText: 'Enter your email address',

                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Color(0xffEEEFF0), width: 1.5)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: AppColors.appThemeColor)),
                                filled: true,
                                fillColor: Colors.white,
                                // hintText: 'Enter your password',
                                hintStyle: const TextStyle(
                                    fontFamily: "Neulis",
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffC1C3C3),
                                    letterSpacing: 1.2,
                                    fontSize: 14),
                              ),
                            ),

                            //switch to phone number instead
                            TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const LoginPage();
                                }));
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

                            const SizedBox(height: 20),

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
                                  fontFamily: "Neulis",
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                                        color: Color(0xffEEEFF0), width: 1.5)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: AppColors.appThemeColor)),
                                filled: true,
                                fillColor: Colors.white,
                                // hintText: 'Enter your password',
                                hintStyle: const TextStyle(
                                    fontFamily: "Neulis",
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
                                      fontFamily: "Neulis",
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textColor,
                                      letterSpacing: 1.2,
                                      fontSize: 14),
                                ),
                                subtitle: Text(
                                  "Save my login details for next time.",
                                  style: TextStyle(
                                      fontFamily: "Neulis",
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.textGrey,
                                      letterSpacing: 1.5,
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
              ),

              //
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const MoticarText(
                        fontColor: AppColors.appThemeColor,
                        text: "Forgotten Details?",
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w300,
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const LoginPage();
                          }));
                        },
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  //button
                  MoticarLoginButton(
                    myColor: AppColors.indieC,
                    borderColor: AppColors.indieC,
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return const IntroPage2();
                      // }));
                      // context.router.push(const LoginRouteCopy());
                    },
                    child: const MoticarText(
                      fontColor: AppColors.appThemeColor,
                      text: 'Login',
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
                              fontFamily: "Neulis",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textGrey,
                              letterSpacing: 1.5,
                              fontSize: 14),
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
                        onTap: () {},
                        child: SvgPicture.asset(
                          "assets/svgs/faceB.svg",
                          height: 31,
                        ),
                      ),

                      OtherLoginButton(
                          onTap: () {},
                          child: SvgPicture.asset("assets/svgs/Google.svg")),

                      OtherLoginButton(
                        onTap: () {},
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
    );
  }
}

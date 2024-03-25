// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moticar/auth/login/login_email.dart';
import 'package:moticar/auth/signup/sign_up3_postal.dart';
import 'package:moticar/auth/signup/signup_4.dart';
import 'package:moticar/widgets/appBar.dart';
import 'package:moticar/widgets/page_indicator.dart';

import '../../providers/app_providers.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';

class SignUpPage3 extends StatefulHookConsumerWidget {
  const SignUpPage3({super.key});

  @override
  ConsumerState<SignUpPage3> createState() => _SignUpPage3State();
}

class _SignUpPage3State extends ConsumerState<SignUpPage3> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final addressControl = TextEditingController();
  final address2Control = TextEditingController();
  final landmarkControl = TextEditingController();

  String? selectedLGA;

  String? selectedCountry;
  String? selectedStatez;

  final List myStatez = ['Osun', "Lagos", "Abuja"];

  final List myCount = ['Nigeria', "London UK", "Canada"];
  final List myLGA = ['Ori ade', "Ogbomoso", "Bodija"];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    addressControl.dispose();
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
                  padding: EdgeInsets.only(top: 8, bottom: 20, right: 50),
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
                          return const SignUpPage3Postal();
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
                            text: 'Use postal code instead',
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
                        controller: addressControl,
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
                          hintText: 'Street address line 1',

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
                        controller: address2Control,
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
                          hintText: 'Street address line 2',

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
                                  //Country
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8, left: 3, right: 3),
                                    child: DropdownButtonFormField(
                                        decoration: const InputDecoration(
                                          hintText: 'Select Country',
                                          hintStyle: TextStyle(
                                              fontFamily: "NeulisAlt",
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xffC1C3C3),
                                              letterSpacing: 1.2,
                                              fontSize: 14),
                                          filled: true,
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                                color: Color(0xffD0D5DD),
                                                width: 1.5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                                color: AppColors.appThemeColor,
                                                width: 1.5),
                                          ),
                                        ),
                                        items: myCount
                                            .map<DropdownMenuItem<String>>(
                                                (value) =>
                                                    DropdownMenuItem<String>(
                                                        value: value.toString(),
                                                        child: Text(
                                                          value.toString(),
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  "NeulisAlt",
                                                              color: AppColors
                                                                  .textColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              letterSpacing:
                                                                  1.2,
                                                              fontSize: 14),
                                                        )))
                                            .toList(),
                                        value: selectedCountry,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedCountry = value!;
                                          });
                                        }),
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
                                  //statez
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8, left: 3, right: 3),
                                    child: DropdownButtonFormField(
                                        decoration: const InputDecoration(
                                          hintText: 'Select State',
                                          hintStyle: TextStyle(
                                              fontFamily: "NeulisAlt",
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xffC1C3C3),
                                              letterSpacing: 1.2,
                                              fontSize: 14),
                                          filled: true,
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                                color: Color(0xffD0D5DD),
                                                width: 1.5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                                color: AppColors.appThemeColor,
                                                width: 1.5),
                                          ),
                                        ),
                                        items: myStatez
                                            .map<DropdownMenuItem<String>>(
                                                (value) =>
                                                    DropdownMenuItem<String>(
                                                        value: value.toString(),
                                                        child: Text(
                                                          value.toString(),
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  "NeulisAlt",
                                                              color: AppColors
                                                                  .textColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              letterSpacing:
                                                                  1.2,
                                                              fontSize: 14),
                                                        )))
                                            .toList(),
                                        value: selectedStatez,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedStatez = value!;
                                          });
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      //local gov
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 8.0, bottom: 8, left: 3),
                            child: MoticarText(
                                text: "Local Goverment Area",
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontColor: AppColors.appThemeColor),
                          ),
                          //lga drop down
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8, left: 3, right: 3),
                            child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Select LGA',
                                  hintStyle: TextStyle(
                                      fontFamily: "NeulisAlt",
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xffC1C3C3),
                                      letterSpacing: 1.2,
                                      fontSize: 14),
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color: Color(0xffD0D5DD), width: 1.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color: AppColors.appThemeColor,
                                        width: 1.5),
                                  ),
                                ),
                                items: myLGA
                                    .map<DropdownMenuItem<String>>(
                                        (value) => DropdownMenuItem<String>(
                                            value: value.toString(),
                                            child: Text(
                                              value.toString(),
                                              style: const TextStyle(
                                                  fontFamily: "NeulisAlt",
                                                  color: AppColors.textColor,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 1.2,
                                                  fontSize: 14),
                                            )))
                                    .toList(),
                                value: selectedLGA,
                                onChanged: (value) {
                                  setState(() {
                                    selectedLGA = value!;
                                  });
                                }),
                          ),
                        ],
                      ),

                      //landmark
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 8.0, bottom: 8, left: 3),
                            child: MoticarText(
                                text: "Landmark",
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontColor: AppColors.appThemeColor),
                          ),
                          //email
                          TextFormField(
                            controller: landmarkControl,
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
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: AppColors.red, width: 1.5),
                              ),
                              hintText:
                                  'Enter closest landmark to your address',

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
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const SignUpPage4();
                      }));
                    },
                    child: const MoticarText(
                      fontColor: AppColors.appThemeColor,
                      text: 'Continue',
                      fontSize: 14,
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

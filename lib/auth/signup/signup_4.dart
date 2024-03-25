// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moticar/auth/login/login_email.dart';
import 'package:moticar/widgets/appBar.dart';
import 'package:moticar/widgets/page_indicator.dart';

import '../../providers/app_providers.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import 'package:intl/intl.dart';

import '../add_car.dart';

class SignUpPage4 extends StatefulHookConsumerWidget {
  const SignUpPage4({super.key});

  @override
  ConsumerState<SignUpPage4> createState() => _SignUpPage4State();
}

class _SignUpPage4State extends ConsumerState<SignUpPage4> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final addressControl = TextEditingController();
  final address2Control = TextEditingController();
  final landmarkControl = TextEditingController();

  String? selectedLGA;
  String? selectedCountry;
  String? selectedStatez;

  final List myCurrency = ['Naira', "Pounds", "Dollars"];
  final List myCount = ['Nigeria', "London", "Canada"];

  DateTime? _selectedDate;
  String? gender;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      fieldHintText: "Date of Birth",
      fieldLabelText: "Date of Birth",
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return "Date of Birth *"; //YYYY-MM-DD
    }
    return DateFormat('dd/MM/yyyy').format(date);
    // Customize the format as you desire, for example 'dd/MM/yyyy' for day/month/year
  }

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
                        currentPage: 4,
                        indicatorColor: AppColors.indieC,
                        inactiveIndicatorColor: Color(0xffD7E2E4),
                        totalPages: 4),
                  ],
                ),

                //
                const MoticarText(
                    text: "Just a few more detail",
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

                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8, left: 3),
                        child: MoticarText(
                            text: "Date of Birth",
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            fontColor: AppColors.appThemeColor),
                      ),

                      //dob
                      GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(0xffD0D5DD),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: Colors.grey.withOpacity(0.8),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  _formatDate(_selectedDate),
                                  style: _selectedDate != null
                                      ? const TextStyle(
                                          fontFamily: "NeulisAlt",
                                          color: AppColors.textColor,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.2,
                                          fontSize: 14)
                                      : const TextStyle(
                                          fontFamily: "NeulisAlt",
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xffC1C3C3),
                                          letterSpacing: 1.2,
                                          fontSize: 14),
                                ),
                              ]),
                              Icon(
                                Icons.cancel_sharp,
                                color: Colors.grey.withOpacity(0.8),
                              ),
                            ],
                          ),
                        ),
                      ),

//Select Gender
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
                                      text: "Gender",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      fontColor: AppColors.appThemeColor,
                                    ),
                                  ),

                                  // Male
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: gender == 'male'
                                              ? AppColors.lightGreen
                                              : const Color(0xfff0f5f5),
                                          width: 1,
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.black45,
                                              blurRadius: 0.1),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          gender == 'male'
                                              ? const MoticarText(
                                                  text: 'Male',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  fontColor: AppColors.green,
                                                )
                                              : const MoticarText(
                                                  text: 'Male',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontColor: Color(0xff495353),
                                                ),
                                          Radio(
                                            toggleable: true,
                                            value: 'male',
                                            activeColor: AppColors.lightGreen,
                                            groupValue: gender,
                                            onChanged: (value) {
                                              setState(() {
                                                gender = value.toString();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                                      text: "Gender",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      fontColor: AppColors.appThemeColor,
                                    ),
                                  ),

                                  // Female
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: gender == 'female'
                                              ? AppColors.lightGreen
                                              : const Color(0xfff0f5f5),
                                          width: 1,
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.black45,
                                              blurRadius: 0.1),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          gender == 'female'
                                              ? const MoticarText(
                                                  text: 'Female',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  fontColor: AppColors.green,
                                                )
                                              : const MoticarText(
                                                  text: 'Female',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontColor: Color(0xff495353),
                                                ),
                                          Radio(
                                            toggleable: true,
                                            value: 'female',
                                            activeColor: AppColors.lightGreen,
                                            groupValue: gender,
                                            onChanged: (value) {
                                              setState(() {
                                                gender = value.toString();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
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
                                text: "Currency ",
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
                                  hintText: '[ ₦ ] Nigerian Naira',
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
                                items: myCurrency
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
                                text: "Location",
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
                                  hintText: 'Select Location',
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
                                items: myCount
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
                                value: selectedCountry,
                                onChanged: (value) {
                                  setState(() {
                                    selectedCountry = value!;
                                  });
                                }),
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
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: AppColors.white,
                        isScrollControlled: true,
                        builder: (context) {
                          return SingleChildScrollView(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Center(
                                // Wrap the content with Center widget
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10.0,
                                        left: 20,
                                        right: 20,
                                        bottom: 20,
                                      ),
                                      child: Image.asset(
                                          "assets/images/personal.png"),
                                    ),
                                    const Text(
                                      "Add your first personal car",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "NeulisAlt",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: AppColors.textColor,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        left: 30,
                                        right: 30,
                                        top: 15,
                                        bottom: 10,
                                      ),
                                      child: Text(
                                        'Start by adding the details of your personal car for a rich user experience',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "NeulisAlt",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: AppColors.textColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: MoticarLoginButton(
                                        myColor: AppColors.appThemeColor,
                                        borderColor: AppColors.white,
                                        onTap: () async {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const AddCarPage();
                                          }));
                                        },
                                        child: const MoticarText(
                                          fontColor: AppColors.white,
                                          text: 'Continue',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
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

// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moticar/auth/login/login_email.dart';
import 'package:moticar/auth/signup/sign_3.dart';
import 'package:moticar/widgets/appBar.dart';
import 'package:moticar/widgets/page_indicator.dart';
import 'package:rive/rive.dart';

import '../../providers/app_providers.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import 'package:intl/intl.dart';

import '../../widgets/eard_dialog.dart';
import '../add_car.dart';

class SignUpPage4 extends StatefulHookConsumerWidget {
  const SignUpPage4({
    super.key,
    required this.address1,
    required this.token,
    required this.address2,
    required this.land,
    required this.newCountry,
    required this.state,
    required this.lga,
  });
  final String address1, address2, lga, token, state, land, newCountry;

  @override
  ConsumerState<SignUpPage4> createState() => _SignUpPage4State();
}

class _SignUpPage4State extends ConsumerState<SignUpPage4> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  // final addressControl = TextEditingController();
  // final address2Control = TextEditingController();
  final landmarkControl = TextEditingController();

  String? selectedLGA;
  String? selectedCountry;
  // String? selectedLocation;
  String? selectedStatez;
  String? selectedCurrency;

  String selectedGender = '';

  final List myCurrency = ['Naira', "Pounds", "Dollars"];
  // final List myCount = ['Nigeria', "London", "Canada"];

  late List<Country> countries;

  @override
  void initState() {
    super.initState();
    loadCountries();
  }

  Future<void> loadCountries() async {
    String data = await rootBundle.loadString('assets/images/country.json');
    List<dynamic> countriesData = json.decode(data);
    countries = countriesData.map((countryData) {
      List<dynamic> statesData = countryData['states'];
      List<StateData> states = statesData.map((stateData) {
        List<dynamic> citiesData = stateData['cities'];
        List<City> cities = citiesData.map((cityData) {
          return City(
            id: cityData['id'],
            name: cityData['name'],
          );
        }).toList();
        return StateData(
          id: stateData['id'],
          name: stateData['name'],
          cities: cities,
        );
      }).toList();
      return Country(
        id: countryData['id'],
        name: countryData['name'],
        states: states,
      );
    }).toList();
    setState(() {});
  }

  DateTime? _selectedDate;
  String? gender;

  Future<void> _selectDate(BuildContext context) async {
    // Calculate the minimum selectable date (18 years ago from today)
    final DateTime minSelectableDate =
        DateTime.now().subtract(const Duration(days: 18 * 365));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ??
          minSelectableDate, // Use minSelectableDate as initialDate
      firstDate: DateTime(1914), // Start from 1914
      lastDate: minSelectableDate,
      fieldHintText: "Date of Birth *",
      fieldLabelText: "Date of Birth *",
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.appThemeColor, // Change primary color
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600), // Change text color
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary, // Change button text color
            ),
            dialogBackgroundColor:
                Colors.white, // Change dialog background color
            canvasColor: Colors.grey, // Change canvas color
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return "Date of Birth"; //YYYY-MM-DD
    }
    return DateFormat('yyyy/dd/MM').format(date);
    // Customize the format as you desire, for example 'dd/MM/yyyy' for day/month/year
  }

  @override
  void dispose() {
    // addressControl.dispose();
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
                      SizedBox(
                        height: 57,
                        child: GestureDetector(
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
                                            fontSize: 13)
                                        : const TextStyle(
                                            fontFamily: "NeulisAlt",
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffC1C3C3),
                                            fontSize: 13),
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
                                        top: 12.0, bottom: 8, left: 3),
                                    child: MoticarText(
                                      text: "Gender",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      fontColor: AppColors.appThemeColor,
                                    ),
                                  ),

                                  // Male
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: SizedBox(
                                      height: 57,
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    fontColor: AppColors.green,
                                                  )
                                                : const MoticarText(
                                                    text: 'Male',
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    fontColor:
                                                        Color(0xff495353),
                                                  ),
                                            Radio(
                                              toggleable: true,
                                              value: 'male',
                                              activeColor: AppColors.lightGreen,
                                              groupValue: gender,
                                              onChanged: (value) {
                                                setState(() {
                                                  gender = value.toString();
                                                  selectedGender = 'Male';
                                                });
                                              },
                                            ),
                                          ],
                                        ),
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
                                        top: 12.0, bottom: 8, left: 3),
                                    child: MoticarText(
                                      text: " ",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      fontColor: AppColors.appThemeColor,
                                    ),
                                  ),

                                  // Female
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 57,
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    fontColor: AppColors.green,
                                                  )
                                                : const MoticarText(
                                                    text: 'Female',
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    fontColor:
                                                        Color(0xff495353),
                                                  ),
                                            Radio(
                                              toggleable: true,
                                              value: 'female',
                                              activeColor: AppColors.lightGreen,
                                              groupValue: gender,
                                              onChanged: (value) {
                                                setState(() {
                                                  gender = value.toString();
                                                  selectedGender = 'Female';
                                                });
                                              },
                                            ),
                                          ],
                                        ),
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
                            child: SizedBox(
                              height: 57,
                              child: DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                    hintText: '[ N ] Nigerian Naira',
                                    hintStyle: TextStyle(
                                        fontFamily: "NeulisAlt",
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xffC1C3C3),
                                        fontSize: 13),
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
                                                    fontSize: 13),
                                              )))
                                      .toList(),
                                  value: selectedCurrency,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCurrency = value!;
                                    });
                                  }),
                            ),
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
                            child: SizedBox(
                              height: 57,
                              child: DropdownButtonFormField<String>(
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
                                  items: countries
                                      .map<DropdownMenuItem<String>>(
                                          (country) => DropdownMenuItem<String>(
                                              value: country.name.toString(),
                                              child: Text(
                                                country.name.toString(),
                                                style: const TextStyle(
                                                    fontFamily: "NeulisAlt",
                                                    color: AppColors.textColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13),
                                              )))
                                      .toList(),
                                  value: selectedCountry,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCountry = value!;
                                      // selectedStatez =
                                      //     null; // Reset selected state
                                    });
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //stay signed in

                const SizedBox(
                  height: 8,
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

                  //
                  Consumer(builder: (context, ref, child) {
                    final model = ref.read(registerViewmodelProvider.notifier);
                    return MoticarLoginButton(
                      myColor: AppColors.indieC,
                      borderColor: AppColors.indieC,
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          final String address1 = widget.address1;
                          final String address2 = widget.address2;
                          final String newCountry = widget.newCountry;
                          // final String land = widget.land;
                          final String lga = selectedLGA.toString();
                          final String state = selectedStatez.toString();
                          final String curren = selectedCurrency.toString();
                          // phoneController.text;

                          if (state.isNotEmpty && state.isNotEmpty) {
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

                            // All fields are filled, attempt sign-up
                            final signUpResult = await model.signUpFinal(
                              formData: {
                                'address1': address1,
                                'address2': address2,
                                'country': newCountry,
                                'state': widget.state,
                                'lga': widget.lga,
                                "landmark": widget.land,
                                'dob': _formatDate(_selectedDate),
                                'gender': selectedGender.toString(),
                                'currency': curren,
                              },
                              token: widget.token,
                            );

                            // Check the result of sign-up
                            if (signUpResult.successMessage.isNotEmpty) {
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
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      color:
                                                          AppColors.textColor,
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
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: "NeulisAlt",
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16,
                                                        color:
                                                            AppColors.textColor,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 30,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: MoticarLoginButton(
                                                      myColor: AppColors
                                                          .appThemeColor,
                                                      borderColor:
                                                          AppColors.white,
                                                      onTap: () async {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return const AddCarPage();
                                                        }));
                                                      },
                                                      child: const MoticarText(
                                                        fontColor:
                                                            AppColors.white,
                                                        text: 'Continue',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700,
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
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  MoticarLoginButton(
                    myColor: AppColors.fadeWhite,
                    borderColor: AppColors.skipColor,
                    onTap: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const LoginPage();
                      }));
                    },
                    child: const MoticarText(
                      fontColor: AppColors.skipColor,
                      text: 'Skip',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  //create an account
                  // MoticarLoginButton(
                  //   myColor: AppColors.indieC,
                  //   borderColor: AppColors.indieC,
                  //   onTap: () {
                  //     showModalBottomSheet(
                  //       context: context,
                  //       backgroundColor: AppColors.white,
                  //       isScrollControlled: true,
                  //       builder: (context) {
                  //         return SingleChildScrollView(
                  //           child: Container(
                  //             padding: const EdgeInsets.all(20),
                  //             child: Center(
                  //               // Wrap the content with Center widget
                  //               child: Column(
                  //                 mainAxisSize: MainAxisSize.min,
                  //                 crossAxisAlignment:
                  //                     CrossAxisAlignment.stretch,
                  //                 children: [
                  //                   Padding(
                  //                     padding: const EdgeInsets.only(
                  //                       top: 10.0,
                  //                       left: 20,
                  //                       right: 20,
                  //                       bottom: 20,
                  //                     ),
                  //                     child: Image.asset(
                  //                         "assets/images/personal.png"),
                  //                   ),
                  //                   const Text(
                  //                     "Add your first personal car",
                  //                     textAlign: TextAlign.center,
                  //                     style: TextStyle(
                  //                       fontFamily: "NeulisAlt",
                  //                       fontWeight: FontWeight.bold,
                  //                       fontSize: 18,
                  //                       color: AppColors.textColor,
                  //                     ),
                  //                   ),
                  //                   const Padding(
                  //                     padding: EdgeInsets.only(
                  //                       left: 30,
                  //                       right: 30,
                  //                       top: 15,
                  //                       bottom: 10,
                  //                     ),
                  //                     child: Text(
                  //                       'Start by adding the details of your personal car for a rich user experience',
                  //                       textAlign: TextAlign.center,
                  //                       style: TextStyle(
                  //                         fontFamily: "NeulisAlt",
                  //                         fontWeight: FontWeight.w400,
                  //                         fontSize: 16,
                  //                         color: AppColors.textColor,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   const SizedBox(
                  //                     height: 30,
                  //                   ),
                  //                   Padding(
                  //                     padding: const EdgeInsets.all(8.0),
                  //                     child: MoticarLoginButton(
                  //                       myColor: AppColors.appThemeColor,
                  //                       borderColor: AppColors.white,
                  //                       onTap: () async {
                  //                         Navigator.push(context,
                  //                             MaterialPageRoute(
                  //                                 builder: (context) {
                  //                           return const AddCarPage();
                  //                         }));
                  //                       },
                  //                       child: const MoticarText(
                  //                         fontColor: AppColors.white,
                  //                         text: 'Continue',
                  //                         fontSize: 14,
                  //                         fontWeight: FontWeight.w700,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         );
                  //       },
                  //     );
                  //   },
                  //   child: const MoticarText(
                  //     fontColor: AppColors.appThemeColor,
                  //     text: 'Continue',
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w700,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

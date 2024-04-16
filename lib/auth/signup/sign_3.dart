// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moticar/auth/login/login_email.dart';
import 'package:moticar/auth/signup/sign_up3_postal.dart';
import 'package:moticar/auth/signup/signup_4.dart';
import 'package:moticar/widgets/appBar.dart';
import 'package:moticar/widgets/page_indicator.dart';
import 'package:rive/rive.dart';

import '../../providers/app_providers.dart';
import '../../services/hivekeys.dart';
import '../../services/localdatabase.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import '../../widgets/eard_dialog.dart';

class SignUpPage3 extends StatefulHookConsumerWidget {
  const SignUpPage3({super.key, required this.token});
  final String token;

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

  late List<Country> countries;

  // final List myStatez = ['Osun', "Lagos", "Abuja"];

  // // final List myCount = ['Nigeria', "London UK", "Canada"];
  // final List myLGA = ['Ori ade', "Ogbomoso", "Bodija"];

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
                          return SignUpPage3Postal(
                            token: widget.token,
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
                      SizedBox(
                        height: 55,
                        child: TextFormField(
                          controller: addressControl,
                          keyboardType: TextInputType.streetAddress,
                          // onTapOutside: (event) {
                          //   FocusScope.of(context)
                          //       .unfocus(); // Close the keyboard
                          // },
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
                      ),

                      const SizedBox(height: 10),
                      SizedBox(
                        height: 55,
                        child: TextFormField(
                          controller: address2Control,
                          keyboardType: TextInputType.streetAddress,
                          // onTapOutside: (event) {
                          //   FocusScope.of(context)
                          //       .unfocus(); // Close the keyboard
                          // },
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
                      ),

                      const SizedBox(height: 8),

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
                                    child: SizedBox(
                                      height: 57,
                                      child: DropdownButtonFormField<String>(
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
                                          items: countries
                                              .map<DropdownMenuItem<String>>(
                                                  (country) => DropdownMenuItem<
                                                          String>(
                                                      value:
                                                          country.name.toString(),
                                                      child: Text(
                                                        country.name.toString(),
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "NeulisAlt",
                                                            color: AppColors
                                                                .textColor,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 12),
                                                      )))
                                              .toList(),
                                          value: selectedCountry,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedCountry = value!;
                                              selectedStatez =
                                                  null; // Reset selected state
                                            });
                                          }),
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
                                  //statez
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8, left: 3, right: 3),
                                    child: SizedBox(
                                      height: 57,
                                      child: DropdownButtonFormField<String>(
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
                                          items: selectedCountry != null
                                              ? countries
                                                  .firstWhere((country) =>
                                                      country.name ==
                                                      selectedCountry)
                                                  .states
                                                  .map<DropdownMenuItem<String>>(
                                                      (state) => DropdownMenuItem<
                                                              String>(
                                                          value: state.name
                                                              .toString(),
                                                          child: Text(
                                                            state.name.toString(),
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    "NeulisAlt",
                                                                color: AppColors
                                                                    .textColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,

                                                                fontSize: 12),
                                                          )))
                                                  .toList()
                                              : null,
                                          value: selectedStatez,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedStatez = value!;
                                              selectedLGA = null;
                                            });
                                          }),
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
                                text: "Local Goverment Area",
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
                              child: DropdownButtonFormField<String>(
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
                                  items: selectedCountry != null &&
                                          selectedStatez != null
                                      ? countries
                                          .firstWhere(
                                            (country) =>
                                                country.name == selectedCountry,
                                          )
                                          .states
                                          .firstWhere(
                                            (state) =>
                                                state.name == selectedStatez,
                                          )
                                          .cities
                                          .map<DropdownMenuItem<String>>(
                                              (city) => DropdownMenuItem<String>(
                                                  value: city.name.toString(),
                                                  child: Text(
                                                    city.name.toString(),
                                                    style: const TextStyle(
                                                        fontFamily: "NeulisAlt",
                                                        color:
                                                            AppColors.textColor,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: 1.2,
                                                        fontSize: 13),
                                                  )))
                                          .toList()
                                      : null,
                                  value: selectedLGA,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedLGA = value!;
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
                                text: "Landmark",
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontColor: AppColors.appThemeColor),
                          ),
                          //email
                          SizedBox(
                            height: 57,
                            child: TextFormField(
                              controller: landmarkControl,
                              keyboardType: TextInputType.streetAddress,
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
                        await HiveStorage.put(HiveKeys.token, widget.token);
                     Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SignUpPage4(
                            address1: "",
                            address2: "",
                            newCountry: "",
                            state: "",
                            lga: "",
                            land: " ",
                            token: widget.token);
                      }));
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
                        final String address1 = addressControl.text;
                        final String address2 = address2Control.text;
                        final String newCountry = selectedCountry.toString();
                        final String land = landmarkControl.text;
                        // phoneController.text;

                        if (address1.isNotEmpty &&
                            address2.isNotEmpty &&
                            land.isNotEmpty &&
                            newCountry.isNotEmpty) {
                          // showDialog(
                          //   context: context,
                          //   barrierDismissible: true,
                          //   builder: (context) {
                          //     return Center(
                          //       child: AlertDialog(
                          //         backgroundColor: AppColors.appThemeColor,
                          //         shadowColor: AppColors.appThemeColor,
                          //         content: Container(
                          //           padding: const EdgeInsets.all(20),
                          //           decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(10),
                          //           ),
                          //           child: const Column(
                          //             mainAxisSize: MainAxisSize.min,
                          //             children: [
                          //               SizedBox(
                          //                 height: 100,
                          //                 width: 100,
                          //                 child: RiveAnimation.asset(
                          //                   'assets/images/preloader.riv',
                          //                 ),
                          //               ),
                          //               SizedBox(height: 15),
                          //               Text(
                          //                   'Uploading your address, please wait.',
                          //                   textAlign: TextAlign.center,
                          //                   style:
                          //                       TextStyle(color: Colors.white))
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // );

                          // await Future.delayed(const Duration(milliseconds: 200));

                          // Navigator.pop(context);

                           await HiveStorage.put(
                                                  HiveKeys.token,
                                                  widget.token);

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SignUpPage4(
                                address1: address1,
                                address2: address2,
                                newCountry: newCountry,
                                state: selectedStatez.toString(),
                                lga: selectedLGA.toString(),
                                land: land,
                                token: widget.token);
                          }));
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Country {
  final int id;
  final String name;
  final List<StateData> states;

  Country({
    required this.id,
    required this.name,
    required this.states,
  });
}

class StateData {
  final int id;
  final String name;
  final List<City> cities;

  StateData({
    required this.id,
    required this.name,
    required this.cities,
  });
}

class City {
  final int id;
  final String name;

  City({
    required this.id,
    required this.name,
  });
}

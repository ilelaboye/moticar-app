// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:moticar/Home/bottom_bar.dart';
import 'package:moticar/utils/validator.dart';
import 'package:moticar/widgets/page_indicator.dart';
import 'package:rive/rive.dart';

import '../../providers/app_providers.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import '../widgets/bottom_sheet_service.dart';
import '../widgets/eard_dialog.dart';
import 'first_know.dart';

class AddCarPage4 extends StatefulHookConsumerWidget {
  const AddCarPage4(
      {super.key,
      required this.imagePath,
      required this.carName,
      required this.petrol,
      required this.gearbox,
      required this.model});
  final String imagePath, carName, model, petrol, gearbox;

  @override
  ConsumerState<AddCarPage4> createState() => _AddCarPage4State();
}

class _AddCarPage4State extends ConsumerState<AddCarPage4> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final plateController = TextEditingController();
  final mileageControl = TextEditingController();
  final chasisControl = TextEditingController();
  final engineNoController = TextEditingController();
  final thirdPartyControl = TextEditingController();
  final vehicleLicense = TextEditingController();

  bool isClicked = false;
  bool isVehicle = false;

  //
  bool isWorthiness = false;
  bool isLicense = false;
  bool isThirdParty = false;
  bool isTinted = false;
  // bool

  // bool isVisible = false;
  // bool isVisible2 = false;

  // bool isVisible3 = false;

  DateTime? _selectedDate;
  DateTime? _selectRenewal;
  DateTime? _selectWorthiness;
  DateTime? _selectThirdParty;
  DateTime? _selectTinted;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      fieldHintText: "Date of Purchase",
      fieldLabelText: "Date of Purchase",
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  //renewal
  Future<void> _selectRenewalDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectRenewal ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      fieldHintText: "Date of Renewal",
      fieldLabelText: "Date of Renewal",
    );

    if (picked != null && picked != _selectRenewal) {
      setState(() {
        _selectRenewal = picked;
      });
    }
  }

  //tinted
  Future<void> _selectTintedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectTinted ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      fieldHintText: "Date of Tinted License",
      fieldLabelText: "Date of Tinted License",
    );

    if (picked != null && picked != _selectTinted) {
      setState(() {
        _selectTinted = picked;
      });
    }
  }

  //worthiness
  Future<void> _selectWorthinessDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectWorthiness ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      fieldHintText: "Date of Worthiness",
      fieldLabelText: "Date of Worthiness",
    );

    if (picked != null && picked != _selectWorthiness) {
      setState(() {
        _selectWorthiness = picked;
      });
    }
  }

  //third
  Future<void> _selectThirdDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectThirdParty ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      fieldHintText: "Date of Third Party",
      fieldLabelText: "Date of Third Party",
    );

    if (picked != null && picked != _selectThirdParty) {
      setState(() {
        _selectThirdParty = picked;
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return "Date of Purchase"; //YYYY-MM-DD
    }
    return DateFormat('dd/MM/yyyy').format(date);
    // Customize the format as you desire, for example 'dd/MM/yyyy' for day/month/year
  }

  String _newFormatDate(DateTime? date) {
    if (date == null) {
      return "Date of Purchase"; // Placeholder text when no date is selected
    }

    // Format the date with day, month, and year
    String formattedDate = DateFormat('dd MMMM, yyyy').format(date);

    // Add the appropriate suffix for the day (e.g., 1st, 2nd, 3rd, 4th, etc.)
    // The suffix is based on the last digit of the day
    int day = date.day;
    String daySuffix = _getDaySuffix(day);

    // Separate the day part from the formatted date string and add the suffix
    String dayPart = formattedDate.split(' ')[0];
    String modifiedFormattedDate =
        "$dayPart$daySuffix ${formattedDate.substring(3)}";

    return modifiedFormattedDate;
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   String formatPlateText(String text) {
      // Check if the text is numeric
      if (int.tryParse(text) != null) {
        // Format the numeric text as "000 00 000"
        return text
            .padLeft(8, '0')
            .replaceAllMapped(
                RegExp(r'.{3}(?!$)'), (match) => '${match.group(0)} ')
            .trim();
      } else {
        // Return the text as is if it's not numeric
        return text;
      }
    }


    return Scaffold(
      backgroundColor: const Color(0xffEEF5F5),
      appBar: AppBar(
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Add your car details",
              style: TextStyle(
                fontFamily: "NeulisAlt",
                fontSize: 16,
                fontStyle: FontStyle.normal,
                letterSpacing: 1.2,
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Add your car details",
              style: TextStyle(
                fontFamily: "NeulisAlt",
                fontSize: 13,
                fontStyle: FontStyle.normal,
                letterSpacing: 1.2,
                color: AppColors.indieC,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        elevation: 1,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.appThemeColor,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            PageIndicator(
                                currentPage: 4,
                                indicatorColor: AppColors.indieC,
                                inactiveIndicatorColor: Color(0xffD7E2E4),
                                totalPages: 4),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Now save the details of your personal car for your keeps',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: "NeulisAlt",
                              fontSize: 18,
                              fontStyle: FontStyle.normal,
                              height: 1.2,
                              fontWeight: FontWeight.w600,
                              color: AppColors.appThemeColor),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'All information provided here would hlep you get all the details needed to get a good oversight of your car',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: "NeulisAlt",
                              fontSize: 13,
                              fontStyle: FontStyle.normal,
                              height: 1.2,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            height: 150,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage(
                                    'assets/svgs/numberPlateRep.png'),
                              ),
                            ),
                            child: Text(
                                // plateController.text.isNotEmpty
                                //     ? plateController.text
                                //     : '000 00 000',
                                formatPlateText(plateController.text),
                                style: GoogleFonts.russoOne(
                                  fontSize: 50,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.w700,
                                  color: plateController.text.isNotEmpty
                                      ? AppColors.appThemeColor
                                      : const Color(0xffC1C3C3),
                                )),
                          ),
                        ),

                        //

                        const SizedBox(
                          height: 20,
                        ),

                        //
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //password
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 3),
                                child: MoticarText(
                                    text: "Plate Number (Optional)",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    fontColor: AppColors.appThemeColor),
                              ),
                              TextFormField(
                                controller: plateController,
                                keyboardType: TextInputType.text,
                                textCapitalization:
                                    TextCapitalization.characters,
                                // onTapOutside: (event) {
                                //   FocusScope.of(context)
                                //       .unfocus(); // Close the keyboard
                                // },
                                maxLength: 8,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    fontFamily: "NeulisAlt",
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                                // autovalidateMode:
                                //     AutovalidateMode.onUserInteraction,
                                // validator: (value) =>
                                //     FieldValidaor.validateEmptyfield(value!),
                                onSaved: (value) {},
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  hintText: 'eg NJM 98 OLM',
                                  counterText: '',

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
                                ),
                              ),

                              const SizedBox(height: 8),

                              //mileage
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 3),
                                child: MoticarText(
                                    text: "Mileage (Optional)",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    fontColor: AppColors.textColor),
                              ),
                              TextFormField(
                                controller: mileageControl,
                                keyboardType: TextInputType.phone,
                                // onTapOutside: (event) {
                                //   FocusScope.of(context)
                                //       .unfocus(); // Close the keyboard
                                // },
                                textInputAction: TextInputAction.done,
                                style: const TextStyle(
                                    fontFamily: "NeulisAlt",
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                                // autovalidateMode:
                                //     AutovalidateMode.onUserInteraction,
                                // validator: (value) =>
                                //     FieldValidaor.validateEmptyfield(value!),
                                onSaved: (value) {},
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  hintText: 'eg 40000 ',

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
                                ),
                              ),

                              //chasis

                              const SizedBox(height: 8),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 3),
                                child: MoticarText(
                                    text: "Chasis Number (Optional)",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    fontColor: AppColors.appThemeColor),
                              ),
                              TextFormField(
                                controller: chasisControl,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    fontFamily: "NeulisAlt",
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                                onSaved: (value) {},
                                maxLength: 17,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  hintText: 'eg 2TIKR98D23C456159',
                                  counterText: '',

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
                                ),
                              ),

                              //engine number
                              const SizedBox(height: 8),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 3),
                                child: MoticarText(
                                    text: "Engine Number (Optional)",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    fontColor: AppColors.appThemeColor),
                              ),
                              TextFormField(
                                controller: engineNoController,
                                keyboardType: TextInputType.text,
                                // onTapOutside: (event) {
                                //   FocusScope.of(context)
                                //       .unfocus(); // Close the keyboard
                                // },
                                textInputAction: TextInputAction.done,
                                style: const TextStyle(
                                    fontFamily: "NeulisAlt",
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                                // autovalidateMode:
                                //     AutovalidateMode.onUserInteraction,
                                // validator: (value) =>
                                //     FieldValidaor.validateEmptyfield(value!),
                                onSaved: (value) {},
                                maxLength: 10,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  hintText: 'eg NJM 98 OLM',
                                  counterText: '',

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
                                ),
                              ),

                              //date of purcahse
                              const SizedBox(height: 8),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 3),
                                child: MoticarText(
                                    text: "Date of Purchase",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    fontColor: AppColors.appThemeColor),
                              ),

                              //date of purcahse
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedDate = null;
                                          });
                                        },
                                        child: Icon(
                                          Icons.cancel_sharp,
                                          color: Colors.grey.withOpacity(0.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),

                        //vehicle license
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isVehicle =
                                      !isVehicle; // Toggle the switch state
                                });
                              },
                              child: Row(
                                children: [
                                  Transform.scale(
                                    scale: 0.6,
                                    child: CupertinoSwitch(
                                      value: isVehicle,
                                      activeColor: AppColors.yellow,
                                      trackColor: AppColors.appThemeColor,
                                      thumbColor: AppColors.white,
                                      onChanged: (value) {
                                        setState(() {
                                          isVehicle =
                                              value; // Update the switch state
                                        });
                                      },
                                    ),
                                  ),
                                  const Text(
                                    "I have done the vehicle license",
                                    style: TextStyle(
                                        fontFamily: "NeulisAlt",
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textGrey,
                                        letterSpacing: 1.2,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible:
                                  isVehicle, // Show the TextField when the switch is active
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 8.0, bottom: 8, left: 3),
                                    child: MoticarText(
                                        text: "Select date of renewal",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        fontColor: AppColors.appThemeColor),
                                  ),

                                  //dob
                                  GestureDetector(
                                    onTap: () {
                                      _selectRenewalDate(context);
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(children: [
                                            Icon(
                                              Icons.calendar_today_outlined,
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              _formatDate(_selectRenewal),
                                              style: _selectRenewal != null
                                                  ? const TextStyle(
                                                      fontFamily: "NeulisAlt",
                                                      color:
                                                          AppColors.textColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 1.2,
                                                      fontSize: 14)
                                                  : const TextStyle(
                                                      fontFamily: "NeulisAlt",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xffC1C3C3),
                                                      letterSpacing: 1.2,
                                                      fontSize: 14),
                                            ),
                                          ]),

                                          //
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _selectedDate = null;
                                              });
                                            },
                                            child: Icon(
                                              Icons.cancel_sharp,
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //
                                ],
                              ),
                            ),
                            // Visibility(
                            //   visible:
                            //       !isVehicle, // Show the SizedBox when the switch is inactive
                            //   child: const SizedBox(
                            //       width: 200), // Adjust the width as needed
                            // ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        //isWorthiness
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isWorthiness = !isWorthiness;
                                });
                              },
                              child: Row(
                                children: [
                                  Transform.scale(
                                    scale: 0.6,
                                    child: CupertinoSwitch(
                                      value: isWorthiness,
                                      activeColor: AppColors.yellow,
                                      trackColor: AppColors.appThemeColor,
                                      thumbColor: AppColors.white,
                                      onChanged: (value) {
                                        setState(() {
                                          isWorthiness = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      // height: 60,
                                      padding: const EdgeInsets.all(8),
                                      // width: double.infinity,
                                      child: const Text(
                                        "I have done the Road Worthiness (Referral Note)",
                                        style: TextStyle(
                                            fontFamily: "NeulisAlt",
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textGrey,
                                            letterSpacing: 1.2,
                                            fontSize: 13),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Visibility(
                              visible:
                                  isWorthiness, // Show the TextField when the switch is active
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 8.0, bottom: 8, left: 3),
                                    child: MoticarText(
                                        text: "Select date of Road Worthiness",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        fontColor: AppColors.appThemeColor),
                                  ),

                                  //dob
                                  GestureDetector(
                                    onTap: () {
                                      _selectWorthinessDate(context);
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(children: [
                                            Icon(
                                              Icons.calendar_today_outlined,
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              _formatDate(_selectWorthiness),
                                              style: _selectWorthiness != null
                                                  ? const TextStyle(
                                                      fontFamily: "NeulisAlt",
                                                      color:
                                                          AppColors.textColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 1.2,
                                                      fontSize: 14)
                                                  : const TextStyle(
                                                      fontFamily: "NeulisAlt",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xffC1C3C3),
                                                      letterSpacing: 1.2,
                                                      fontSize: 14),
                                            ),
                                          ]),

                                          //
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _selectedDate = null;
                                              });
                                            },
                                            child: Icon(
                                              Icons.cancel_sharp,
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        //isThirdParty
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isThirdParty = !isThirdParty;
                                });
                              },
                              child: Row(
                                children: [
                                  Transform.scale(
                                    scale: 0.6,
                                    child: CupertinoSwitch(
                                      value: isThirdParty,
                                      activeColor: AppColors.yellow,
                                      trackColor: AppColors.appThemeColor,
                                      thumbColor: AppColors.white,
                                      onChanged: (value) {
                                        setState(() {
                                          isThirdParty = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      // height: 60,
                                      padding: const EdgeInsets.all(8),
                                      // width: double.infinity,
                                      child: const Text(
                                        "I have done the Third Party Insurance",
                                        style: TextStyle(
                                            fontFamily: "NeulisAlt",
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textGrey,
                                            letterSpacing: 1.2,
                                            fontSize: 13),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            //
                            Visibility(
                              visible:
                                  isThirdParty, // Show the TextField when the switch is active
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 8.0, bottom: 8, left: 3),
                                    child: MoticarText(
                                        text:
                                            "Select date of Third Party Insurance",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        fontColor: AppColors.appThemeColor),
                                  ),

                                  //dob
                                  GestureDetector(
                                    onTap: () {
                                      _selectThirdDate(context);
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(children: [
                                            Icon(
                                              Icons.calendar_today_outlined,
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              _formatDate(_selectThirdParty),
                                              style: _selectThirdParty != null
                                                  ? const TextStyle(
                                                      fontFamily: "NeulisAlt",
                                                      color:
                                                          AppColors.textColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 1.2,
                                                      fontSize: 14)
                                                  : const TextStyle(
                                                      fontFamily: "NeulisAlt",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xffC1C3C3),
                                                      letterSpacing: 1.2,
                                                      fontSize: 14),
                                            ),
                                          ]),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _selectedDate = null;
                                              });
                                            },
                                            child: Icon(
                                              Icons.cancel_sharp,
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        //hackney permit
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isTinted =
                                      !isTinted; // Toggle the switch state
                                });
                              },
                              child: Row(
                                children: [
                                  Transform.scale(
                                    scale: 0.6,
                                    child: CupertinoSwitch(
                                      value: isTinted,
                                      activeColor: AppColors.yellow,
                                      trackColor: AppColors.appThemeColor,
                                      thumbColor: AppColors.white,
                                      onChanged: (value) {
                                        setState(() {
                                          isTinted = value;
                                        });
                                      },
                                    ),
                                  ),
                                  const Text(
                                    "I have a Tinted Permit",
                                    style: TextStyle(
                                        fontFamily: "NeulisAlt",
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textGrey,
                                        letterSpacing: 1.2,
                                        fontSize: 13),
                                  )
                                ],
                              ),
                            ),
                            Visibility(
                              visible:
                                  isTinted, // Show the TextField when the switch is active
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 8.0, bottom: 8, left: 3),
                                    child: MoticarText(
                                        text: "Select date of Tinted Permit",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        fontColor: AppColors.appThemeColor),
                                  ),

                                  //tinted permit
                                  GestureDetector(
                                    onTap: () {
                                      _selectTintedDate(context);
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(children: [
                                            Icon(
                                              Icons.calendar_today_outlined,
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              _formatDate(_selectTinted),
                                              style: _selectTinted != null
                                                  ? const TextStyle(
                                                      fontFamily: "NeulisAlt",
                                                      color:
                                                          AppColors.textColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 1.2,
                                                      fontSize: 14)
                                                  : const TextStyle(
                                                      fontFamily: "NeulisAlt",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xffC1C3C3),
                                                      letterSpacing: 1.2,
                                                      fontSize: 14),
                                            ),
                                          ]),

                                          //
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _selectedDate = null;
                                              });
                                            },
                                            child: Icon(
                                              Icons.cancel_sharp,
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        // //og-hut
                        // Row(
                        //   children: [
                        //     Transform.scale(
                        //       scale: 0.6,
                        //       child: CupertinoSwitch(
                        //         value: state.stayLoggedIn,
                        //         activeColor: AppColors.yellow,
                        //         trackColor: AppColors.appThemeColor,
                        //         thumbColor: AppColors.white,
                        //         onChanged: (value) {
                        //           model.stayLoggedIN(value);
                        //         },
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: Container(
                        //         // height: 60,
                        //         padding: const EdgeInsets.all(8),
                        //         // width: double.infinity,
                        //         child: const Text(
                        //           "I have done a OG-HUT (Highway Users Tax)",
                        //           style: TextStyle(
                        //               fontFamily: "NeulisAlt",
                        //               fontStyle: FontStyle.normal,
                        //               fontWeight: FontWeight.w400,
                        //               color: AppColors.textGrey,
                        //               letterSpacing: 1.2,
                        //               fontSize: 13),
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // ),

                        // const SizedBox(height: 8),

                        // //state Carriage
                        // Row(
                        //   children: [
                        //     Transform.scale(
                        //       scale: 0.6,
                        //       child: CupertinoSwitch(
                        //         value: state.stayLoggedIn,
                        //         activeColor: AppColors.yellow,
                        //         trackColor: AppColors.appThemeColor,
                        //         thumbColor: AppColors.white,
                        //         onChanged: (value) {
                        //           model.stayLoggedIN(value);
                        //         },
                        //       ),
                        //     ),
                        //     const Text(
                        //       "I have done a State Carriage Permit",
                        //       style: TextStyle(
                        //           fontFamily: "NeulisAlt",
                        //           fontStyle: FontStyle.normal,
                        //           fontWeight: FontWeight.w400,
                        //           color: AppColors.textGrey,
                        //           letterSpacing: 1.2,
                        //           fontSize: 13),
                        //     )
                        //   ],
                        // ),

                        // const SizedBox(height: 8),

                        // //heavy duty
                        // Row(
                        //   children: [
                        //     Transform.scale(
                        //       scale: 0.6,
                        //       child: CupertinoSwitch(
                        //         value: state.stayLoggedIn,
                        //         activeColor: AppColors.yellow,
                        //         trackColor: AppColors.appThemeColor,
                        //         thumbColor: AppColors.white,
                        //         onChanged: (value) {
                        //           model.stayLoggedIN(value);
                        //         },
                        //       ),
                        //     ),
                        //     const Text(
                        //       "I have done a Heavy Duty Permit",
                        //       style: TextStyle(
                        //           fontFamily: "NeulisAlt",
                        //           fontStyle: FontStyle.normal,
                        //           fontWeight: FontWeight.w400,
                        //           color: AppColors.textGrey,
                        //           letterSpacing: 1.2,
                        //           fontSize: 13),
                        //     )
                        //   ],
                        // ),

                        // const SizedBox(height: 8),

                        // //truck & trailer permit
                        // Row(
                        //   children: [
                        //     Transform.scale(
                        //       scale: 0.6,
                        //       child: CupertinoSwitch(
                        //         value: state.stayLoggedIn,
                        //         activeColor: AppColors.yellow,
                        //         trackColor: AppColors.appThemeColor,
                        //         thumbColor: AppColors.white,
                        //         onChanged: (value) {
                        //           model.stayLoggedIN(value);
                        //         },
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: Container(
                        //         // height: 60,
                        //         padding: const EdgeInsets.all(8),
                        //         // width: double.infinity,
                        //         child: const Text(
                        //           "I have done a Truck & Trailer Permit (TTP)",
                        //           style: TextStyle(
                        //               fontFamily: "NeulisAlt",
                        //               fontStyle: FontStyle.normal,
                        //               fontWeight: FontWeight.w400,
                        //               color: AppColors.textGrey,
                        //               letterSpacing: 1.2,
                        //               fontSize: 13),
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // ),

                        // const SizedBox(height: 8),
                        // //Local Govt Permit
                        // Row(
                        //   children: [
                        //     Transform.scale(
                        //       scale: 0.6,
                        //       child: CupertinoSwitch(
                        //         value: state.stayLoggedIn,
                        //         activeColor: AppColors.yellow,
                        //         trackColor: AppColors.appThemeColor,
                        //         thumbColor: AppColors.white,
                        //         onChanged: (value) {
                        //           model.stayLoggedIN(value);
                        //         },
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: Container(
                        //         // height: 60,
                        //         padding: const EdgeInsets.all(8),
                        //         // width: double.infinity,
                        //         child: const Text(
                        //           "I have done a Local Govt. Permit (Nigeria)",
                        //           style: TextStyle(
                        //               fontFamily: "NeulisAlt",
                        //               fontStyle: FontStyle.normal,
                        //               fontWeight: FontWeight.w400,
                        //               color: AppColors.textGrey,
                        //               letterSpacing: 1.2,
                        //               fontSize: 13),
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // ),

                        // const SizedBox(height: 8),

                        // //mid year permit
                        // Row(
                        //   children: [
                        //     Transform.scale(
                        //       scale: 0.6,
                        //       child: CupertinoSwitch(
                        //         value: state.stayLoggedIn,
                        //         activeColor: AppColors.yellow,
                        //         trackColor: AppColors.appThemeColor,
                        //         thumbColor: AppColors.white,
                        //         onChanged: (value) {
                        //           model.stayLoggedIN(value);
                        //         },
                        //       ),
                        //     ),
                        //     const Text(
                        //       "I have done a Mid Year Permit",
                        //       style: TextStyle(
                        //           fontFamily: "NeulisAlt",
                        //           fontStyle: FontStyle.normal,
                        //           fontWeight: FontWeight.w400,
                        //           color: AppColors.textGrey,
                        //           letterSpacing: 1.2,
                        //           fontSize: 13),
                        //     )
                        //   ],
                        // ),

                        // const SizedBox(height: 8),

                        // //
                        //GearBox
                      ],
                    ),

                    //
                  ],
                ),
              ),
            ),
          ),

          //bottom
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  // color: Color(0xffEEF5F5),
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(color: Color(0xffEEF5F5), width: 4))),
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //remind me later
                    MoticarLoginButton(
                      myColor: AppColors.white,
                      borderColor: AppColors.appThemeColor,
                      onTap: () {
                        //showDialog AI Generator
                        // _showOTPVerificationPage(context);
                      },
                      child: const MoticarText(
                        fontColor: AppColors.skipColor,
                        text: 'Remind me later',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 8),

                    //finish
                    MoticarLoginButton(
                      myColor: AppColors.indieC,
                      borderColor: AppColors.indieC,
                      onTap: () {
                        //showDialog AI Generator
                        // _showOTPVerificationPage(context);

                        if (_formKey.currentState!.validate()) {
                          final String plate = plateController.text;
                          final String mileage = mileageControl.text;
                          final String chasis = chasisControl.toString();
                          final String engine = engineNoController.text;
                          final String third = thirdPartyControl.text;
                          final String licensez = vehicleLicense.text;

                          //dates
                          final String purchase = _newFormatDate(_selectedDate);
                          final String select = _newFormatDate(_selectedDate);
                          final String selectRenewal =
                              _newFormatDate(_selectRenewal);
                          final String selectThirdParty =
                              _newFormatDate(_selectThirdParty);
                          final String selectTinted =
                              _newFormatDate(_selectTinted);

                          if (licensez.isNotEmpty &&
                              third.isNotEmpty &&
                              purchase.isNotEmpty &&
                              select.isNotEmpty &&
                              selectTinted.isNotEmpty &&
                              selectRenewal.isNotEmpty &&
                              selectThirdParty.isNotEmpty) {
                            showMoticarBottom(
                              context: context,
                              child: FractionallySizedBox(
                                heightFactor: 0.89,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                  ),
                                  child: FinishcarPage(
                                    carName: widget.carName,
                                    imagePath: 'assets/images/car_ai.png',
                                    model: widget.model,
                                    petrol: widget.petrol,
                                    gearbox: widget.gearbox,
                                    purchaseDate: _newFormatDate(_selectedDate),
                                    plateController: '',
                                    mileageControl: '',
                                    chasisControl: chasisControl.text,
                                    engineNoController: engineNoController.text,
                                    selectedDate: _newFormatDate(_selectedDate),
                                    selectRenewal:
                                        _newFormatDate(_selectRenewal),
                                    selectThirdParty:
                                        _newFormatDate(_selectThirdParty),
                                    selectTinted: _newFormatDate(_selectTinted),
                                    //  thirdPartyControl: '',
                                    //  vehicleLicense: '',
                                  ),
                                ),
                              ),
                            );
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
                        text: 'Finish',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FinishcarPage extends StatefulHookConsumerWidget {
  const FinishcarPage({
    super.key,
    required this.plateController,
    required this.mileageControl,
    required this.chasisControl,
    required this.engineNoController,
    required this.imagePath,
    required this.carName,
    required this.petrol,
    required this.gearbox,
    required this.selectedDate,
    required this.selectRenewal,
    required this.selectThirdParty,
    required this.selectTinted,
    required this.purchaseDate,
    required this.model,
    // required this.vehicleLicense
  });
  final String imagePath,
      purchaseDate,
      petrol,
      gearbox,
      carName,
      model,
      plateController,
      mileageControl,
      chasisControl,
      engineNoController;
  // vehicleLicense;
  final String selectedDate, selectRenewal, selectThirdParty, selectTinted;

  @override
  ConsumerState<FinishcarPage> createState() => _FinishcarPageState();
}

class _FinishcarPageState extends ConsumerState<FinishcarPage> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime endOfYear = DateTime(now.year + 1, 1, 1);
    int remainingDays = endOfYear.difference(now).inDays;
    final state = ref.watch(profileProvider);
    final model = ref.read(profileProvider.notifier);
    return Scaffold(
      backgroundColor: const Color(0xff001A1F),
      body: SingleChildScrollView(
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
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),

              const Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15),
                child: Text(
                  "This is all the information we got from you",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "NeulisAlt",
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppColors.white,
                  ),
                ),
              ),

              //
              //image
              Padding(
                padding: const EdgeInsets.only(
                    top: 15.0, left: 30, right: 30, bottom: 15),
                child: Container(
                  // height: 200,
                  // width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Image.asset(widget.imagePath),
                ),
              ),

              //car model and plate number
              Column(
                children: [
                  Text(
                    '${widget.carName} ${widget.model}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "NeulisAlt",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),

                  //

                  const SizedBox(height: 8),

                  //plate no
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.plateController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: "NeulisAlt",
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color(0xff7AE6EB),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 4, bottom: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xff00343f),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Text(
                          "exp. $remainingDays days",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: "NeulisAlt",
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Color(0xff92BEC1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 60, right: 60),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xffF8E761),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "moticarID :",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "NeulisAlt",
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Color(0xff002D36),
                          ),
                        ),
                        Text(
                          "THIFNJ34349",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "NeulisAlt",
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Color(0xff002D36),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Add your terms and conditions content here
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15.0),
                  child: Text(
                    "${widget.petrol}.${widget.gearbox}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "NeulisAlt",
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Color(0xffF8F6E7),
                    ),
                  ),
                ),
              ),

              Center(
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Text(
                    "Date of Purchase: ${widget.purchaseDate}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "NeulisAlt",
                      fontWeight: FontWeight.w300,
                      fontSize: 13,
                      color: Color(0xffC1C3C3),
                    ),
                  ),
                ),
              ),

              //car details
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 4, bottom: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xff00343f),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Row(
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
                        "Car Details",
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
              ),

              //listTile of car details
              Column(
                children: [
                  ListTile(
                    title: const Text(
                      "Chasis Number",
                      style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                          letterSpacing: 1.5,
                          fontSize: 12),
                    ),
                    trailing: Text(
                      widget.chasisControl,
                      style: const TextStyle(
                          fontFamily: "NeulisAlt",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                          letterSpacing: 1.5,
                          fontSize: 12),
                    ),
                  ),

                  //
                  ListTile(
                    title: const Text(
                      "Engine Number",
                      style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                          letterSpacing: 1.5,
                          fontSize: 12),
                    ),
                    trailing: Text(
                      widget.engineNoController,
                      style: const TextStyle(
                          fontFamily: "NeulisAlt",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                          letterSpacing: 1.5,
                          fontSize: 12),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 8,
              ),

              //
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 4, bottom: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xff00343f),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Row(
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
                        "Car Papers - Expiry Dates",
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
              ),

              //
              //listTile of car details
              Column(
                children: [
                  ListTile(
                    title: const Text(
                      "Date of Purchase",
                      style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                          letterSpacing: 1.5,
                          fontSize: 12),
                    ),
                    trailing: Text(
                      widget.selectedDate,
                      style: const TextStyle(
                          fontFamily: "NeulisAlt",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                          letterSpacing: 1.5,
                          fontSize: 12),
                    ),
                  ),

                  //
                  ListTile(
                    title: const Text(
                      "Vehicle License",
                      style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                          letterSpacing: 1.5,
                          fontSize: 12),
                    ),
                    trailing: Text(
                      widget.selectRenewal,
                      style: const TextStyle(
                          fontFamily: "NeulisAlt",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                          letterSpacing: 1.5,
                          fontSize: 12),
                    ),
                  ),

                  //
                  ListTile(
                    title: const Text(
                      "Third Party Insurance",
                      style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                          letterSpacing: 1.5,
                          fontSize: 12),
                    ),
                    trailing: Text(
                      widget.selectThirdParty,
                      style: const TextStyle(
                          fontFamily: "NeulisAlt",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                          letterSpacing: 1.5,
                          fontSize: 12),
                    ),
                  ),

                  //tinted

                  ListTile(
                    title: const Text(
                      "Tinted Permit",
                      style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                          letterSpacing: 1.5,
                          fontSize: 12),
                    ),
                    trailing: Text(
                      widget.selectTinted,
                      style: const TextStyle(
                          fontFamily: "NeulisAlt",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                          letterSpacing: 1.5,
                          fontSize: 12),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              //   // Expanded(
              //   child: MoticarLoginButton(
              //     myColor: Colors.transparent,
              //     borderColor: const Color(0xff00AEB5),
              //     onTap: () async {
              //       Navigator.pop(context);
              //     },
              //     child: const MoticarText(
              //       fontColor: Color(0xff00AEB5),
              //       text: 'Cancel',
              //       fontSize: 16,
              //       fontWeight: FontWeight.w700,
              //     ),
              //   ),
              // ),

              const SizedBox(width: 8),

              //
              MoticarLoginButton(
                myColor: const Color(0xff29d7de),
                borderColor: const Color(0xff29d7de),
                onTap: () async {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return const BottomHomePage();
                  // }));
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
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );

                  await Future.delayed(const Duration(seconds: 4));

                  Navigator.pop(context);

                  showMoticarBottom(
                      context: context,
                      child: const FractionallySizedBox(
                        heightFactor: 0.90,
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                            child: FirstKnow()),
                      ));
                },
                child: const MoticarText(
                  fontColor: AppColors.appThemeColor,
                  text: 'Looks good!',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

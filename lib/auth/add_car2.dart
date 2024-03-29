import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moticar/auth/add_car3.dart';
import 'package:moticar/utils/validator.dart';
import 'package:moticar/widgets/page_indicator.dart';

import '../../providers/app_providers.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import 'car_list_all.dart';

class AddCarPage2 extends StatefulHookConsumerWidget {
  const AddCarPage2({
    super.key,
    required this.imagePath,
    required this.carName,
  });
  final String imagePath, carName;

  @override
  ConsumerState<AddCarPage2> createState() => _AddCarPage2State();
}

class _AddCarPage2State extends ConsumerState<AddCarPage2> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final carController = TextEditingController();

  String? popular;
  bool isClicked = false;

  bool isVisible = false;
  bool isVisible2 = false;
  bool isVisible3 = false;

  //
  String selectedModel = '';
  String selectedCarName = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    carController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    final model = ref.read(profileProvider.notifier);
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
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back_ios_new_rounded,
        //     size: 20,
        //     color: Colors.white,
        //   ),
        // ),
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
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            PageIndicator(
                                currentPage: 2,
                                indicatorColor: AppColors.indieC,
                                inactiveIndicatorColor: Color(0xffD7E2E4),
                                totalPages: 4),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        //
                        Container(
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(20),
                              color: Colors.white,
                              border: Border.all(
                                  color: AppColors.lightGreen, width: 1.5)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 8,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(widget.imagePath),
                                const SizedBox(height: 8),
                                Text(
                                  widget.carName,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontFamily: "NeulisAlt",
                                      fontSize: 18,
                                      fontStyle: FontStyle.normal,
                                      height: 1.2,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.appThemeColor),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        const Center(
                          child: Text(
                            "Select model",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontSize: 18,
                                fontStyle: FontStyle.normal,
                                height: 1.2,
                                fontWeight: FontWeight.w700,
                                color: AppColors.appThemeColor),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: carController,
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
                                validator: (value) =>
                                    FieldValidaor.validateEmptyfield(value!),
                                onSaved: (value) {
                                  // email = value!;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: AppColors.red, width: 1.5),
                                  ),
                                  hintText: 'Search model name',

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
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xffC1C3C3),
                                      letterSpacing: 1.2,
                                      fontSize: 14),

                                  suffixIcon: const Icon(
                                    Icons.search_sharp,
                                    color: Color(0xffC1C3C3),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "SUV",
                                style: TextStyle(
                                  fontFamily: "NeulisAlt",
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff202A2A),
                                  letterSpacing: 1.5,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),

                              //showDialog here
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: Colors
                                            .transparent, // Make the background transparent
                                        contentPadding: EdgeInsets
                                            .zero, // Remove any default padding
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                        content: ClipRRect(
                                          // Clip content to match the dialog's shape
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                          child: Container(
                                            color: Colors.white,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                      icon: const Icon(Icons
                                                          .close), // Close icon
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(); // Close the dialog
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Image.asset(
                                                    'assets/images/car_diagram.png'),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15,
                                                          bottom: 15,
                                                          left: 8,
                                                          right: 8),
                                                  color:
                                                      const Color(0xffece6b7),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8),
                                                    child: Text(
                                                      "A SUV is a type of car that sits high off the ground and which often has four-wheel drive and rugged styling",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: "NeulisAlt",
                                                        fontSize: 14,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        height: 1.2,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColors
                                                            .appThemeColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    context: context,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  // height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: AppColors.lightGreen),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Icon(Icons.question_mark_rounded,
                                      size: 13, color: AppColors.lightGreen),
                                ),
                              ),

                              //
                              const SizedBox(
                                width: 8,
                              ),
                              const Expanded(
                                child: Divider(
                                  thickness: 1.5,
                                  color: AppColors.divider,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                child: isVisible
                                    ? const Icon(
                                        Icons.keyboard_arrow_up_rounded,
                                        color: AppColors.textGrey)
                                    : const Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        color: AppColors.textGrey),
                              ),
                            ],
                          ),
                        ),

                        //suvs cars
                        Visibility(
                          visible: isVisible,
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: popular == 'yaris'
                                        ? AppColors.lightGreen
                                        : const Color(0xfff0f5f5),
                                    width: 1,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black45, blurRadius: 0.1),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    popular == 'yaris'
                                        ? const MoticarText(
                                            text: 'Yaris Cross',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontColor: AppColors.green,
                                          )
                                        : const MoticarText(
                                            text: 'Yaris Cross',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontColor: Color(0xff495353),
                                          ),
                                    Radio(
                                      toggleable: true,
                                      value: 'yaris',
                                      activeColor: AppColors.lightGreen,
                                      groupValue: popular,
                                      onChanged: (value) {
                                        setState(() {
                                          popular = value.toString();
                                          selectedModel = 'Yaris Cross [SUV]';
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //kia
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: popular == 'corolla'
                                        ? AppColors.lightGreen
                                        : const Color(0xfff0f5f5),
                                    width: 1,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black45, blurRadius: 0.1),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    popular == 'corolla'
                                        ? const MoticarText(
                                            text: 'Corolla Cross',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontColor: AppColors.green,
                                          )
                                        : const MoticarText(
                                            text: 'Corolla Cross',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontColor: Color(0xff495353),
                                          ),
                                    Radio(
                                      toggleable: true,
                                      value: 'corolla',
                                      activeColor: AppColors.lightGreen,
                                      groupValue: popular,
                                      onChanged: (value) {
                                        setState(() {
                                          popular = value.toString();
                                          selectedModel = 'Corolla Cross [SUV]';
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //
                            // benzo
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: popular == 'sequioa'
                                        ? AppColors.lightGreen
                                        : const Color(0xfff0f5f5),
                                    width: 1,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black45, blurRadius: 0.1),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    popular == 'sequioa'
                                        ? const MoticarText(
                                            text: 'Sequioa',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontColor: AppColors.green,
                                          )
                                        : const MoticarText(
                                            text: 'Sequioa',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontColor: Color(0xff495353),
                                          ),
                                    Radio(
                                      toggleable: true,
                                      value: 'sequioa',
                                      activeColor: AppColors.lightGreen,
                                      groupValue: popular,
                                      onChanged: (value) {
                                        setState(() {
                                          popular = value.toString();
                                          selectedModel = 'Sequioa [SUV]';
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //C-HR
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: popular == 'c-hr'
                                        ? AppColors.lightGreen
                                        : const Color(0xfff0f5f5),
                                    width: 1,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black45, blurRadius: 0.1),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    popular == 'c-hr'
                                        ? const MoticarText(
                                            text: 'C-HR',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontColor: AppColors.green,
                                          )
                                        : const MoticarText(
                                            text: 'C-HR',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontColor: Color(0xff495353),
                                          ),
                                    Radio(
                                      toggleable: true,
                                      value: 'c-hr',
                                      activeColor: AppColors.lightGreen,
                                      groupValue: popular,
                                      onChanged: (value) {
                                        setState(() {
                                          popular = value.toString();
                                          selectedModel = 'C-HR [SUV]';
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),

                        //
                        //hatchback
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Hatchback",
                                style: TextStyle(
                                  fontFamily: "NeulisAlt",
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff202A2A),
                                  letterSpacing: 1.5,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),

                              //showDialog here
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: Colors
                                            .transparent, // Make the background transparent
                                        contentPadding: EdgeInsets
                                            .zero, // Remove any default padding
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                        content: ClipRRect(
                                          // Clip content to match the dialog's shape
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                          child: Container(
                                            color: Colors.white,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                      icon: const Icon(Icons
                                                          .close), // Close icon
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(); // Close the dialog
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Image.asset(
                                                    'assets/images/car_diagram.png'),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15,
                                                          bottom: 15,
                                                          left: 8,
                                                          right: 8),
                                                  color:
                                                      const Color(0xffece6b7),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8),
                                                    child: Text(
                                                      "A Hatchback is a type of car which often has four-wheel drive and rugged styling",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: "NeulisAlt",
                                                        fontSize: 14,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        height: 1.2,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColors
                                                            .appThemeColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    context: context,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  // height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: AppColors.lightGreen),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Icon(Icons.question_mark_rounded,
                                      size: 13, color: AppColors.lightGreen),
                                ),
                              ),

                              //
                              const SizedBox(
                                width: 8,
                              ),
                              const Expanded(
                                child: Divider(
                                  thickness: 1.5,
                                  color: AppColors.divider,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isVisible2 = !isVisible2;
                                  });
                                },
                                child: isVisible2
                                    ? const Icon(
                                        Icons.keyboard_arrow_up_rounded,
                                        color: AppColors.textGrey)
                                    : const Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        color: AppColors.textGrey),
                              ),
                            ],
                          ),
                        ),

                        //visible hatchbck
                        Visibility(
                          visible: isVisible2,
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: popular == 'toyota'
                                        ? AppColors.lightGreen
                                        : const Color(0xfff0f5f5),
                                    width: 1,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black45, blurRadius: 0.1),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    popular == 'toyota'
                                        ? const MoticarText(
                                            text: 'Toyota Prius-Prime',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontColor: AppColors.green,
                                          )
                                        : const MoticarText(
                                            text: 'Toyota Prius-Prime',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontColor: Color(0xff495353),
                                          ),
                                    Radio(
                                      toggleable: true,
                                      value: 'toyota',
                                      activeColor: AppColors.lightGreen,
                                      groupValue: popular,
                                      onChanged: (value) {
                                        setState(() {
                                          popular = value.toString();
                                          selectedModel =
                                              'Toyota Prius-Prime [Hatchback]';
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //kia
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: popular == 'ford'
                                        ? AppColors.lightGreen
                                        : const Color(0xfff0f5f5),
                                    width: 1,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black45, blurRadius: 0.1),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    popular == 'ford'
                                        ? const MoticarText(
                                            text: 'Ford Fiesta',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontColor: AppColors.green,
                                          )
                                        : const MoticarText(
                                            text: 'Ford Fiesta',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontColor: Color(0xff495353),
                                          ),
                                    Radio(
                                      toggleable: true,
                                      value: 'ford',
                                      activeColor: AppColors.lightGreen,
                                      groupValue: popular,
                                      onChanged: (value) {
                                        setState(() {
                                          popular = value.toString();
                                          selectedModel =
                                              'Ford Fiesta [Hatchback]';
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //
                            // benzo
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: popular == 'mitsu'
                                        ? AppColors.lightGreen
                                        : const Color(0xfff0f5f5),
                                    width: 1,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black45, blurRadius: 0.1),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    popular == 'mitsu'
                                        ? const MoticarText(
                                            text: 'Mitsubishi Mirage',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontColor: AppColors.green,
                                          )
                                        : const MoticarText(
                                            text: 'Mitsubishi Mirage',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontColor: Color(0xff495353),
                                          ),
                                    Radio(
                                      toggleable: true,
                                      value: 'mitsu',
                                      activeColor: AppColors.lightGreen,
                                      groupValue: popular,
                                      onChanged: (value) {
                                        setState(() {
                                          popular = value.toString();
                                          selectedModel =
                                              'Mitsubishi Mirage [Hatchback]';
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),

                        //sedans
                        //hatchback
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Sedan",
                                style: TextStyle(
                                  fontFamily: "NeulisAlt",
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff202A2A),
                                  letterSpacing: 1.5,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),

                              //showDialog here
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: Colors
                                            .transparent, // Make the background transparent
                                        contentPadding: EdgeInsets
                                            .zero, // Remove any default padding
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                        content: ClipRRect(
                                          // Clip content to match the dialog's shape
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                          child: Container(
                                            color: Colors.white,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                      icon: const Icon(Icons
                                                          .close), // Close icon
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(); // Close the dialog
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Image.asset(
                                                    'assets/images/car_diagram.png'),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15,
                                                          bottom: 15,
                                                          left: 8,
                                                          right: 8),
                                                  color:
                                                      const Color(0xffece6b7),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8),
                                                    child: Text(
                                                      "A sedan is a passenger car with four doors and a separate trunk for cargo",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: "NeulisAlt",
                                                        fontSize: 14,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        height: 1.2,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColors
                                                            .appThemeColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    context: context,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  // height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: AppColors.lightGreen),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Icon(Icons.question_mark_rounded,
                                      size: 13, color: AppColors.lightGreen),
                                ),
                              ),

                              //
                              const SizedBox(
                                width: 8,
                              ),
                              const Expanded(
                                child: Divider(
                                  thickness: 1.5,
                                  color: AppColors.divider,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isVisible3 = !isVisible3;
                                  });
                                },
                                child: isVisible3
                                    ? const Icon(
                                        Icons.keyboard_arrow_up_rounded,
                                        color: AppColors.textGrey)
                                    : const Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        color: AppColors.textGrey),
                              ),
                            ],
                          ),
                        ),

                        //visible sedan
                        Visibility(
                          visible: isVisible3,
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: popular == 'camry'
                                        ? AppColors.lightGreen
                                        : const Color(0xfff0f5f5),
                                    width: 1,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black45, blurRadius: 0.1),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    popular == 'camry'
                                        ? const MoticarText(
                                            text: 'Camry',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontColor: AppColors.green,
                                          )
                                        : const MoticarText(
                                            text: 'Camry',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontColor: Color(0xff495353),
                                          ),
                                    Radio(
                                      toggleable: true,
                                      value: 'camry',
                                      activeColor: AppColors.lightGreen,
                                      groupValue: popular,
                                      onChanged: (value) {
                                        setState(() {
                                          popular = value.toString();
                                          selectedModel = 'Camry [Sedan]';
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //kia
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: popular == 'cor sedan'
                                        ? AppColors.lightGreen
                                        : const Color(0xfff0f5f5),
                                    width: 1,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black45, blurRadius: 0.1),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    popular == 'cor sedan'
                                        ? const MoticarText(
                                            text: 'Corolla Sedan',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontColor: AppColors.green,
                                          )
                                        : const MoticarText(
                                            text: 'Corolla Sedan',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontColor: Color(0xff495353),
                                          ),
                                    Radio(
                                      toggleable: true,
                                      value: 'cor sedan',
                                      activeColor: AppColors.lightGreen,
                                      groupValue: popular,
                                      onChanged: (value) {
                                        setState(() {
                                          popular = value.toString();
                                          selectedModel =
                                              'Corolla Sedan [Sedan]';
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //
                            // Avalon
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: popular == 'avalon'
                                        ? AppColors.lightGreen
                                        : const Color(0xfff0f5f5),
                                    width: 1,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black45, blurRadius: 0.1),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    popular == 'avalon'
                                        ? const MoticarText(
                                            text: 'Avalon',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontColor: AppColors.green,
                                          )
                                        : const MoticarText(
                                            text: 'Avalon',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontColor: Color(0xff495353),
                                          ),
                                    Radio(
                                      toggleable: true,
                                      value: 'avalon',
                                      activeColor: AppColors.lightGreen,
                                      groupValue: popular,
                                      onChanged: (value) {
                                        setState(() {
                                          popular = value.toString();
                                          selectedModel = 'Avalon [Sedan]';
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //avensis
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: popular == 'aven'
                                        ? AppColors.lightGreen
                                        : const Color(0xfff0f5f5),
                                    width: 1,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black45, blurRadius: 0.1),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    popular == 'aven'
                                        ? const MoticarText(
                                            text: 'Avensis',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontColor: AppColors.green,
                                          )
                                        : const MoticarText(
                                            text: 'Avensis',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontColor: Color(0xff495353),
                                          ),
                                    Radio(
                                      toggleable: true,
                                      value: 'aven',
                                      activeColor: AppColors.lightGreen,
                                      groupValue: popular,
                                      onChanged: (value) {
                                        setState(() {
                                          popular = value.toString();
                                          selectedModel = 'Avensis [Sedan]';
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),

                        const SizedBox(
                          height: 8,
                        ),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //create an account
                  MoticarLoginButton(
                    myColor: AppColors.indieC,
                    borderColor: AppColors.indieC,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AddCarPage3(
                            model: selectedModel,
                            imagePath: widget.imagePath,
                            carName: widget.carName);
                      }));
                    },
                    child: const MoticarText(
                      fontColor: AppColors.appThemeColor,
                      text: 'Continue',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CarStatusBottomSheet extends StatelessWidget {
  final String selectCar;

  CarStatusBottomSheet(this.selectCar);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Car Status: $selectCar",
                style: const TextStyle(
                  fontFamily: "NeulisAlt",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              // Add additional content here
            ],
          ),
        ),
      ),
    );
  }
}

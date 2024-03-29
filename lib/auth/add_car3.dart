import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moticar/auth/add_car4.dart';
import 'package:moticar/utils/validator.dart';
import 'package:moticar/widgets/page_indicator.dart';

import '../../providers/app_providers.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import 'car_list_all.dart';

class AddCarPage3 extends StatefulHookConsumerWidget {
  const AddCarPage3(
      {super.key,
      required this.imagePath,
      required this.carName,
      required this.model});
  final String imagePath, carName, model;

  @override
  ConsumerState<AddCarPage3> createState() => _AddCarPage3State();
}

class _AddCarPage3State extends ConsumerState<AddCarPage3> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final carController = TextEditingController();

  String? popular;
  String? gear;
  bool isClicked = false;

  bool isVisible = false;
  bool isVisible2 = false;

  bool isVisible3 = false;

  String selectedPetrol = '';
  String selectedGearBox = '';

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
                                currentPage: 3,
                                indicatorColor: AppColors.indieC,
                                inactiveIndicatorColor: Color(0xffD7E2E4),
                                totalPages: 4),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        //
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 116,
                            // padding: const EdgeInsets.all(8),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(widget.imagePath),
                                  // const SizedBox(height: 4),
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
                                  const SizedBox(height: 8),
                                  Container(
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: AppColors.lightGreen,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                    ),
                                    child: Text(
                                      widget.model,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontFamily: "NeulisAlt",
                                          fontSize: 13,
                                          fontStyle: FontStyle.normal,
                                          height: 1.2,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        const Center(
                          child: Text(
                            "Select Engine",
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

                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Petrol/Fuel",
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
                                                      vertical: 8,
                                                    ),
                                                    child: Text(
                                                      "2.0L 6MT FWD (175 HP)",
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

                        //2.0L 6MT FWD (175 HP)
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
                                    color: popular == '2.0L 6MT FWD (175 HP)'
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
                                    popular == '2.0L 6MT FWD (175 HP)'
                                        ? const MoticarText(
                                            text: '2.0L 6MT FWD (175 HP)',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontColor: AppColors.green,
                                          )
                                        : const MoticarText(
                                            text: '2.0L 6MT FWD (175 HP)',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontColor: Color(0xff495353),
                                          ),
                                    Radio(
                                      toggleable: true,
                                      value: '2.0L 6MT FWD (175 HP)',
                                      activeColor: AppColors.lightGreen,
                                      groupValue: popular,
                                      onChanged: (value) {
                                        setState(() {
                                          popular = value.toString();
                                          selectedPetrol =
                                              'Petrol [2.0L 6MT FWD (175 HP)]';
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //TRD 2.5L 8AT (203 HP)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: popular == 'TRD 2.5L 8AT (203 HP)'
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
                                    popular == 'TRD 2.5L 8AT (203 HP)'
                                        ? const MoticarText(
                                            text: 'TRD 2.5L 8AT (203 HP)',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontColor: AppColors.green,
                                          )
                                        : const MoticarText(
                                            text: 'TRD 2.5L 8AT (203 HP)',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontColor: Color(0xff495353),
                                          ),
                                    Radio(
                                      toggleable: true,
                                      value: 'TRD 2.5L 8AT (203 HP)',
                                      activeColor: AppColors.lightGreen,
                                      groupValue: popular,
                                      onChanged: (value) {
                                        setState(() {
                                          popular = value.toString();
                                          selectedPetrol =
                                              'Petrol [TRD 2.5L 8AT (203 HP)]';
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
                        //GearBox
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Gearbox",
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
                                                      "Gear Box",
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

                        //visible gearbox
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
                                    color: gear == 'Planetary Gear System'
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
                                    gear == 'Planetary Gear System'
                                        ? const MoticarText(
                                            text: 'Planetary Gear System',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontColor: AppColors.green,
                                          )
                                        : const MoticarText(
                                            text: 'Planetary Gear System',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontColor: Color(0xff495353),
                                          ),
                                    Radio(
                                      toggleable: true,
                                      value: 'Planetary Gear System',
                                      activeColor: AppColors.lightGreen,
                                      groupValue: gear,
                                      onChanged: (value) {
                                        setState(() {
                                          gear = value.toString();
                                          selectedGearBox =
                                              'Planetary Gear System';
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //8-Speed
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: gear == '8-Speed'
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
                                    gear == '8-Speed'
                                        ? const MoticarText(
                                            text: '8-Speed',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontColor: AppColors.green,
                                          )
                                        : const MoticarText(
                                            text: '8-Speed',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontColor: Color(0xff495353),
                                          ),
                                    Row(
                                      children: [
                                        const MoticarText(
                                          text: 'Automatic',
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          fontColor: AppColors.lightGreen,
                                        ),
                                        Radio(
                                          toggleable: true,
                                          value: '8-Speed',
                                          activeColor: AppColors.lightGreen,
                                          groupValue: gear,
                                          onChanged: (value) {
                                            setState(() {
                                              gear = value.toString();
                                              selectedGearBox =
                                                  '8-Speed Automatic';
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //
                            // 5-Speed
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: gear == '5-Speed'
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
                                    gear == '5-Speed'
                                        ? const MoticarText(
                                            text: '5-Speed',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontColor: AppColors.green,
                                          )
                                        : const MoticarText(
                                            text: '5-Speed',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontColor: Color(0xff495353),
                                          ),
                                    Row(
                                      children: [
                                        const MoticarText(
                                          text: 'Automatic',
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          fontColor: AppColors.lightGreen,
                                        ),
                                        Radio(
                                          toggleable: true,
                                          value: '5-Speed',
                                          activeColor: AppColors.lightGreen,
                                          groupValue: gear,
                                          onChanged: (value) {
                                            setState(() {
                                              gear = value.toString();
                                              selectedGearBox =
                                                  '5-Speed Automatic';
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //6-speed
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: gear == '6-Speed'
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
                                    gear == '6-Speed'
                                        ? const MoticarText(
                                            text: '6-Speed',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontColor: AppColors.green,
                                          )
                                        : const MoticarText(
                                            text: '6-Speed',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontColor: Color(0xff495353),
                                          ),
                                    Row(
                                      children: [
                                        const MoticarText(
                                          text: 'Manual',
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          fontColor: AppColors.lightGreen,
                                        ),
                                        Radio(
                                          toggleable: true,
                                          value: '6-Speed',
                                          activeColor: AppColors.lightGreen,
                                          groupValue: gear,
                                          onChanged: (value) {
                                            setState(() {
                                              gear = value.toString();
                                              selectedGearBox =
                                                  '6-Speed Manual';
                                            });
                                          },
                                        ),
                                      ],
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
                      //showDialog AI Generator
                      _showOTPVerificationPage(context);
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

  //AI GENERATOR
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

                const Text(
                  "Is this what your car look like?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "NeulisAlt",
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: AppColors.appThemeColor,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset("assets/images/car_ai.png"),
                          const Text(
                            "Image generated by AI",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "NeulisAlt",
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: AppColors.textGrey,
                            ),
                          ),
                        ],
                      )),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 45.0, right: 45),
                  child: Container(
                    // height: 50,
                    // width: 80,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xffF8E761),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cached, color: AppColors.lightGreen),
                        SizedBox(width: 8),
                        Text(
                          "Show me another image sample",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "NeulisAlt",
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Color(0xff002D36),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Add your terms and conditions content here
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'The image is just an example. It doesn’t have to be this color, shade or car look alike.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "NeulisAlt",
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: AppColors.textColor,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                Row(
                  children: [
                    // Transform.scale(
                    //   scale: 0.8,
                    //   child: CupertinoSwitch(
                    //     value: isClicked,
                    //     activeColor: AppColors.yellow,
                    //     trackColor: AppColors.appThemeColor,
                    //     thumbColor: AppColors.white,
                    //     onChanged: (value) {
                    //       setState(() {
                    //         isClicked = !isClicked;
                    //       });
                    //     },
                    //   ),
                    // ),

                    Checkbox(
                      activeColor: AppColors.lightGreen,
                      checkColor: Colors.white,
                      value: isClicked,
                      onChanged: (value) {
                        setState(() {
                          isClicked =
                              value ?? false; // Ensure value is not null
                        });
                      },
                    ),

                    const Text(
                      "Yes, this is what my car looks like",
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
                        return AddCarPage4(
                          imagePath: 'assets/images/car_ai.png',
                          carName: widget.carName,
                          petrol: selectedPetrol,
                          gearbox: selectedGearBox,
                          model: widget.model,
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

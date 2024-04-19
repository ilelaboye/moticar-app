// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:moticar/auth/add_car4.dart';
import 'package:moticar/widgets/page_indicator.dart';
import 'package:rive/rive.dart';

import '../../providers/app_providers.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import '../models/newcars_model.dart';
import '../utils/enums.dart';
import '../widgets/bottom_sheet_service.dart';
import '../widgets/eard_dialog.dart';
import '../widgets/eard_loader.dart';

class AddCarPage3 extends StatefulHookConsumerWidget {
  const AddCarPage3(
      {super.key,
      required this.myEngine,
      required this.imagePath,
      required this.carName,
      required this.type,
      required this.mygear,
      required this.carID,
      required this.isHome,
      required this.modelID,
      required this.model});
  final String imagePath, carName, type, model;
  final String carID, modelID;
  final bool isHome;

  final List<Engine> myEngine, mygear;

  @override
  ConsumerState<AddCarPage3> createState() => _AddCarPage3State();
}

class _AddCarPage3State extends ConsumerState<AddCarPage3> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final carController = TextEditingController();

  String? popular;
  String? gear;
  String? selectedYear;
  bool isClicked = false;

  bool isVisible = true;
  bool isVisible2 = true;

  bool isVisible3 = true;

  String selectedPetrol = '';
  String selectedGearBox = '';
  String selectedGearBoxID = '';
  String selectedPetrolID = '';

  List manufactureList = [
    "2012",
    "2013",
    "2014",
    "2015",
    "2016",
    "2017",
    "2018",
    "2019",
    "2020",
    "2021",
    "2022",
    "2023",
    "2024"
  ];

  // String formattedDate = "04 May, 2024";

  // String _reverseFormatDate(String formattedDate) {
  //   // Parse the formatted date string into a DateTime object
  //   DateTime parsedDate = DateFormat('dd MMMM, yyyy').parse(formattedDate);

  //   // Format the DateTime object into the desired format "yyyy-MM-dd"
  //   String reversedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

  //   return reversedDate;
  // }

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
              "You can only do this once",
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
                            // height: 116,
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
                                // bottom: 8,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(height: 4),
                                  getImageWidget(widget.carName.toString()),
                                  // SvgPicture.asset(widget.imagePath),
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
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      color: AppColors.lightGreen,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                    ),
                                    child: Text(
                                      "${widget.model} [${widget.type}]",
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

                        //select year of manufacture

                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8,
                          ),
                          child: SizedBox(
                            height: 55,
                            child: DropdownButtonFormField<String>(
                                isDense: false,
                                isExpanded: true,
                                icon: Icon(Icons.keyboard_arrow_down_rounded),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  hintText: 'Select Year of Manufacture',
                                  hintStyle: TextStyle(
                                      fontFamily: "NeulisAlt",
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xffC1C3C3),
                                      letterSpacing: 1,
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
                                items: manufactureList
                                    .map<DropdownMenuItem<String>>(
                                        (value) => DropdownMenuItem<String>(
                                            value: value.toString(),
                                            child: Text(
                                              value.toString(),
                                              style: const TextStyle(
                                                  fontFamily: "NeulisAlt",
                                                  color: AppColors.textColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14),
                                            )))
                                    .toList(),
                                value: selectedYear,
                                onChanged: (value) {
                                  setState(() {
                                    selectedYear = value!;
                                  });
                                }),
                          ),
                        ),

                        //

                        Visibility(
                          visible: selectedYear != null,
                          child: Column(
                            children: [
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

                              //
                              const SizedBox(
                                height: 20,
                              ),

                              //
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
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                              ),
                                              content: ClipRRect(
                                                // Clip content to match the dialog's shape
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                                child: Container(
                                                  color: Colors.white,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          IconButton(
                                                            icon: const Icon(Icons
                                                                .close), // Close icon
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(); // Close the dialog
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      Image.asset(
                                                          'assets/images/car_diagram.png'),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 15,
                                                                bottom: 15,
                                                                left: 8,
                                                                right: 8),
                                                        color: const Color(
                                                            0xffece6b7),
                                                        child: const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            vertical: 8,
                                                          ),
                                                          child: Text(
                                                            "2.0L 6MT FWD (175 HP)",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "NeulisAlt",
                                                              fontSize: 14,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              height: 1.2,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
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
                                          border: Border.all(
                                              color: AppColors.lightGreen),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: const Icon(
                                            Icons.question_mark_rounded,
                                            size: 13,
                                            color: AppColors.lightGreen),
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

                              //
                              Visibility(
                                visible: isVisible,
                                child: Column(
                                  children: [
                                    if (state.loading != Loader.loading &&
                                        widget.myEngine.isNotEmpty)
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          // physics: const NeverScrollableScrollPhysics(),
                                          itemCount: widget.myEngine.length,
                                          itemBuilder: (context, index) {
                                            final moticar =
                                                widget.myEngine[index];
                                            final categoriez = moticar.name;

                                            // Check if categoriez is not empty and if index is within bounds
                                            if (categoriez.isNotEmpty &&
                                                index < categoriez.length) {
                                              // final carModelz =
                                              //     categoriez[index].models;
                                              // final carname = moticar.name;

                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                      color: popular ==
                                                              categoriez
                                                          ? AppColors.lightGreen
                                                          : const Color(
                                                              0xfff0f5f5),
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
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      popular == categoriez
                                                          ? MoticarText(
                                                              text: categoriez,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontColor:
                                                                  AppColors
                                                                      .green,
                                                            )
                                                          :
                                                          // Text(
                                                          //     categoriez,
                                                          //     style: TextStyle(
                                                          //       fontSize: 14,
                                                          //       fontWeight:
                                                          //           FontWeight.w400,
                                                          //       color:
                                                          //           Color(0xff495353),
                                                          //     ),
                                                          //   ),
                                                          MoticarText(
                                                              text: categoriez,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontColor:
                                                                  const Color(
                                                                      0xff495353),
                                                            ),
                                                      Radio(
                                                        toggleable: true,
                                                        value: categoriez,
                                                        activeColor: AppColors
                                                            .lightGreen,
                                                        groupValue: popular,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            popular = value
                                                                .toString();
                                                            selectedPetrol =
                                                                'Petrol $categoriez';
                                                            selectedPetrolID =
                                                                moticar.id
                                                                    .toString();
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            } else {
                                              // Handle the case where categoriez is empty or index is out of bounds
                                              return const SizedBox.shrink();
                                            }
                                          },
                                        ),
                                      )
                                    else if (state.loading == Loader.loading)
                                      const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          MoticarLoader(
                                            size: 40,
                                          )
                                        ],
                                      )
                                    else
                                      const Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 30),
                                            MoticarText(
                                              text: 'No Engines Available',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              fontColor: AppColors.textColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),

                              //

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
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                              ),
                                              content: ClipRRect(
                                                // Clip content to match the dialog's shape
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                                child: Container(
                                                  color: Colors.white,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          IconButton(
                                                            icon: const Icon(Icons
                                                                .close), // Close icon
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(); // Close the dialog
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      Image.asset(
                                                          'assets/images/car_diagram.png'),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 15,
                                                                bottom: 15,
                                                                left: 8,
                                                                right: 8),
                                                        color: const Color(
                                                            0xffece6b7),
                                                        child: const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 8),
                                                          child: Text(
                                                            "Gear Box",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "NeulisAlt",
                                                              fontSize: 14,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              height: 1.2,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
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
                                          border: Border.all(
                                              color: AppColors.lightGreen),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: const Icon(
                                            Icons.question_mark_rounded,
                                            size: 13,
                                            color: AppColors.lightGreen),
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
                                child: Column(
                                  children: [
                                    if (state.loading != Loader.loading &&
                                        widget.mygear.isNotEmpty)
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          // physics: const NeverScrollableScrollPhysics(),
                                          itemCount: widget.mygear.length,
                                          itemBuilder: (context, index) {
                                            final moticar =
                                                widget.mygear[index];
                                            final categoriez = moticar.name;

                                            // Check if categoriez is not empty and if index is within bounds
                                            if (categoriez.isNotEmpty &&
                                                index < categoriez.length) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                      color: gear == categoriez
                                                          ? AppColors.lightGreen
                                                          : const Color(
                                                              0xfff0f5f5),
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
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      gear == categoriez
                                                          ? MoticarText(
                                                              text: categoriez,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontColor:
                                                                  AppColors
                                                                      .green,
                                                            )
                                                          : MoticarText(
                                                              text: categoriez,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontColor:
                                                                  const Color(
                                                                      0xff495353),
                                                            ),
                                                      Radio(
                                                        toggleable: true,
                                                        value: categoriez,
                                                        activeColor: AppColors
                                                            .lightGreen,
                                                        groupValue: gear,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            gear = value
                                                                .toString();
                                                            selectedGearBox =
                                                                categoriez;
                                                            selectedGearBoxID =
                                                                moticar.id
                                                                    .toString();
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            } else {
                                              // Handle the case where categoriez is empty or index is out of bounds
                                              return const SizedBox.shrink();
                                            }
                                          },
                                        ),
                                      )
                                    else if (state.loading == Loader.loading)
                                      const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          MoticarLoader(
                                            size: 40,
                                          )
                                        ],
                                      )
                                    else
                                      const Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 30),
                                            MoticarText(
                                              text: 'No GearBox Available',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              fontColor: AppColors.textColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),

                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
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
                    onTap: () async {
                      // print(_reverseFormatDate(formattedDate));
                      if (selectedGearBox.isNotEmpty &&
                          selectedPetrol.isNotEmpty) {
                        // _showOTPVerificationPage(context);
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
                                      SizedBox(height: 8),
                                      Text('Processing, please wait.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );

                        await Future.delayed(const Duration(seconds: 2));

                        Navigator.pop(context);

                        showMoticarBottom(
                            context: context,
                            child: FractionallySizedBox(
                              heightFactor: 0.89,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                ),
                                child: ImageAI(
                                  isHome: widget.isHome,
                                  carYear: selectedYear.toString(),
                                  carID: widget.carID,
                                  modelID: widget.modelID,
                                  gearboxID: selectedGearBoxID,
                                  petrolID: selectedPetrolID,
                                  carName: widget.carName,
                                  imagePath: 'assets/images/car_ai.png',
                                  model: widget.model,
                                  type: widget.type,
                                  petrol: selectedPetrol,
                                  gearbox: selectedGearBox,
                                ),
                              ),
                            ));
                      } else {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return MoticarDialog(
                              icon: const Icon(Icons.info_rounded,
                                  color: AppColors.appThemeColor, size: 50),
                              title: '',
                              subtitle:
                                  'Please select your gear type and the petrol type, before proceeding',
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
                      //showDialog AI Generator
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

  Widget getImageWidget(String category) {
    switch (category) {
      case 'Acura':
        return SvgPicture.asset('assets/carLogos/acura.svg');
      case 'Audi':
        return SvgPicture.asset('assets/carLogos/audi.svg');

      case 'Toyota':
        return SvgPicture.asset('assets/carLogos/toyota.svg');

      case 'Balancing':
        return SvgPicture.asset('assets/expenseCatIcons/balancing.svg');

      case 'Car Wash':
        return SvgPicture.asset('assets/expenseCatIcons/carWash.svg');

      case 'Dues':
        return SvgPicture.asset('assets/expenseCatIcons/dues.svg');

      case 'Electronics':
        return SvgPicture.asset('assets/expenseCatIcons/electronics.svg');

      case 'Fuel':
        return SvgPicture.asset('assets/expenseCatIcons/fuel.svg');

      case 'Hydraulics':
        return SvgPicture.asset('assets/expenseCatIcons/hydraulic.svg');

      case 'Keywork':
        return SvgPicture.asset('assets/expenseCatIcons/keywork.svg');

      case 'Mechanical':
        return SvgPicture.asset('assets/expenseCatIcons/mechanicalWork.svg');

      case 'Misc':
        return SvgPicture.asset('assets/expenseCatIcons/misc.svg');

      case 'Parking':
        return SvgPicture.asset('assets/expenseCatIcons/parking.svg');

      case 'Penalty':
        return SvgPicture.asset('assets/expenseCatIcons/penalty.svg');

      case 'Radiator':
        return SvgPicture.asset('assets/expenseCatIcons/radiator.svg');

      case 'Servicing':
        return SvgPicture.asset('assets/expenseCatIcons/servicing.svg');

      case 'Tow':
        return SvgPicture.asset('assets/expenseCatIcons/tow.svg');

      case 'Tyre guage':
        return SvgPicture.asset('assets/expenseCatIcons/tyreGuage.svg');
      // Add more cases for other categories if needed
      default:
        // Return a default image or null if no specific image is available
        return SvgPicture.asset("assets/carLogos/lexus.svg");
    }
  }
}

class ImageAI extends StatefulWidget {
  const ImageAI(
      {super.key,
      required this.isHome,
      required this.imagePath,
      required this.carName,
      required this.petrol,
      required this.gearbox,
      required this.carID,
      required this.modelID,
      required this.carYear,
      required this.gearboxID,
      required this.petrolID,
      required this.type,
      required this.model});
  final bool isHome;
  final String imagePath, carName, carYear, model, type, petrol, gearbox;
  final String carID, modelID, gearboxID, petrolID;

  @override
  State<ImageAI> createState() => _ImageAIState();
}

class _ImageAIState extends State<ImageAI> {
  // String selectedPetrol = '';
  // String selectedGearBox = '';
  // String? popular;
  // String? gear;

  bool isClicked = false;

  bool isVisible = false;
  bool isVisible2 = false;

  bool isVisible3 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.diaColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
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
                        isClicked = value ?? false; // Ensure value is not null
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

                    await Future.delayed(const Duration(milliseconds: 100));

                    Navigator.pop(context);

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AddCarPage4(
                        isHome: widget.isHome,
                        carYear: widget.carYear,
                        carID: widget.carID,
                        gearboxID: widget.gearboxID,
                        imagePath: 'assets/images/car_ai.png',
                        carName: widget.carName,
                        petrol: widget.petrol,
                        gearbox: widget.gearbox,
                        model: widget.model,
                        type: widget.type,
                        modelID: widget.modelID,
                        engineID: widget.petrolID,
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
      ),
    );
  }
}

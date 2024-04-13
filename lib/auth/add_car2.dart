// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moticar/auth/add_car3.dart';
import 'package:moticar/utils/validator.dart';
import 'package:moticar/widgets/page_indicator.dart';
import 'package:rive/rive.dart';

import '../../providers/app_providers.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import '../models/newcars_model.dart';
import '../utils/enums.dart';
import '../widgets/eard_dialog.dart';
import '../widgets/eard_loader.dart';
import 'car_list_all.dart';

class AddCarPage2 extends StatefulHookConsumerWidget {
  const AddCarPage2({
    super.key,
    required this.moticatz,
    required this.carmodelz,
    required this.carName,
    required this.carID,
  });
  final String carName, carID;
  final List<Category> moticatz;
  final List<Model> carmodelz;

  @override
  ConsumerState<AddCarPage2> createState() => _AddCarPage2State();
}

class _AddCarPage2State extends ConsumerState<AddCarPage2> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final carController = TextEditingController();

  String? popular;
  bool isClicked = false;

  bool isVisible = true;
  bool isVisible2 = true;
  bool isVisible3 = true;

  //
  String selectedModel = '';
  String selectedModelID = '';
  String selectedModeltype = '';
  String selectedCarName = '';
  List<Engine> selectedEngine = [];
  List<Engine> selectedGearBox = [];

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   ref.read(profileProvider.notifier).getCars();
    // });
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
    // final List<Category> carmodelz = state.getCategories;
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
                                SvgPicture.asset(widget.carName),
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
                              SizedBox(
                                height: 50,
                                child: TextFormField(
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
                              ),
                            ],
                          ),
                        ),

                        // Column(
                        //   children: [
                        //     if (state.loading != Loader.loading &&
                        //         widget.carmodelz.isNotEmpty)
                        //       SizedBox(
                        //         height:
                        //             MediaQuery.of(context).size.height * 0.25,
                        //         child: ListView.builder(
                        //           shrinkWrap: true,
                        //           itemCount: widget.carmodelz.length,
                        //           itemBuilder: (context, index) {
                        //             final moticar = widget.carmodelz[index];
                        //             final myBox = widget.carmodelz[index].engines;
                        //             final modelz = moticar.name;
                        //             final carname = moticar.name;

                        //             return GestureDetector(
                        //               onTap: () {
                        //                 setState(() {
                        //                   // carmodelz = categoriez;
                        //                   selectedCarName = carname;
                        // selectedEngine = myBox;
                        // selectedGearBox = myBox;
                        //                 });

                        //                 //
                        //                 // print(
                        //                 //     'my $carmodelz $selectedCarName');
                        //               },
                        //               child: Padding(
                        //                 padding: const EdgeInsets.all(8.0),
                        //                 child: Container(
                        //                   padding: const EdgeInsets.all(8),
                        //                   decoration: BoxDecoration(
                        //                     color: Colors.white,
                        //                     borderRadius:
                        //                         BorderRadius.circular(8),
                        //                     border: Border.all(
                        //                       color: popular == moticar.name
                        //                           ? AppColors.lightGreen
                        //                           : const Color(0xfff0f5f5),
                        //                       width: 1,
                        //                     ),
                        //                     boxShadow: const [
                        //                       BoxShadow(
                        //                           color: Colors.black45,
                        //                           blurRadius: 0.1),
                        //                     ],
                        //                   ),
                        //                   child: Row(
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.spaceBetween,
                        //                     children: [
                        //                       popular == modelz
                        //                           ? MoticarText(
                        //                               text: modelz,
                        //                               fontSize: 14,
                        //                               fontWeight:
                        //                                   FontWeight.w700,
                        //                               fontColor:
                        //                                   AppColors.green,
                        //                             )
                        //                           : MoticarText(
                        //                               text: modelz,
                        //                               fontSize: 14,
                        //                               fontWeight:
                        //                                   FontWeight.w400,
                        //                               fontColor: const Color(
                        //                                   0xff495353),
                        //                             ),
                        //                       Radio(
                        //                         toggleable: true,
                        //                         value: modelz,
                        //                         activeColor:
                        //                             AppColors.lightGreen,
                        //                         groupValue: popular,
                        //                         onChanged: (value) {
                        //                           setState(() {
                        //                             popular = value.toString();
                        //                             // moticatz = categoriez;
                        //                             selectedCarName = carname;
                        //                           });
                        //                         },
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ),
                        //             );
                        //           },
                        //         ),
                        //       )
                        //     else if (state.loading == Loader.loading)
                        //       const Column(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           MoticarLoader(
                        //             size: 40,
                        //           )
                        //         ],
                        //       )
                        //     else
                        //       const Center(
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             SizedBox(height: 30),
                        //             MoticarText(
                        //                 text: 'No Cars Available',
                        //                 fontSize: 13,
                        //                 fontWeight: FontWeight.w500,
                        //                 fontColor: AppColors.textColor),
                        //           ],
                        //         ),
                        //       ),
                        //   ],
                        // ),

                        //
                        Column(
                          children: [
                            if (state.loading != Loader.loading &&
                                widget.moticatz.isNotEmpty)
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: widget.moticatz.length,
                                  itemBuilder: (context, index) {
                                    final moticar = widget.moticatz[index];
                                    final myBox =
                                        widget.carmodelz[index].engines;
                                    final modelz = moticar.name;
                                    final carname = moticar.name;

                                    return Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            modelz,
                                            style: const TextStyle(
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
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    content: ClipRRect(
                                                      // Clip content to match the dialog's shape
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
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
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .close), // Close icon
                                                                  onPressed:
                                                                      () {
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
                                                                      bottom:
                                                                          15,
                                                                      left: 8,
                                                                      right: 8),
                                                              color: const Color(
                                                                  0xffece6b7),
                                                              child:
                                                                  const Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            8),
                                                                child: Text(
                                                                  "A SUV is a type of car that sits high off the ground and which often has four-wheel drive and rugged styling",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        "NeulisAlt",
                                                                    fontSize:
                                                                        14,
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
                                                    color:
                                                        AppColors.lightGreen),
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

                                                //set car name and model variable here
                                                selectedCarName =
                                                    widget.carName;
                                                // modelz
                                                selectedModeltype = modelz;
                                              });
                                            },
                                            child: isVisible
                                                ? const Icon(
                                                    Icons
                                                        .keyboard_arrow_up_rounded,
                                                    color: AppColors.textGrey)
                                                : const Icon(
                                                    Icons
                                                        .keyboard_arrow_down_sharp,
                                                    color: AppColors.textGrey),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            else if (state.loading == Loader.loading)
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MoticarLoader(
                                    size: 40,
                                  )
                                ],
                              )
                            else
                              const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 30),
                                    MoticarText(
                                        text: 'No Cars Available',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        fontColor: AppColors.textColor),
                                  ],
                                ),
                              ),
                          ],
                        ),

                        //suvs cars
                        Visibility(
                          visible: isVisible,
                          child: Column(
                            children: [
                              if (state.loading != Loader.loading &&
                                  widget.carmodelz.isNotEmpty)
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: widget.carmodelz.length,
                                    itemBuilder: (context, index) {
                                      final moticar = widget.carmodelz[index];
                                      final myBox =
                                          widget.carmodelz[index].engines;
                                      final mygear =
                                          widget.carmodelz[index].gearboxies;

                                      final modelz = moticar.name;
                                      final carname = moticar.name;

                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            // carmodelz = categoriez;
                                            selectedEngine = myBox;
                                            selectedGearBox = mygear;
                                            selectedCarName = widget.carName;
                                            // selectedModel =  ;
                                          });

                                          //
                                          // print(
                                          //     'my $carmodelz $selectedCarName');
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: popular == modelz
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                popular == modelz
                                                    ? MoticarText(
                                                        text: modelz,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontColor:
                                                            AppColors.green,
                                                      )
                                                    : MoticarText(
                                                        text: modelz,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontColor: const Color(
                                                            0xff495353),
                                                      ),
                                                Radio(
                                                  toggleable: true,
                                                  value: modelz,
                                                  activeColor:
                                                      AppColors.lightGreen,
                                                  groupValue: popular,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      popular =
                                                          value.toString();
                                                      // moticatz = categoriez;
                                                      selectedEngine = myBox;
                                                      selectedGearBox = mygear;
                                                      selectedCarName = modelz;
                                                      selectedModelID =
                                                          moticar.id.toString();
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              else if (state.loading == Loader.loading)
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MoticarLoader(
                                      size: 40,
                                    )
                                  ],
                                )
                              else
                                const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 30),
                                      MoticarText(
                                          text: 'No Cars Available',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          fontColor: AppColors.textColor),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),

                        //
                        //hatchback
                        // Padding(
                        //   padding: const EdgeInsets.all(12.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       const Text(
                        //         "Hatchback",
                        //         style: TextStyle(
                        //           fontFamily: "NeulisAlt",
                        //           fontStyle: FontStyle.normal,
                        //           fontWeight: FontWeight.w700,
                        //           color: Color(0xff202A2A),
                        //           letterSpacing: 1.5,
                        //           fontSize: 14,
                        //         ),
                        //       ),
                        //       const SizedBox(
                        //         width: 8,
                        //       ),

                        //       //showDialog here
                        //       GestureDetector(
                        //         onTap: () {
                        //           showDialog(
                        //             builder: (context) {
                        //               return AlertDialog(
                        //                 backgroundColor: Colors
                        //                     .transparent, // Make the background transparent
                        //                 contentPadding: EdgeInsets
                        //                     .zero, // Remove any default padding
                        //                 shape: const RoundedRectangleBorder(
                        //                   borderRadius: BorderRadius.only(
                        //                     bottomLeft: Radius.circular(10),
                        //                     bottomRight: Radius.circular(10),
                        //                   ),
                        //                 ),
                        //                 content: ClipRRect(
                        //                   // Clip content to match the dialog's shape
                        //                   borderRadius: const BorderRadius.only(
                        //                     bottomLeft: Radius.circular(10),
                        //                     bottomRight: Radius.circular(10),
                        //                   ),
                        //                   child: Container(
                        //                     color: Colors.white,
                        //                     child: Column(
                        //                       mainAxisSize: MainAxisSize.min,
                        //                       children: [
                        //                         Row(
                        //                           mainAxisAlignment:
                        //                               MainAxisAlignment.end,
                        //                           children: [
                        //                             IconButton(
                        //                               icon: const Icon(Icons
                        //                                   .close), // Close icon
                        //                               onPressed: () {
                        //                                 Navigator.of(context)
                        //                                     .pop(); // Close the dialog
                        //                               },
                        //                             ),
                        //                           ],
                        //                         ),
                        //                         Image.asset(
                        //                             'assets/images/car_diagram.png'),
                        //                         Container(
                        //                           padding:
                        //                               const EdgeInsets.only(
                        //                                   top: 15,
                        //                                   bottom: 15,
                        //                                   left: 8,
                        //                                   right: 8),
                        //                           color:
                        //                               const Color(0xffece6b7),
                        //                           child: const Padding(
                        //                             padding:
                        //                                 EdgeInsets.symmetric(
                        //                                     vertical: 8),
                        //                             child: Text(
                        //                               "A Hatchback is a type of car which often has four-wheel drive and rugged styling",
                        //                               textAlign:
                        //                                   TextAlign.center,
                        //                               style: TextStyle(
                        //                                 fontFamily: "NeulisAlt",
                        //                                 fontSize: 14,
                        //                                 fontStyle:
                        //                                     FontStyle.normal,
                        //                                 height: 1.2,
                        //                                 fontWeight:
                        //                                     FontWeight.w400,
                        //                                 color: AppColors
                        //                                     .appThemeColor,
                        //                               ),
                        //                             ),
                        //                           ),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 ),
                        //               );
                        //             },
                        //             context: context,
                        //           );
                        //         },
                        //         child: Container(
                        //           padding: const EdgeInsets.all(3),
                        //           // height: 20,
                        //           decoration: BoxDecoration(
                        //             color: Colors.white,
                        //             border:
                        //                 Border.all(color: AppColors.lightGreen),
                        //             borderRadius: BorderRadius.circular(5),
                        //           ),
                        //           child: const Icon(Icons.question_mark_rounded,
                        //               size: 13, color: AppColors.lightGreen),
                        //         ),
                        //       ),

                        //       //
                        //       const SizedBox(
                        //         width: 8,
                        //       ),
                        //       const Expanded(
                        //         child: Divider(
                        //           thickness: 1.5,
                        //           color: AppColors.divider,
                        //         ),
                        //       ),
                        //       const SizedBox(
                        //         width: 8,
                        //       ),
                        //       GestureDetector(
                        //         onTap: () {
                        //           setState(() {
                        //             isVisible2 = !isVisible2;
                        //           });
                        //         },
                        //         child: isVisible2
                        //             ? const Icon(
                        //                 Icons.keyboard_arrow_up_rounded,
                        //                 color: AppColors.textGrey)
                        //             : const Icon(
                        //                 Icons.keyboard_arrow_down_sharp,
                        //                 color: AppColors.textGrey),
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        // //visible hatchbck
                        // Visibility(
                        //   visible: isVisible2,
                        //   child: Column(
                        //     children: [
                        //       if (state.loading != Loader.loading &&
                        //           widget.moticatz.isNotEmpty)
                        //         SizedBox(
                        //           height:
                        //               MediaQuery.of(context).size.height * 0.25,
                        //           child: ListView.builder(
                        //             shrinkWrap: true,
                        //             itemCount: widget.moticatz.length,
                        //             itemBuilder: (context, index) {
                        //               final moticar = widget.moticatz[index];
                        //               final categoriez = moticar.models;
                        //               final carname = moticar.name;

                        //               return GestureDetector(
                        //                 onTap: () {
                        //                   setState(() {
                        //                     // moticatz = categoriez;
                        //                     selectedCarName = carname;
                        //                   });

                        //                   //
                        //                   // print(
                        //                   //     'my $moticatz $selectedCarName');

                        //                   // Navigator.push(context,
                        //                   //     MaterialPageRoute(builder: (context) {
                        //                   //   return PersonalAcctOpenPageOne(
                        //                   //     acctType: moticatz,
                        //                   //     acctCode: selectedCarName,
                        //                   //   );
                        //                   // }));
                        //                 },
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.all(8.0),
                        //                   child: Container(
                        //                     padding: const EdgeInsets.all(8),
                        //                     decoration: BoxDecoration(
                        //                       color: Colors.white,
                        //                       borderRadius:
                        //                           BorderRadius.circular(8),
                        //                       border: Border.all(
                        //                         color: popular == moticar.name
                        //                             ? AppColors.lightGreen
                        //                             : const Color(0xfff0f5f5),
                        //                         width: 1,
                        //                       ),
                        //                       boxShadow: const [
                        //                         BoxShadow(
                        //                             color: Colors.black45,
                        //                             blurRadius: 0.1),
                        //                       ],
                        //                     ),
                        //                     child: Row(
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment
                        //                               .spaceBetween,
                        //                       children: [
                        //                         popular == moticar.name
                        //                             ? MoticarText(
                        //                                 text: moticar.name,
                        //                                 fontSize: 14,
                        //                                 fontWeight:
                        //                                     FontWeight.w700,
                        //                                 fontColor:
                        //                                     AppColors.green,
                        //                               )
                        //                             : MoticarText(
                        //                                 text: moticar.name,
                        //                                 fontSize: 14,
                        //                                 fontWeight:
                        //                                     FontWeight.w400,
                        //                                 fontColor: const Color(
                        //                                     0xff495353),
                        //                               ),

                        //                         //
                        //                         Radio(
                        //                           toggleable: true,
                        //                           value: moticar.name,
                        //                           activeColor:
                        //                               AppColors.lightGreen,
                        //                           groupValue: popular,
                        //                           onChanged: (value) {
                        //                             setState(() {
                        //                               popular =
                        //                                   value.toString();
                        //                               // moticatz = categoriez;
                        //                               selectedCarName = carname;
                        //                             });
                        //                           },
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 ),
                        //               );
                        //             },
                        //           ),
                        //         )
                        //       else if (state.loading == Loader.loading)
                        //         const Column(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             MoticarLoader(
                        //               size: 40,
                        //             )
                        //           ],
                        //         )
                        //       else
                        //         const Center(
                        //           child: Column(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               SizedBox(height: 30),
                        //               MoticarText(
                        //                   text: 'No Cars Available',
                        //                   fontSize: 13,
                        //                   fontWeight: FontWeight.w500,
                        //                   fontColor: AppColors.textColor),
                        //             ],
                        //           ),
                        //         ),
                        //     ],
                        //   ),
                        // ),

                        // //sedans
                        // //hatchback
                        // Padding(
                        //   padding: const EdgeInsets.all(12.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       const Text(
                        //         "Sedan",
                        //         style: TextStyle(
                        //           fontFamily: "NeulisAlt",
                        //           fontStyle: FontStyle.normal,
                        //           fontWeight: FontWeight.w700,
                        //           color: Color(0xff202A2A),
                        //           letterSpacing: 1.5,
                        //           fontSize: 14,
                        //         ),
                        //       ),
                        //       const SizedBox(
                        //         width: 8,
                        //       ),

                        //       //showDialog here
                        //       GestureDetector(
                        //         onTap: () {
                        //           showDialog(
                        //             builder: (context) {
                        //               return AlertDialog(
                        //                 backgroundColor: Colors
                        //                     .transparent, // Make the background transparent
                        //                 contentPadding: EdgeInsets
                        //                     .zero, // Remove any default padding
                        //                 shape: const RoundedRectangleBorder(
                        //                   borderRadius: BorderRadius.only(
                        //                     bottomLeft: Radius.circular(10),
                        //                     bottomRight: Radius.circular(10),
                        //                   ),
                        //                 ),
                        //                 content: ClipRRect(
                        //                   // Clip content to match the dialog's shape
                        //                   borderRadius: const BorderRadius.only(
                        //                     bottomLeft: Radius.circular(10),
                        //                     bottomRight: Radius.circular(10),
                        //                   ),
                        //                   child: Container(
                        //                     color: Colors.white,
                        //                     child: Column(
                        //                       mainAxisSize: MainAxisSize.min,
                        //                       children: [
                        //                         Row(
                        //                           mainAxisAlignment:
                        //                               MainAxisAlignment.end,
                        //                           children: [
                        //                             IconButton(
                        //                               icon: const Icon(Icons
                        //                                   .close), // Close icon
                        //                               onPressed: () {
                        //                                 Navigator.of(context)
                        //                                     .pop(); // Close the dialog
                        //                               },
                        //                             ),
                        //                           ],
                        //                         ),
                        //                         Image.asset(
                        //                             'assets/images/car_diagram.png'),
                        //                         Container(
                        //                           padding:
                        //                               const EdgeInsets.only(
                        //                                   top: 15,
                        //                                   bottom: 15,
                        //                                   left: 8,
                        //                                   right: 8),
                        //                           color:
                        //                               const Color(0xffece6b7),
                        //                           child: const Padding(
                        //                             padding:
                        //                                 EdgeInsets.symmetric(
                        //                                     vertical: 8),
                        //                             child: Text(
                        //                               "A sedan is a passenger car with four doors and a separate trunk for cargo",
                        //                               textAlign:
                        //                                   TextAlign.center,
                        //                               style: TextStyle(
                        //                                 fontFamily: "NeulisAlt",
                        //                                 fontSize: 14,
                        //                                 fontStyle:
                        //                                     FontStyle.normal,
                        //                                 height: 1.2,
                        //                                 fontWeight:
                        //                                     FontWeight.w400,
                        //                                 color: AppColors
                        //                                     .appThemeColor,
                        //                               ),
                        //                             ),
                        //                           ),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 ),
                        //               );
                        //             },
                        //             context: context,
                        //           );
                        //         },
                        //         child: Container(
                        //           padding: const EdgeInsets.all(3),
                        //           // height: 20,
                        //           decoration: BoxDecoration(
                        //             color: Colors.white,
                        //             border:
                        //                 Border.all(color: AppColors.lightGreen),
                        //             borderRadius: BorderRadius.circular(5),
                        //           ),
                        //           child: const Icon(Icons.question_mark_rounded,
                        //               size: 13, color: AppColors.lightGreen),
                        //         ),
                        //       ),

                        //       //
                        //       const SizedBox(
                        //         width: 8,
                        //       ),
                        //       const Expanded(
                        //         child: Divider(
                        //           thickness: 1.5,
                        //           color: AppColors.divider,
                        //         ),
                        //       ),
                        //       const SizedBox(
                        //         width: 8,
                        //       ),
                        //       GestureDetector(
                        //         onTap: () {
                        //           setState(() {
                        //             isVisible3 = !isVisible3;
                        //           });
                        //         },
                        //         child: isVisible3
                        //             ? const Icon(
                        //                 Icons.keyboard_arrow_up_rounded,
                        //                 color: AppColors.textGrey)
                        //             : const Icon(
                        //                 Icons.keyboard_arrow_down_sharp,
                        //                 color: AppColors.textGrey),
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        // //visible sedan
                        // Visibility(
                        //   visible: isVisible3,
                        //   child: Column(
                        //     children: [
                        //       if (state.loading != Loader.loading &&
                        //           widget.moticatz.isNotEmpty)
                        //         SizedBox(
                        //           height:
                        //               MediaQuery.of(context).size.height * 0.25,
                        //           child: ListView.builder(
                        //             shrinkWrap: true,
                        //             itemCount: widget.moticatz.length,
                        //             itemBuilder: (context, index) {
                        //               final moticar = widget.moticatz[index];
                        //               final categoriez = moticar.models;
                        //               final carname = moticar.name;

                        //               return GestureDetector(
                        //                 onTap: () {
                        //                   setState(() {
                        //                     // moticatz = categoriez;
                        //                     selectedCarName = carname;
                        //                   });

                        //                   //
                        //                   // print(
                        //                   //     'my $moticatz $selectedCarName');
                        //                 },
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.all(8.0),
                        //                   child: Container(
                        //                     padding: const EdgeInsets.all(8),
                        //                     decoration: BoxDecoration(
                        //                       color: Colors.white,
                        //                       borderRadius:
                        //                           BorderRadius.circular(8),
                        //                       border: Border.all(
                        //                         color: popular == moticar.name
                        //                             ? AppColors.lightGreen
                        //                             : const Color(0xfff0f5f5),
                        //                         width: 1,
                        //                       ),
                        //                       boxShadow: const [
                        //                         BoxShadow(
                        //                             color: Colors.black45,
                        //                             blurRadius: 0.1),
                        //                       ],
                        //                     ),
                        //                     child: Row(
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment
                        //                               .spaceBetween,
                        //                       children: [
                        //                         popular == moticar.name
                        //                             ? MoticarText(
                        //                                 text: moticar.name,
                        //                                 fontSize: 14,
                        //                                 fontWeight:
                        //                                     FontWeight.w700,
                        //                                 fontColor:
                        //                                     AppColors.green,
                        //                               )
                        //                             : MoticarText(
                        //                                 text: moticar.name,
                        //                                 fontSize: 14,
                        //                                 fontWeight:
                        //                                     FontWeight.w400,
                        //                                 fontColor: const Color(
                        //                                     0xff495353),
                        //                               ),
                        //                         Radio(
                        //                           toggleable: true,
                        //                           value: moticar.name,
                        //                           activeColor:
                        //                               AppColors.lightGreen,
                        //                           groupValue: popular,
                        //                           onChanged: (value) {
                        //                             setState(() {
                        //                               popular =
                        //                                   value.toString();
                        //                               // moticatz = categoriez;
                        //                               selectedCarName = carname;
                        //                             });
                        //                           },
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 ),
                        //               );
                        //             },
                        //           ),
                        //         )
                        //       else if (state.loading == Loader.loading)
                        //         const Column(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             MoticarLoader(
                        //               size: 40,
                        //             )
                        //           ],
                        //         )
                        //       else
                        //         const Center(
                        //           child: Column(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               SizedBox(height: 30),
                        //               MoticarText(
                        //                   text: 'No Cars Available',
                        //                   fontSize: 13,
                        //                   fontWeight: FontWeight.w500,
                        //                   fontColor: AppColors.textColor),
                        //             ],
                        //           ),
                        //         ),
                        //     ],
                        //   ),
                        // ),

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
                    onTap: () async {
                      // if (selectedModel.isNotEmpty) {
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

                      await Future.delayed(const Duration(seconds: 3));

                      Navigator.pop(context);

                      //
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AddCarPage3(
                            carID: widget.carID,
                            modelID: selectedModelID,
                            //  selectedEngine = ;
                            //                 selectedGearBox = myBox;
                            mygear: selectedGearBox,
                            myEngine: selectedEngine,
                            type: selectedModeltype,
                            model: selectedModel,
                            imagePath: widget.carName,
                            carName: widget.carName);
                      }));

                      // } else {
                      //   await showDialog(
                      //     context: context,
                      //     builder: (BuildContext context) {
                      //       return MoticarDialog(
                      //         icon: const Icon(Icons.info_rounded,
                      //             color: AppColors.appThemeColor, size: 50),
                      //         title: '',
                      //         subtitle:
                      //             'Please select your car model, before proceeding',
                      //         onTap: () {
                      //           Navigator.pop(context);
                      //         },
                      //         buttonColor: AppColors.appThemeColor,
                      //         textColor: AppColors.white,
                      //         buttonText: "Dismiss",
                      //       );
                      //     },
                      //   );
                      // }
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

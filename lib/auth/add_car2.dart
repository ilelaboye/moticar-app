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
    // required this.moticatz,
    required this.selectedCar,
    required this.carName,
    required this.carID,
    required this.isHome,
  });
  final bool isHome;
  final String carName, carID;
  final Map<String, dynamic> selectedCar;
  // final List<Category> moticatz;
  // final List<Model> carmodelz;

  @override
  ConsumerState<AddCarPage2> createState() => _AddCarPage2State();
}

class _AddCarPage2State extends ConsumerState<AddCarPage2> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController carController = TextEditingController();

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
  List<Model> selectedEngine = [];
  List<Model> selectedGearBox = [];

  // int selectedModelIndex = -1;

  List<bool> selectedModelIndex = [];

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
    List<dynamic> categories = widget.selectedCar['categories'];

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
                                // SvgPicture.asset(widget.carName),

                                getImageWidget(widget.carName.toString()),

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
                              //fix Controller
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
                                  onChanged: (value) {
                                    setState(() {});
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

                        const SizedBox(height: 8),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.35,
                          child: ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              final List<dynamic> models = category['models'];
                              // List<bool> selectedModelIndex = List.generate(
                              //   models.length,
                              //   (index) => false,
                              // );

                              selectedModelIndex = List<bool>.filled(
                                  widget.selectedCar.length, false);
                              bool isExpanded =
                                  false; // Initialize isExpanded for each category

                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isExpanded =
                                            !isExpanded; // Toggle visibility for the tapped category
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            category['name'],
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
                                          const Expanded(
                                            child: Divider(
                                              thickness: 1.5,
                                              color: Colors
                                                  .grey, // Change color to your preference
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Icon(
                                            selectedModelIndex[index]
                                                ? Icons
                                                    .keyboard_arrow_up_rounded // Icon when expanded
                                                : Icons
                                                    .keyboard_arrow_down_sharp, // Icon when collapsed
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // if (isExpanded)
                                  Column(
                                    children: models
                                        .asMap()
                                        .entries
                                        .map<Widget>((entry) {
                                      final int index = entry.key;
                                      final dynamic model = entry.value;
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedModelIndex[index] =
                                                !selectedModelIndex[
                                                    index]; // Update selected model index
                                          });
                                        },
                                        child: Container(
                                          height: 57,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.85,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3, horizontal: 15),
                                          margin:
                                              const EdgeInsets.only(bottom: 8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: selectedModelIndex[index]
                                                  ? AppColors
                                                      .lightGreen // Highlight selected model
                                                  : Colors.black12,
                                              width: 1,
                                            ),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black45,
                                                blurRadius: 0.1,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                model['name'],
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Container(
                                                width: 24,
                                                height: 24,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      selectedModelIndex[index]
                                                          ? AppColors.lightGreen
                                                          : Colors.transparent,
                                                  border: Border.all(
                                                    color: selectedModelIndex[
                                                            index]
                                                        ? AppColors.lightGreen
                                                        : Colors.black,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: selectedModelIndex[index]
                                                    ? const Icon(
                                                        Icons.check,
                                                        size: 15,
                                                        color: Colors.white,
                                                      )
                                                    : null,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),

                        //

                        // Column(
                        //   children: [
                        //     SizedBox(
                        //       height: MediaQuery.of(context).size.height * 0.25,
                        //       child: ListView.builder(
                        //         shrinkWrap: true,
                        //         itemCount: categories.length,
                        //         itemBuilder: (context, index) {
                        //           final moticar = categories[index];
                        //           final myBox = categories[index].years;
                        //           final modelz = moticar.name;
                        //           final carname = moticar.name;

                        //           return GestureDetector(
                        //             onTap: () {
                        //               setState(() {
                        //                 // carmodelz = categoriez;
                        //                 selectedCarName = carname;
                        //                 selectedEngine = myBox;
                        //                 selectedGearBox = myBox;
                        //               });

                        //               //
                        //               // print(
                        //               //     'my $carmodelz $selectedCarName');
                        //             },
                        //             child: Padding(
                        //               padding: const EdgeInsets.all(8.0),
                        //               child: Container(
                        //                 padding: const EdgeInsets.all(8),
                        //                 decoration: BoxDecoration(
                        //                   color: Colors.white,
                        //                   borderRadius:
                        //                       BorderRadius.circular(8),
                        //                   border: Border.all(
                        //                     color: popular == moticar.name
                        //                         ? AppColors.lightGreen
                        //                         : const Color(0xfff0f5f5),
                        //                     width: 1,
                        //                   ),
                        //                   boxShadow: const [
                        //                     BoxShadow(
                        //                         color: Colors.black45,
                        //                         blurRadius: 0.1),
                        //                   ],
                        //                 ),
                        //                 child: Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     popular == modelz
                        //                         ? MoticarText(
                        //                             text: modelz,
                        //                             fontSize: 14,
                        //                             fontWeight: FontWeight.w700,
                        //                             fontColor: AppColors.green,
                        //                           )
                        //                         : MoticarText(
                        //                             text: modelz,
                        //                             fontSize: 14,
                        //                             fontWeight: FontWeight.w400,
                        //                             fontColor:
                        //                                 const Color(0xff495353),
                        //                           ),
                        //                     Radio(
                        //                       toggleable: true,
                        //                       value: modelz,
                        //                       activeColor: AppColors.lightGreen,
                        //                       groupValue: popular,
                        //                       onChanged: (value) {
                        //                         setState(() {
                        //                           popular = value.toString();
                        //                           // moticatz = categoriez;
                        //                           selectedCarName = carname;
                        //                         });
                        //                       },
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //           );
                        //         },
                        //       ),
                        //     )
                        //   ],
                        // ),

                        // // suvs cars
                        // Visibility(
                        //   visible: isVisible,
                        //   child: Column(
                        //     children: [
                        //       SizedBox(
                        //         height:
                        //             MediaQuery.of(context).size.height * 0.2,
                        //         child: ListView.builder(
                        //           shrinkWrap: true,
                        //           itemCount: categories.length,
                        //           itemBuilder: (context, index) {
                        //             final category = categories[index];

                        //             final modelz = category.name;
                        //             final carname = category.name;

                        //             return GestureDetector(
                        //               onTap: () {
                        //                 setState(() {
                        //                   // carmodelz = categoriez;
                        //                   // selectedEngine = myBox;
                        //                   // selectedGearBox = mygear;
                        //                   selectedCarName = widget.carName;
                        //                   selectedModeltype = modelz;
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
                        //                       color: popular == modelz
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
                        //                             // selectedEngine = myBox;
                        //                             // selectedGearBox = mygear;
                        //                             selectedCarName = widget
                        //                                 .carName
                        //                                 .toString();

                        //                             selectedModeltype = modelz;

                        //                             print(selectedCarName);

                        //                             // modelz
                        //                             // moticatz = categoriez;
                        //                             // selectedEngine = myBox;
                        //                             // selectedGearBox = mygear;
                        //                             // selectedCarName = modelz;
                        //                             // selectedModelID =
                        //                             //     moticar.id.toString();
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
                        //     ],
                        //   ),
                        // ),
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
                      print(
                          "{$selectedEngine + $selectedGearBox  + $selectedCarName my carName is ${widget.carName} may model is  $selectedModeltype}");
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
                            isHome: widget.isHome,
                            carID: widget.carID,
                            modelID: selectedModelID,
                            //  selectedEngine = ;
                            //                 selectedGearBox = myBox;
                            mygear: selectedGearBox,
                            myEngine: selectedEngine,
                            type: selectedModeltype,
                            model: selectedCarName,
                            // selectedModel,
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

  Widget getImageWidget(String category) {
    switch (category) {
      case 'Acura':
        return SvgPicture.asset('assets/carLogos/acura.svg');
      case 'Audi':
        return SvgPicture.asset('assets/carLogos/audi.svg');

      case 'Toyota':
        return SvgPicture.asset('assets/carLogos/toyota.svg');

      case 'Honda':
        return SvgPicture.asset('assets/carLogos/honda.svg');

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

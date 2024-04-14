// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moticar/widgets/eard_dialog.dart';
import 'package:moticar/widgets/page_indicator.dart';
import 'package:rive/rive.dart';

// import '../../providers/app_providers.dart';
import '../../providers/app_providers.dart';
import '../../utils/validator.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/bottom_sheet_service.dart';
import '../../widgets/colors.dart';
import '../../widgets/image_picker_bottom_sheet.dart';
import 'car_parts3.dart';
import 'confirmImage.dart';

class AddCarPart2 extends StatefulHookConsumerWidget {
  const AddCarPart2(
      {super.key,
      required this.carParts,
      required this.imagePath,
      required this.partCategory});

  final String carParts, imagePath, partCategory;

  @override
  ConsumerState<AddCarPart2> createState() => _AddCarPart2State();
}

class _AddCarPart2State extends ConsumerState<AddCarPart2> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final productControl = TextEditingController();
  final descriptControl = TextEditingController();
  final amountController = TextEditingController();
  // final emailController = TextEditingController();
  // final phoneController = TextEditingController();

  String selectedCarPart = '';
  String selectMeasure = '';
  String conditionz = '';
  String? selectedBrand;
  final List myCategory = ['Total', "Mobil"];
  int selectedIndex = -1; // Initially no card is selected

  int quantity = 0; // Track the quantity

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 0) {
      setState(() {
        quantity--;
      });
    }
  }

  final List measurement = [
    'Gallon',
    "Bottle",
    "Keg",
    "5L",
    "2L",
    "1L",
    "500cL",
    "250cL",
    "100cL",
    '50cL',
    "10cL"
  ];

  final List conditionList = [
    'New',
    "Refurbished",
    "Used",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    productControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var images = useState(XFile(''));
    final _imagePicker = ref.read(imagePickerService);
    // final state = ref.watch(profileProvider);
    // final model = ref.read(profileProvider.notifier);
    return Scaffold(
      backgroundColor: const Color(0xffEEF5F5),
      appBar: AppBar(
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Add Car part",
              style: TextStyle(
                fontFamily: "NeulisAlt",
                fontSize: 16,
                fontStyle: FontStyle.normal,
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Select the part of the car you want to add",
              style: TextStyle(
                fontFamily: "NeulisAlt",
                fontSize: 12,
                fontStyle: FontStyle.normal,
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
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // ignore: prefer_const_constructors
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
                        const Center(
                          child: Text(
                            "Enter the details of the car part ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontSize: 20,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                color: AppColors.appThemeColor),
                          ),
                        ),

                        // ${}
                        const SizedBox(height: 20),

                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  //image
                                  // SvgPicture.asset(widget.imagePath),
                                  const SizedBox(width: 8),
                                  Text(
                                    widget.carParts,
                                    // textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontFamily: "NeulisAlt",
                                        fontSize: 14,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff00343F)),
                                  ),
                                ],
                              ),

                              //icon

                              const Icon(Icons.arrow_forward_ios_rounded,
                                  color: Color(0xff101828)),

                              //partCategory
                              Text(
                                widget.partCategory,
                                // textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontFamily: "NeulisAlt",
                                    fontSize: 14,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff006C70)),
                              ),
                            ],
                          ),
                        ),

                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 8.0, bottom: 8, left: 3),
                                      child: MoticarText(
                                          text: "Name of Product",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          fontColor: AppColors.textColor),
                                    ),
                                    //email
                                    SizedBox(
                                      height: 55,
                                      child: TextFormField(
                                        controller: productControl,
                                        keyboardType: TextInputType.text,
                                        // onTapOutside: (event) {
                                        //   FocusScope.of(context)
                                        //       .unfocus(); // Close the keyboard
                                        // },
                                        textInputAction: TextInputAction.next,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        style: const TextStyle(
                                            fontFamily: "NeulisAlt",
                                            color: AppColors.textColor,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1.2,
                                            fontSize: 15),
                                        validator: (value) =>
                                            FieldValidaor.validateEmptyfield(
                                                value!),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: AppColors.red,
                                                width: 1.5),
                                          ),
                                          hintText:
                                              'Enter the name of the product',
                                          // errorText:
                                          //     _emailError, // Show the error message here

                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Color(0xffD0D5DD),
                                                width: 1.5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: const BorderSide(
                                                  color:
                                                      AppColors.appThemeColor)),
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
                              ),

                              //
                              // const SizedBox(
                              //   height: 12,
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 8.0, bottom: 8, left: 3),
                                      child: MoticarText(
                                          text: "Description (optional)",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          fontColor: AppColors.textColor),
                                    ),
                                    //email
                                    SizedBox(
                                      height: 55,
                                      child: TextFormField(
                                        controller: descriptControl,
                                        keyboardType: TextInputType.text,
                                        // onTapOutside: (event) {
                                        //   FocusScope.of(context)
                                        //       .unfocus(); // Close the keyboard
                                        // },
                                        textCapitalization:
                                            TextCapitalization.words,
                                        textInputAction: TextInputAction.next,
                                        style: const TextStyle(
                                            fontFamily: "NeulisAlt",
                                            color: AppColors.textColor,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1.2,
                                            fontSize: 15),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: AppColors.red,
                                                width: 1.5),
                                          ),
                                          hintText:
                                              'Write a brief note for your personal refference',
                                          // errorText:
                                          //     _emailError, // Show the error message here

                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Color(0xffD0D5DD),
                                                width: 1.5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: const BorderSide(
                                                  color:
                                                      AppColors.appThemeColor)),
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
                              ),

                              //preffered

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 8.0, bottom: 8, left: 3),
                                    child: MoticarText(
                                        text: "Category ",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        fontColor: AppColors.textColor),
                                  ),
                                  //lga drop down
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8, left: 3, right: 3),
                                    child: SizedBox(
                                      height: 55,
                                      child: DropdownButtonFormField(
                                          decoration: const InputDecoration(
                                            hintText: 'Select a brand',
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
                                                  color:
                                                      AppColors.appThemeColor,
                                                  width: 1.5),
                                            ),
                                          ),
                                          items: myCategory
                                              .map<DropdownMenuItem<String>>(
                                                  (value) => DropdownMenuItem<
                                                          String>(
                                                      value: value.toString(),
                                                      child: Text(
                                                        value.toString(),
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "NeulisAlt",
                                                            color: AppColors
                                                                .textColor,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 13),
                                                      )))
                                              .toList(),
                                          value: selectedBrand,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedBrand = value!;
                                            });
                                          }),
                                    ),
                                  ),
                                ],
                              ),

                              //

//confirm password

                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 3),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const MoticarText(
                                        text: "Condition",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        fontColor: AppColors.textColor),

                                    const SizedBox(
                                      height: 8,
                                    ),

                                    //new, refurb, used
                                    SizedBox(
                                      height: 40,
                                      child: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 10.0,
                                                mainAxisSpacing: 10.0,
                                                childAspectRatio: 3),
                                        itemCount: conditionList.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                // selectedIndex = index;

                                                conditionz =
                                                    conditionList[index];

                                                print(conditionz);
                                              });
                                            },
                                            child: Container(
                                              width: 109,
                                              height: 35,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: const Color(0xffCDD2D2),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: MoticarText(
                                                  text: conditionList[index],
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  fontColor:
                                                      AppColors.textColor),
                                            ),
                                          );
                                        },
                                      ),
                                    ),

                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     GestureDetector(
                                    //       onTap: () {
                                    //         setState(() {
                                    //           conditionz = "New";
                                    //         });
                                    //       },
                                    //       child: Container(
                                    //         width: 109,
                                    //         height: 35,
                                    //         alignment: Alignment.center,
                                    //         padding: const EdgeInsets.all(8),
                                    //         decoration: BoxDecoration(
                                    //           color: const Color(0xffCDD2D2),
                                    //           borderRadius:
                                    //               BorderRadius.circular(8),
                                    //         ),
                                    //         child: const MoticarText(
                                    //             text: "New",
                                    //             fontSize: 12,
                                    //             fontWeight: FontWeight.w500,
                                    //             fontColor: AppColors.textColor),
                                    //       ),
                                    //     ),

                                    //     //bank
                                    //     GestureDetector(
                                    //       onTap: () {
                                    //         setState(() {
                                    //           conditionz = "Refurbished";
                                    //         });
                                    //       },
                                    //       child: Container(
                                    //         width: 109,
                                    //         height: 35,
                                    //         alignment: Alignment.center,
                                    //         padding: const EdgeInsets.all(8),
                                    //         decoration: BoxDecoration(
                                    //           color: const Color(0xffCDD2D2),
                                    //           borderRadius:
                                    //               BorderRadius.circular(8),
                                    //         ),
                                    //         child: const MoticarText(
                                    //             text: "Refurbished",
                                    //             fontSize: 12,
                                    //             fontWeight: FontWeight.w500,
                                    //             fontColor: AppColors.textColor),
                                    //       ),
                                    //     ),

                                    //     //debit Card
                                    //     GestureDetector(
                                    //       onTap: () {
                                    //         setState(() {
                                    //           conditionz = "Used";
                                    //         });
                                    //       },
                                    //       child: Container(
                                    //         padding: const EdgeInsets.all(8),
                                    //         width: 109,
                                    //         height: 35,
                                    //         alignment: Alignment.center,
                                    //         decoration: BoxDecoration(
                                    //           color: const Color(0xffCDD2D2),
                                    //           borderRadius:
                                    //               BorderRadius.circular(8),
                                    //         ),
                                    //         child: const MoticarText(
                                    //             text: "Used",
                                    //             fontSize: 12,
                                    //             fontWeight: FontWeight.w500,
                                    //             fontColor: AppColors.textColor),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              ),

                              //
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 3),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        MoticarText(
                                            text: "Unit of Measurement",
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            fontColor: AppColors.textColor),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 200,
                                      child: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 10.0,
                                                mainAxisSpacing: 10.0,
                                                childAspectRatio: 3),
                                        itemCount: measurement.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedIndex = index;

                                                selectMeasure =
                                                    measurement[index];
                                              });
                                            },
                                            child: Container(
                                              width: 109,
                                              height: 35,
                                              padding: const EdgeInsets.all(8),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color:
                                                    // selectedIndex == index
                                                    //     ? Colors.blue
                                                    //     :
                                                    const Color(0xffCDD2D2),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: MoticarText(
                                                text: measurement[index],
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                fontColor:
                                                    // selectedIndex == index
                                                    //     ? Colors.white
                                                    // :
                                                    AppColors.textColor,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              //price
                              const Padding(
                                padding: EdgeInsets.only(bottom: 8, left: 3),
                                child: Row(
                                  children: [
                                    MoticarText(
                                        text: "Price of Item",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        fontColor: AppColors.textColor),
                                  ],
                                ),
                              ),
                              //email
                              SizedBox(
                                height: 55,
                                child: TextFormField(
                                  controller: amountController,
                                  keyboardType: TextInputType.phone,
                                  onTapOutside: (event) {
                                    FocusScope.of(context)
                                        .unfocus(); // Close the keyboard
                                  },
                                  textInputAction: TextInputAction.done,
                                  style: const TextStyle(
                                      fontFamily: "NeulisAlt",
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                  maxLength: 7,
                                  onChanged: (value) {
                                    // final formattedAmount =
                                    //     formatAmountWithThousandSeparator(value);
                                    // if (formattedAmount !=
                                    //     amountController.text) {
                                    //   amountController.value = TextEditingValue(
                                    //     text: formattedAmount,
                                    //     selection: TextSelection.collapsed(
                                    //         offset: formattedAmount.length),
                                    //   );
                                    // }
                                  },
                                  onEditingComplete: () {
                                    // final unformattedAmount =
                                    //     removeThousandSeparator(
                                    //         amountController.text);
                                    // setState(() {
                                    //   amountController.text = unformattedAmount;
                                    // });
                                  },
                                  validator: (value) =>
                                      FieldValidator.validate(value!),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    hintText: 'Enter amount',
                                    prefixText: '\u20A6',
                                    suffixText: '00',
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
                              ),

                              //quantity
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const MoticarText(
                                        text: "Quantity",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        fontColor: AppColors.textColor),

                                    //increase quantity

                                    Container(
                                      width: 180,
                                      height: 62,
                                      // padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: const Color(0xffD0D5DD),
                                              width: 1.5)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // minus button
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  decrementQuantity();
                                                },
                                                icon: const Icon(
                                                  Icons
                                                      .remove_circle_outline_rounded,
                                                  color: Color(0xff00343F),
                                                ),
                                              ),
                                              // divider
                                              const SizedBox(
                                                width: 10,
                                                height:
                                                    62, // Add a non-zero height
                                                child: VerticalDivider(
                                                  color: AppColors.textColor,
                                                ),
                                              ),
                                            ],
                                          ),

                                          //quantity
                                          MoticarText(
                                              text: '$quantity',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              fontColor:
                                                  const Color(0xff00343F)),

                                          //add button
                                          Row(
                                            children: [
                                              // divider
                                              const SizedBox(
                                                width: 10,
                                                height:
                                                    62, // Add a non-zero height
                                                child: VerticalDivider(
                                                  color: AppColors.textColor,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  incrementQuantity();
                                                },
                                                icon: const Icon(
                                                  Icons
                                                      .add_circle_outline_rounded,
                                                  color: Color(0xff00343F),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              //image upload
                              ListTile(
                                title: const Text(
                                    "Upload any image proof (Optional)",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textColor)),
                                subtitle: const Text(
                                  "SVG, PNG, JPG or GIF (max. 800x400px)",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff7BA0A3),
                                  ),
                                ),

                                //add image
                                trailing: GestureDetector(
                                  onTap: () => showMoticarBottom(
                                    child: ImagePickerWidget(
                                      picker: _imagePicker,
                                      imageList: images,
                                      onImageSelected: () {},
                                    ),
                                    context: context,
                                  ),
                                  child: Container(
                                      padding: const EdgeInsets.all(15),
                                      // width: 80,
                                      // height: 80,
                                      // alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Color(0xff7BA0A3),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    //
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.10,
                      child: Center(
                        child: Container(
                          // height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Color(0xffEEF5F5),
                            // color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                  color: Color(0xffEEF5F5), width: 4),
                            ),
                            // boxShadow: [
                            //   BoxShadow(
                            //       color: Colors.black45,
                            //       spreadRadius: 0.5,
                            //       blurRadius: 0.5),
                            // ],
                          ),
                          padding: const EdgeInsets.all(8),
                          child: MoticarLoginButton(
                            myColor: AppColors.indieC,
                            borderColor: AppColors.indieC,
                            onTap: () async {
                              if (productControl.text.isNotEmpty &&
                                  selectedBrand!.isNotEmpty &&
                                  amountController.text.isNotEmpty) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (context) {
                                    return Center(
                                      child: AlertDialog(
                                        backgroundColor:
                                            AppColors.appThemeColor,
                                        shadowColor: AppColors.appThemeColor,
                                        content: Container(
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                                  style: TextStyle(
                                                      color: Colors.white))
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );

                                await Future.delayed(
                                    const Duration(seconds: 1));

                                Navigator.pop(context);

                                print("condition $conditionz & my $quantity");

                                showMoticarBottom(
                                  context: context,
                                  child: FractionallySizedBox(
                                    heightFactor: 0.75,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30.0),
                                        topRight: Radius.circular(30.0),
                                      ),
                                      child: ConfirmImage(
                                        carParts: widget.carParts,
                                        partImage: widget.imagePath,
                                        partCategory: widget.partCategory,
                                        productName: productControl.text,
                                        brand: selectedBrand.toString(),
                                        condition: conditionz.toString(),
                                        quantity: quantity,
                                        description: descriptControl.text,
                                        amount: amountController.text,
                                        measurements: selectMeasure,
                                      ),
                                    ),
                                  ),
                                );

                                //
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return MoticarDialog(
                                      icon: const Icon(Icons.info_rounded,
                                          color: AppColors.appThemeColor,
                                          size: 50),
                                      title: '',
                                      subtitle:
                                          'Please select your car brand, before proceeding',
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
                            },
                            child: const MoticarText(
                              fontColor: AppColors.appThemeColor,
                              text: 'Continue',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //bottom
        ],
      ),
    );
  }
}

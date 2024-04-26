import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';

import '../../../providers/app_providers.dart';
import '../../../utils/enums.dart';
import '../../../utils/validator.dart';
import '../../../widgets/app_texts.dart';
import '../../../widgets/colors.dart';
import '../../../widgets/eard_dialog.dart';
import '../../bottom_bar.dart';

class EnterTollFeePage extends StatefulHookConsumerWidget {
  const EnterTollFeePage({super.key});

  @override
  ConsumerState<EnterTollFeePage> createState() => _EnterTollFeePageState();
}

class _EnterTollFeePageState extends ConsumerState<EnterTollFeePage> {
  bool isIncur = false;

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final searchController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      fieldHintText: "Select Date",
      fieldLabelText: "Select Date",
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return "Today"; //YYYY-MM-DD
    }
    return DateFormat('yyyy-MM-dd').format(date);
    // Customize the format as you desire, for example 'dd/MM/yyyy' for day/month/year
  }

  final List paymentList = [
    'Urgent',
    "Mild",
    "Low",
  ];
  String payType = '';

  late List<bool> isSelectedList;

  @override
  void initState() {
    super.initState();
    isSelectedList = List.generate(paymentList.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
          color: Color(0xffeef5f5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            //
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ignore: prefer_const_constructors
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.yellow,
                        ),
                        child: SvgPicture.asset(""),
                      ),
                      // Container(
                      //   height: 50,
                      //   width: 50,
                      //   padding: const EdgeInsets.all(8),
                      //   decoration: const BoxDecoration(
                      //     color: AppColors.yellow,
                      //     shape: BoxShape.circle,
                      //   ),
                      //     child: SvgPicture.asset(

                      //   ),
                      // ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Toll Fee",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "NeulisAlt",
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: AppColors.appThemeColor,
                            ),
                          ),

                          //
                          GestureDetector(
                            onTap: () async {
                              // _showExpenseCategory(context);
                              // _saveState();
                            },
                            child: const Text(
                              "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: AppColors.indieC,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      //
                      SizedBox(
                        height: 45,
                        width: 130,
                        child: GestureDetector(
                          onTap: () {
                            // _selectDate(context);
                            // _saveState();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 7.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xffCDD2D2),
                            ),
                            child: Center(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Text(
                                    //   _formatDate(_selectedDate),
                                    //   style: _selectedDate != null
                                    //       ? const TextStyle(
                                    //           fontFamily: "NeulisAlt",
                                    //           color: AppColors.textColor,
                                    //           fontWeight: FontWeight.w500,
                                    //           fontSize: 12)
                                    //       : const TextStyle(
                                    //           fontFamily: "NeulisAlt",
                                    //           fontWeight: FontWeight.w400,
                                    //           color: AppColors.textColor,
                                    //           fontSize: 12),
                                    // ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 20,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            //

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8, left: 3),
                      child: MoticarText(
                          text: "Title of Expense",
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          fontColor: AppColors.textColor),
                    ),
                    //email
                    TextFormField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      onTapOutside: (event) {
                        // FocusScope.of(context)
                        //     .unfocus(); // Close the keyboard
                      },
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                          fontFamily: "NeulisAlt",
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => FieldValidator.validate(value!),
                      onEditingComplete: () {},
                      // onChanged: (value) {
                      //   // Update the email variable as the user types

                      // },
                      // onSaved: (value) {
                      //   // Update the email variable as the user types
                      //   _saveState();
                      // },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        hintText: 'Enter a title for your new expense',

                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: Color(0xffD0D5DD), width: 1.5)),
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

                    //Description
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8, left: 3),
                      child: MoticarText(
                          text: "Description",
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          fontColor: AppColors.textColor),
                    ),
                    TextFormField(
                      controller: descriptionController,
                      keyboardType: TextInputType.text,
                      // textCapitalization: TextCapitalization.words,
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus(); // Close the keyboard
                      },
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                          fontFamily: "NeulisAlt",
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                      validator: (value) =>
                          FieldValidaor.validateEmptyfield(value!),
                      onEditingComplete: () {},
                      // onChanged: (value) {
                      //   _saveState();
                      // },
                      // onSaved: (value) {
                      //   _saveState();
                      // },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        hintText:
                            'Write a brief note for your personal\nrefference',

                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: Color(0xffD0D5DD), width: 1.5)),
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

                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              // _isObscure = !_isObscure;
                            });
                          },
                          icon: const Icon(
                            Icons.help,
                            color: AppColors.oldGrey,
                          ),
                        ),
                      ),
                    ),

                    //select a car technician
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8, left: 3),
                      child: MoticarText(
                          text: "Select a car technician",
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          fontColor: AppColors.appThemeColor),
                    ),
                    //Country

                    //amount
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8, left: 3),
                      child: MoticarText(
                          text: "Amount",
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          fontColor: AppColors.textColor),
                    ),
                    SizedBox(
                      height: 55,
                      child: TextFormField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          ThousandsFormatter(),
                        ],
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(
                            fontFamily: "NeulisAlt",
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                        maxLength: 9,
                        onEditingComplete: () {},
                        onChanged: (value) {},
                        validator: (value) => FieldValidator.validate(value!),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          errorBorder: InputBorder.none,
                          hintText: 'Enter amount',
                          prefixText: '\u20A6',
                          suffixText: '00',
                          counterText: '',

                          // prefix: SvgPicture.asset(
                          //     "assets/svgs/naira.svg"),

                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Color(0xffD0D5DD), width: 1.5)),
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

                    //method of payment

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0, left: 3),
                          child: MoticarText(
                              text: "Method of Payment",
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontColor: AppColors.textColor),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: paymentList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // selectedIndex = index;

                                    payType = paymentList[index];

                                    // Toggle the selection // Deselect previously selected item
                                    for (int i = 0;
                                        i < isSelectedList.length;
                                        i++) {
                                      if (i != index) {
                                        isSelectedList[i] = false;
                                      }
                                    }
                                    // Toggle the selection state of the tapped item
                                    isSelectedList[index] =
                                        !isSelectedList[index];
                                    // Print the selected payment type
                                    if (isSelectedList[index]) {
                                      print(paymentList[index]);
                                    } else {
                                      print('No payment type selected');
                                    }
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Container(
                                    width: 109,
                                    height: 35,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: isSelectedList[index]
                                          ? AppColors.appThemeColor
                                          : const Color(0xffCDD2D2),
                                      // color: const Color(0xffCDD2D2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: MoticarText(
                                      text: paymentList[index],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontColor: isSelectedList[index]
                                          ? Colors.white
                                          : AppColors.appThemeColor,
                                      // AppColors.textColor,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    //
                  ],
                ),
              ),
            ),

            //image upload

            //stay signed in
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                children: [
                  Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      value: isIncur,
                      activeColor: AppColors.yellow,
                      trackColor: AppColors.appThemeColor,
                      thumbColor: AppColors.white,
                      onChanged: (value) {
                        // model.stayLoggedIN(value);
                        setState(() {
                          isIncur = value;
                        });
                      },
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(
                      height: 70,
                      // width: double.infinity,
                      child: ListTile(
                        title: Text(
                          "Also remind via email",
                          style: TextStyle(
                              fontFamily: "NeulisAlt",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textColor,
                              letterSpacing: 1.2,
                              fontSize: 14),
                        ),
                        subtitle: Text(
                          "we’ll send a reminder to aaa@gmail.com",
                          style: TextStyle(
                              fontFamily: "NeulisAlt",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textGrey,
                              letterSpacing: 1.2,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            //if incur any cost

            const SizedBox(height: 30),

            //
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Card(
                  elevation: 2,
                  surfaceTintColor: const Color(0xffEEF5F5),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),

                        //Login
                        Row(
                          children: [
                            Expanded(
                              child: MoticarLoginButton(
                                myColor: const Color(0xFFFFFFFF),
                                borderColor: AppColors.indieC,
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const BottomHomePage();
                                      },
                                    ),
                                  );
                                },
                                child: const MoticarText(
                                  fontColor: Color(0xff006C70),
                                  text: 'Cancel',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),

                            //

                            const SizedBox(
                              width: 10,
                            ),

                            Expanded(
                              child: Consumer(builder: (context, ref, child) {
                                final model =
                                    ref.read(profileProvider.notifier);
                                final state = ref.watch(profileProvider);

                                return state.loading == Loader.loading
                                    ?
                                    // const MoticarLoader(
                                    //     size: 30,
                                    //     color:
                                    //         AppColors.appThemeColor,
                                    //   )

                                    const SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: RiveAnimation.asset(
                                          'assets/images/preloader.riv',
                                        ),
                                      )
                                    : MoticarLoginButton(
                                        myColor: AppColors.indieC,
                                        borderColor: AppColors.indieC,
                                        onTap: () async {
                                          // List<Map<String, dynamic>>
                                          //     carPartsList = [
                                          //   {
                                          //     "category": widget.carParts,
                                          //     "product_name":
                                          //         widget.productName,
                                          //     "brand": widget.brand,
                                          //     "condition":
                                          //         widget.conditionz,
                                          //     "unit_of_measurement":
                                          //         widget.measure,
                                          //     "price": widget.amountz
                                          //         .replaceAll(',', ''),
                                          //     "quantity": widget.quantity,
                                          //   },
                                          // ];

                                          final signUpResult =
                                              await model.addNewExpenses(
                                            formData: {
                                              // "category":
                                              //     selectedCategory
                                              //         .toString(),
                                              // "title":
                                              //     titleController
                                              //         .text,
                                              // "description":
                                              //     descriptionController
                                              //         .text,
                                              // "technician":
                                              //     _selectTechie
                                              //         .toString(),
                                              // "amount":
                                              //     amountController
                                              //         .text
                                              //         .replaceAll(
                                              //             ',',
                                              //             ''),
                                              // "method_of_payment":
                                              //     payType,
                                              // "date": _formatDate(
                                              //     _selectedDate),
                                              // "carparts": carPartsList
                                            },
                                          );

                                          if (signUpResult
                                              .successMessage.isNotEmpty) {
                                            // Navigator.pop(context);

                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return const BottomHomePage();
                                            }));

                                            // _clearState();
                                          } else if (signUpResult
                                              .errorMessage.isNotEmpty) {
                                            // Sign-up failed, show error dialog
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return MoticarDialog(
                                                  icon: const Icon(
                                                      Icons.error_outline_sharp,
                                                      color: AppColors.red,
                                                      size: 50),
                                                  title: '',
                                                  subtitle:
                                                      signUpResult.errorMessage,
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  buttonColor: AppColors.red,
                                                  textColor: AppColors.white,
                                                  buttonText: "Dismiss",
                                                );
                                              },
                                            );

                                            // _clearState();
                                          }
                                        },
                                        child: const MoticarText(
                                          fontColor: AppColors.appThemeColor,
                                          text: 'Save',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      );
                              }),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

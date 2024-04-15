// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:moticar/widgets/bottom_sheet_service.dart';

import '../../models/expensesmodel.dart';
import '../../providers/app_providers.dart';
import '../../utils/validator.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import '../../widgets/image_picker_bottom_sheet.dart';
import '../carpart/car_part.dart';

class AddExpensesPage extends StatefulHookConsumerWidget {
  const AddExpensesPage({super.key});

  @override
  ConsumerState<AddExpensesPage> createState() => _AddExpensesPageState();
}

class _AddExpensesPageState extends ConsumerState<AddExpensesPage> {
  final GlobalKey secondComponentKey = GlobalKey();

  final GlobalKey<FormState> _formKey = GlobalKey();
  final emailController = TextEditingController();
  final searchController = TextEditingController();
  final passwordController = TextEditingController();
  final amountController = TextEditingController();
  String email = '', password = '';

  bool _isObscure = true;

  bool isIncur = false;
  String? selectTechie;
  String selectedDayz = "Today";
  List myDayz = [
    "Today",
    'Tomorrow',
    'Next Week',
  ];

  String payType = '';

  List<CategoryPart> categoryItems = [
    CategoryPart(
        imagePath: "assets/expenseCatIcons/keywork.svg", text: 'Key Works'),

    CategoryPart(
        imagePath: "assets/expenseCatIcons/carWash.svg", text: 'Car Wash'),

    CategoryPart(
        imagePath: "assets/expenseCatIcons/alignment.svg", text: 'Alignment'),

    CategoryPart(
        imagePath: "assets/expenseCatIcons/balancing.svg", text: 'Balancing'),

    CategoryPart(
        imagePath: "assets/expenseCatIcons/bodywork.svg", text: 'Body work'),

    CategoryPart(imagePath: "assets/expenseCatIcons/fuel.svg", text: 'Fuel'),

    CategoryPart(imagePath: "assets/expenseCatIcons/dues.svg", text: 'Dues'),

    CategoryPart(
        imagePath: "assets/expenseCatIcons/hydraulics.svg", text: 'Hydraulics'),
    //
    CategoryPart(
        imagePath: "assets/expenseCatIcons/mechanicalWork.svg",
        text: 'Mechanical'),

    //misc
    CategoryPart(imagePath: "assets/expenseCatIcons/misc.svg", text: 'Misc'),

    //Engine
    CategoryPart(
        imagePath: "assets/expenseCatIcons/engine.svg", text: 'Engine'),

    //parking
    CategoryPart(
        imagePath: "assets/expenseCatIcons/mechanicalWork.svg",
        text: 'Parking'),

    //penalty
    CategoryPart(
        imagePath: "assets/expenseCatIcons/penalty.svg", text: 'Penalty'),

    //radiator
    CategoryPart(
        imagePath: "assets/expenseCatIcons/radiator.svg", text: 'Radiator'),

    //servicing
    CategoryPart(
        imagePath: "assets/expenseCatIcons/servicing.svg", text: 'Servicing'),

    //towing
    CategoryPart(imagePath: "assets/expenseCatIcons/tow.svg", text: 'Towing'),

    //tyre gauge
    CategoryPart(
        imagePath: "assets/expenseCatIcons/tyreGuage.svg", text: 'Tyre Guage'),
  ];

  String selectedCategory = "Car Wash"; // Initial value

  final List paymentList = [
    'Cash',
    "Bank",
    "Debit Card",
  ];
// List<bool> isSelectedList =
//       List.generate(paymentList.length, (index) => false);

  late List<bool> isSelectedList;

  @override
  void initState() {
    super.initState();
    isSelectedList = List.generate(paymentList.length, (index) => false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // ref.read(registerViewmodelProvider.notifier).fetchAllTrans();
      // ref.read(registerViewmodelProvider.notifier).getMeProfile();
      ref.read(profileProvider.notifier).getTechnicians();
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    final model = ref.read(profileProvider.notifier);
    List<GetTechies> myTechies = state.techies;
    var images = useState(XFile(''));
    final _imagePicker = ref.read(imagePickerService);

    //

    DateTime now = DateTime.now();
    DateTime endOfYear = DateTime(now.year + 1, 1, 1);
    int remainingDays = endOfYear.difference(now).inDays;
    return Scaffold(
      backgroundColor: AppColors.teal,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: AppColors.teal,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(4)),
                    ),
                    child: Image.asset('assets/images/car_ai.png'),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Toyota Corolla 2016",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "NeulisAlt",
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
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

                      //petrol and gear
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: const Text(
                          "GGE 53 6HB. Diesel . Hatchback . 1.6 CDTI (68)",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: "NeulisAlt",
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xff7AE6EB),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          //other half
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(0),
              decoration: const BoxDecoration(
                color: Color(0xffeef5f5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                  child: SvgPicture.asset(
                                    categoryItems
                                        .firstWhere((element) =>
                                            element.text == selectedCategory)
                                        .imagePath,
                                  ),
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
                                      "Add an expense",
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
                                        _showExpenseCategory(context);
                                      },
                                      child: Text(
                                        selectedCategory,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
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
                                Container(
                                  // alignment: Alignment.center,
                                  // width: 140,
                                  // height: 58,
                                  child: SizedBox(
                                    height: 45,
                                    width: 130,
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color(0xffCDD2D2),
                                      ),
                                      child: DropdownButtonFormField<String>(
                                          alignment:
                                              AlignmentDirectional.center,
                                          icon: const Icon(Icons
                                              .keyboard_arrow_down_rounded),
                                          decoration: const InputDecoration(
                                            hintText: 'Today',
                                            // fillColor: const Color(0xffCDD2D2),
                                            hintStyle: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.textGrey),
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                          ),
                                          items: myDayz
                                              .map<DropdownMenuItem<String>>(
                                                (entry) =>
                                                    DropdownMenuItem<String>(
                                                  value: entry,
                                                  child: Text(
                                                    entry,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff002D36),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                          value: selectedDayz,
                                          onChanged: (nvalue) {
                                            setState(() {
                                              selectedDayz = nvalue!;
                                            });
                                          }),
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
                                padding: EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 3),
                                child: MoticarText(
                                    text: "Title of Expense",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    fontColor: AppColors.textColor),
                              ),
                              //email
                              TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) =>
                                    FieldValidator.validate(value!),
                                onSaved: (value) {
                                  password = value!;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  hintText:
                                      'Enter a title for your new expense',

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

                              //Description
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 3),
                                child: MoticarText(
                                    text: "Description",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    fontColor: AppColors.textColor),
                              ),
                              TextFormField(
                                controller: passwordController,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                onTapOutside: (event) {
                                  FocusScope.of(context)
                                      .unfocus(); // Close the keyboard
                                },
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    fontFamily: "NeulisAlt",
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                                validator: (value) =>
                                    FieldValidaor.validateEmptyfield(value!),
                                onSaved: (value) {
                                  password = value!;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  hintText:
                                      'Write a brief note for your personal\nrefference',

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

                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    },
                                    icon: Icon(
                                        _isObscure ? Icons.help : Icons.help,
                                        color: _isObscure
                                            ? AppColors.oldGrey
                                            : Colors.black.withOpacity(0.55)),
                                  ),
                                ),
                              ),

                              //select a car technician
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 3),
                                child: MoticarText(
                                    text: "Select a car technician",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    fontColor: AppColors.appThemeColor),
                              ),
                              //Country
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8, left: 3, right: 3),
                                child: DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                      hintText: 'Select Technician',
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
                                    items: myTechies
                                        .map<DropdownMenuItem<String>>(
                                          (tech) => DropdownMenuItem<String>(
                                            value: tech.id.toString(),
                                            child: Row(
                                              children: [
                                                Container(
                                                    height: 50,
                                                    width: 50,
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.network(
                                                      tech.image.toString(),
                                                      fit: BoxFit.cover,
                                                    )),

                                                const SizedBox(
                                                  width: 8,
                                                ),

                                                //
                                                Text(
                                                  // tech.preferredName.toString(),
                                                  '${tech.firstName} ${tech.lastName}',
                                                  style: const TextStyle(
                                                      fontFamily: "NeulisAlt",
                                                      color:
                                                          AppColors.textColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 1.2,
                                                      fontSize: 14),
                                                ),

                                                const SizedBox(
                                                  width: 12,
                                                ),

                                                //phone number
                                                Text(
                                                  // tech.preferredName.toString(),
                                                  '${tech.phone}',
                                                  style: const TextStyle(
                                                      fontFamily: "NeulisAlt",
                                                      color: Color(0xff00AEB5),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    value: selectTechie,
                                    onChanged: (value) {
                                      setState(() {
                                        selectTechie = value!;
                                      });
                                    }),
                              ),

                              if (selectTechie ==
                                  null) // Display the button only when no technician is selected
                                GestureDetector(
                                  onTap: () {
                                    // Handle the button tap here
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: Color(0xffFCF7CC),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.person_3_outlined,
                                            color: Color(0xff006C70)),
                                        SizedBox(width: 4),
                                        Text(
                                          "Add a New Car Technician",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff006C70),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              //amount
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 3),
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
                              //email
                              // TextFormField(
                              //   controller: amountController,
                              //   keyboardType: TextInputType.phone,
                              //   onTapOutside: (event) {
                              //     // FocusScope.of(context)
                              //     //     .unfocus(); // Close the keyboard
                              //   },
                              //   textInputAction: TextInputAction.next,
                              //   style: const TextStyle(
                              //       fontFamily: "NeulisAlt",
                              //       color: AppColors.textColor,
                              //       fontWeight: FontWeight.w600,
                              //       fontSize: 16),
                              //   maxLength: 7,
                              //   onChanged: (value) {
                              //     final formattedAmount =
                              //         formatAmountWithThousandSeparator(value);
                              //     if (formattedAmount !=
                              //         amountController.text) {
                              //       amountController.value = TextEditingValue(
                              //         text: formattedAmount,
                              //         selection: TextSelection.collapsed(
                              //             offset: formattedAmount.length),
                              //       );
                              //     }
                              //   },
                              //   onEditingComplete: () {
                              //     final unformattedAmount =
                              //         removeThousandSeparator(
                              //             amountController.text);
                              //     setState(() {
                              //       amountController.text = unformattedAmount;
                              //     });
                              //   },
                              //   validator: (value) =>
                              //       FieldValidator.validate(value!),
                              //   decoration: InputDecoration(
                              //     border: InputBorder.none,
                              //     errorBorder: InputBorder.none,
                              //     hintText: 'Enter amount',
                              //     prefixText: '\u20A6',
                              //     suffixText: '00',

                              //     enabledBorder: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(8),
                              //         borderSide: const BorderSide(
                              //             color: Color(0xffD0D5DD),
                              //             width: 1.5)),
                              //     focusedBorder: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(8),
                              //         borderSide: const BorderSide(
                              //             color: AppColors.appThemeColor)),
                              //     filled: true,
                              //     fillColor: Colors.white,
                              //     // hintText: 'Enter your password',
                              //     hintStyle: const TextStyle(
                              //         fontFamily: "NeulisAlt",
                              //         fontWeight: FontWeight.w400,
                              //         color: Color(0xffC1C3C3),
                              //         letterSpacing: 1.2,
                              //         fontSize: 14),
                              //   ),
                              // ),

                              //method of payment

                              const Padding(
                                padding: EdgeInsets.only(top: 8.0, left: 3),
                                child: MoticarText(
                                    text: "Method of Payment",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    fontColor: AppColors.textColor),
                              ),

                              SizedBox(
                                height: 60,
                                child: GridView.builder(
                                  // physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 6.0,
                                          mainAxisSpacing: 6.0,
                                          childAspectRatio: 3),
                                  itemCount: paymentList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          // selectedIndex = index;

                                          payType = paymentList[index];

                                          print(payType);

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
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                    );
                                  },
                                ),
                              ),

                              //
                            ],
                          ),
                        ),
                      ),

                      //image upload
                      ListTile(
                        title: const Text("Upload any image proof (Optional)",
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
                                height: 60,
                                // width: double.infinity,
                                child: ListTile(
                                  title: Text(
                                    "Did you incur any cost?",
                                    style: TextStyle(
                                        fontFamily: "NeulisAlt",
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textColor,
                                        letterSpacing: 1.2,
                                        fontSize: 14),
                                  ),
                                  subtitle: Text(
                                    "While making this expense, did you make any purchase for any car parts or accessories?",
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
                      Visibility(
                        visible: isIncur,
                        child: Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MoticarLoginButton(
                                myColor: const Color(0xFFFFFFFF),
                                borderColor: AppColors.white,
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const AddCarPart();
                                  }));
                                },
                                child: const MoticarText(
                                  fontColor: Color(0xff00343F),
                                  text: 'Add a car part',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const MoticarText(
                                fontColor: Color(0xff202a2a),
                                text:
                                    'It is recommended that you log in car parts or accessories you purchased for this expense',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      ),

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
                                            Navigator.pop(context);
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

                                      //
                                      Expanded(
                                        child: Consumer(
                                            builder: (context, ref, child) {
                                          final model = ref.read(
                                              loginViewModelProvider.notifier);
                                          return MoticarLoginButton(
                                            myColor: AppColors.indieC,
                                            borderColor: AppColors.indieC,
                                            onTap: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                //method of pay
                                                // final String myEmail =
                                                //     emailController.text;
                                                // final String myPass =
                                                //     passwordController.text;

                                                // // if(myEmail.isNotEmpty && myPass.isNotEmpty){
                                                // showDialog(
                                                //   context: context,
                                                //   barrierDismissible: true,
                                                //   builder: (context) {
                                                //     return Center(
                                                //       child: AlertDialog(
                                                //         backgroundColor:
                                                //             AppColors
                                                //                 .appThemeColor,
                                                //         shadowColor: AppColors
                                                //             .appThemeColor,
                                                //         content: Container(
                                                //           padding:
                                                //               const EdgeInsets
                                                //                   .all(20),
                                                //           decoration:
                                                //               BoxDecoration(
                                                //             borderRadius:
                                                //                 BorderRadius
                                                //                     .circular(
                                                //                         10),
                                                //           ),
                                                //           child: const Column(
                                                //             mainAxisSize:
                                                //                 MainAxisSize
                                                //                     .min,
                                                //             children: [
                                                //               SizedBox(
                                                //                 height: 100,
                                                //                 width: 100,
                                                //                 child:
                                                //                     RiveAnimation
                                                //                         .asset(
                                                //                   'assets/images/preloader.riv',
                                                //                 ),
                                                //               ),
                                                //               SizedBox(
                                                //                   height: 8),
                                                //               Text(
                                                //                   'Welcome to Moticar',
                                                //                   textAlign:
                                                //                       TextAlign
                                                //                           .center,
                                                //                   style: TextStyle(
                                                //                       color: Colors
                                                //                           .white))
                                                //             ],
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     );
                                                //   },
                                                // );

                                                // await Future.delayed(
                                                //     const Duration(seconds: 3));

                                                // // All fields are filled, attempt sign-up
                                                // final signUpResult =
                                                //     await model.login(
                                                //   formData: {
                                                //     'email':
                                                //         emailController.text,
                                                //     'password':
                                                //         passwordController.text,
                                                //   },
                                                // );

                                                // if (signUpResult.successMessage
                                                //     .isNotEmpty) {
                                                //   Navigator.pop(context);
                                                //   // Sign-up successful, show success dialog
                                                //   await Future.delayed(
                                                //       const Duration(
                                                //           milliseconds: 100),
                                                //       () async {
                                                //     await HiveStorage.put(
                                                //         HiveKeys.userEmail,
                                                //         emailController.text);
                                                //     await HiveStorage.put(
                                                //         HiveKeys.userPassword,
                                                //         passwordController
                                                //             .text);
                                                //     await HiveStorage.put(
                                                //         HiveKeys.hasLoggedIn,
                                                //         true);
                                                //   });
                                                //   Navigator.push(context,
                                                //       MaterialPageRoute(
                                                //           builder: (context) {
                                                //     return const BottomHomePage();
                                                //   }));
                                                // } else if (signUpResult
                                                //     .errorMessage.isNotEmpty) {
                                                //   // Sign-up failed, show error dialog
                                                //   showDialog(
                                                //     context: context,
                                                //     builder:
                                                //         (BuildContext context) {
                                                //       return MoticarDialog(
                                                //         icon: const Icon(
                                                //             Icons
                                                //                 .error_outline_sharp,
                                                //             color:
                                                //                 AppColors.red,
                                                //             size: 50),
                                                //         title: '',
                                                //         subtitle: signUpResult
                                                //             .errorMessage,
                                                //         onTap: () {
                                                //           Navigator.pop(
                                                //               context);
                                                //         },
                                                //         buttonColor:
                                                //             AppColors.red,
                                                //         textColor:
                                                //             AppColors.white,
                                                //         buttonText: "Dismiss",
                                                //       );
                                                //     },
                                                //   );
                                                // }
                                              }

                                              // context.router.push(const LoginRouteCopy());
                                            },
                                            child: const MoticarText(
                                              fontColor:
                                                  AppColors.appThemeColor,
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
          ),

          //
        ],
      ),
    );
  }

  // Function to remove thousand separators from formatted text
  String removeThousandSeparator(String value) {
    return value.replaceAll(',', '');
  }

// Function to format the amount with thousand separators
  String formatAmountWithThousandSeparator(String value) {
    final numberFormat = NumberFormat('#,##0', 'en_US');
    try {
      return numberFormat.format(double.parse(value));
    } catch (e) {
      return '';
    }
  }

  // verify otp modal
  void _showExpenseCategory(
    BuildContext context,
  ) {
    // final RenderObject? renderBox = key.currentContext?.findRenderObject();
    // final componentPosition = renderBox?.constraints.isNormalized;
    // .localToGlobal(Offset.zero);

    // double sheetHeight =
    //     MediaQuery.of(context).size.height - 50;
    showModalBottomSheet(
      isScrollControlled: true,
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height * 0.75,
      ),
      backgroundColor: const Color(0xff002D36),
      enableDrag: false,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     IconButton(
                //       icon: const Icon(Icons.close, color: Color(0xff101828)),
                //       onPressed: () {
                //         Navigator.pop(context);
                //       },
                //     ),
                //   ],
                // ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    onTapOutside: (event) {
                      // FocusScope.of(context)
                      //     .unfocus(); // Close the keyboard
                    },
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                        fontFamily: "NeulisAlt",
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                    onSaved: (value) {
                      password = value!;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      hintText: 'Search',

                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide: const BorderSide(
                              color: const Color(0xff001A1F), width: 0.5)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: AppColors.appThemeColor)),
                      filled: true,
                      fillColor: const Color(0xff001A1F),
                      // hintText: 'Enter your password',
                      suffixIcon: const Icon(
                        Icons.search_rounded,
                        color: Color(0xffC1C3C3),
                      ),
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

                //
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xff00232A),
                      borderRadius: BorderRadius.circular(64),
                    ),
                    child: const Center(
                      child: Text(
                        'Recently Used',
                        style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xff7BA0A3),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.13,
                    child: Container(
                      // color: const Color(0xff002D36),
                      color: Colors.transparent,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryItems.length,
                        // padding: const EdgeInsets.fromLTRB(3, 10, 3, 3),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = categoryItems[index].text;
                              });
                              Navigator.pop(
                                  context); // Close the bottom sheet after selection
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CatergoryMenu(
                                item: categoryItems[index],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // Add your terms and conditions here

                // const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xff00232A),
                      borderRadius: BorderRadius.circular(64),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sort A - Z',
                          style: TextStyle(
                            fontFamily: "NeulisAlt",
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xff7BA0A3),
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.tune_rounded,
                          color: Color(0xff7BA0A3),
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                //list of categories
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Container(
                    // color: const Color(0xff002D36),
                    color: Colors.transparent,
                    child: GridView.builder(
                      itemCount: categoryItems.length,
                      // padding: const EdgeInsets.fromLTRB(3, 10, 3, 3),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = categoryItems[index].text;
                            });
                            Navigator.pop(
                                context); // Close the bottom sheet after selection
                          },
                          child: CatergoryMenu(
                            item: categoryItems[index],
                          ),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                    ),
                  ),
                ),

                // Add your terms and conditions content here
                const Text(
                  '',
                  style: TextStyle(
                    fontFamily: "NeulisAlt",
                    fontSize: 14,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CategoryPart {
  final String imagePath, text;

  CategoryPart({required this.imagePath, required this.text});
}

class CatergoryMenu extends StatelessWidget {
  const CatergoryMenu({super.key, required this.item, this.height = 60});

  final CategoryPart item;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.yellow,
          ),
          child: SvgPicture.asset(
            item.imagePath,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item.text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: "NeulisAlt",
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}

// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:moticar/widgets/bottom_sheet_service.dart';
import 'package:moticar/widgets/eard_loader.dart';
import 'package:rive/rive.dart';

import '../../models/expensesmodel.dart';
import '../../providers/app_providers.dart';
import '../../utils/enums.dart';
import '../../utils/validator.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import '../../widgets/eard_dialog.dart';
import '../../widgets/image_picker_bottom_sheet.dart';
import '../../widgets/total_widget.dart';
import '../bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../carpart/car_part.dart';

class AddExpensesPage extends StatefulHookConsumerWidget {
  const AddExpensesPage(
      {super.key,
      required this.conditionz,
      required this.isDone,
      required this.measure,
      required this.imagePath,
      required this.brand,
      required this.quantity,
      required this.productName,
      required this.carParts,
      required this.amountz});
  final String imagePath,
      quantity,
      productName,
      carParts,
      amountz,
      conditionz,
      measure,
      brand;
  final bool isDone;

  @override
  ConsumerState<AddExpensesPage> createState() => _AddExpensesPageState();
}

class _AddExpensesPageState extends ConsumerState<AddExpensesPage> {
  final GlobalKey secondComponentKey = GlobalKey();

  final GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController amountController;

  final searchController = TextEditingController();
  // late descriptionController = TextEditingController();
  // late amountController = TextEditingController();
  late SharedPreferences _prefs;

  // String? title, descript, carTech, amountz, mode2Pay;

  bool _isObscure = true;

  bool isIncur = false;
  DateTime? _selectedDate;
  String? _selectTechie;
  String selectedDayz = "Today";
  List myDayz = [
    "Today",
    'Tomorrow',
    'Next Week',
  ];

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

  late List<bool> isSelectedList;

  @override
  void initState() {
    _loadSavedText();
    // _clearState();

    super.initState();
    isSelectedList = List.generate(paymentList.length, (index) => false);

    titleController = TextEditingController();
    descriptionController = TextEditingController();
    amountController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // ref.read(registerViewmodelProvider.notifier).fetchAllTrans();
      // ref.read(registerViewmodelProvider.notifier).getMeProfile();
      ref.read(profileProvider.notifier).getTechnicians();
    });
  }

  Future<void> _loadSavedText() async {
    _prefs = await SharedPreferences.getInstance();
    final savedDate = _prefs.getString('selectedDate');
    _selectedDate = savedDate != null ? DateTime.tryParse(savedDate) : null;
    _selectTechie = _prefs.getString('selectedTechie');
    payType = _prefs.getString("payType")!;
    selectedCategory = _prefs.getString('selectedCategory')!;
    final titlez = _prefs.getString('titlez') ?? '';
    final descript = _prefs.getString('descript') ?? '';
    final amountzz = _prefs.getString('amountzz') ?? '';
    setState(() {
      titleController.text = titlez;
      descriptionController.text = descript;
      amountController.text = amountzz;
    });
  }

  Future<void> _saveState() async {
    if (_selectedDate != null) {
      await _prefs.setString('selectedDate', _selectedDate!.toString());
    }
    if (_selectTechie != null) {
      await _prefs.setString('selectedTechie', _selectTechie!);
    }

    if (payType != null) {
      await _prefs.setString("payType", payType);
    }

    if (selectedCategory != null) {
      await _prefs.setString("selectedCategory", selectedCategory);
    }
    await _prefs.setString('titlez', titleController.text);
    await _prefs.setString('descript', descriptionController.text);
    await _prefs.setString('amountzz', amountController.text);
  }

  Future<void> _clearState() async {
    await _prefs.remove('selectedDate');
    await _prefs.remove('selectedTechie');
    await _prefs.remove('payType');
    await _prefs.remove('selectedCategory');
    await _prefs.remove('titlez');
    await _prefs.remove('descript');
    await _prefs.remove('amountzz');
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    amountController.dispose();
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

    String widgetAmountz = widget.amountz;
    String amountControllerText = amountController.text;

    int totalSum = calculateTotal(widgetAmountz, amountControllerText);
    print("Total sum: $totalSum");

    return Scaffold(
      backgroundColor: AppColors.teal,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.129,
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
                                        _saveState();
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
                                //
                                SizedBox(
                                  height: 45,
                                  width: 130,
                                  child: GestureDetector(
                                    onTap: () {
                                      _selectDate(context);
                                      _saveState();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color(0xffCDD2D2),
                                      ),
                                      child: Center(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                _formatDate(_selectedDate),
                                                style: _selectedDate != null
                                                    ? const TextStyle(
                                                        fontFamily: "NeulisAlt",
                                                        color:
                                                            AppColors.textColor,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12)
                                                    : const TextStyle(
                                                        fontFamily: "NeulisAlt",
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColors.textColor,
                                                        fontSize: 12),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                size: 20,
                                                color: Colors.black
                                                    .withOpacity(0.8),
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) =>
                                    FieldValidator.validate(value!),
                                onEditingComplete: () {
                                  _saveState();
                                },
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
                                controller: descriptionController,
                                keyboardType: TextInputType.text,
                                // textCapitalization: TextCapitalization.words,
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
                                onEditingComplete: () {
                                  _saveState();
                                },
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
                                child: myTechies.isEmpty
                                    ? SizedBox() // Render SizedBox if myTechies list is empty
                                    : DropdownButtonFormField<String>(
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
                                              (tech) =>
                                                  DropdownMenuItem<String>(
                                                value: tech.id.toString(),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        height: 50,
                                                        width: 50,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
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
                                                          fontFamily:
                                                              "NeulisAlt",
                                                          color: AppColors
                                                              .textColor,
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
                                                          fontFamily:
                                                              "NeulisAlt",
                                                          color:
                                                              Color(0xff00AEB5),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        value: _selectTechie,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectTechie = value!;
                                            // _saveState();
                                          });
                                        },
                                      ),
                              ),

                              if (_selectTechie ==
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
                                  onEditingComplete: () {
                                    _saveState();
                                  },
                                  onChanged: (value) {
                                    _saveState();
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

                                    // prefix: SvgPicture.asset(
                                    //     "assets/svgs/naira.svg"),

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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: paymentList.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _saveState();
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
                                                print(
                                                    'No payment type selected');
                                              }
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15.0),
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
                                height: 70,
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

                      widget.isDone == false
                          ? const SizedBox()
                          : Column(
                              children: [
                                const SizedBox(height: 30),

                                //first divider
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Divider(
                                    thickness: 1.2,
                                    color: Color(0xffCDD2D2),
                                  ),
                                ),

                                //
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(widget.imagePath),
                                          const SizedBox(width: 12),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 6,
                                                top: 2,
                                                bottom: 2,
                                                right: 6),
                                            decoration: BoxDecoration(
                                                color: AppColors.yellow,
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: Text(
                                              widget.quantity,
                                              style: const TextStyle(
                                                fontFamily: "NeulisAlt",
                                                // color: Color(0xff002D36),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.appThemeColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      //
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(widget.productName.toString(),
                                              style: const TextStyle(
                                                  fontFamily: "NeulisAlt",
                                                  color: Color(0xff002D36),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)),
                                          //
                                          Text(
                                            widget.carParts.toString(),
                                            style: const TextStyle(
                                                fontFamily: "NeulisAlt",
                                                color: Color(0xffC1C3C3),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),

                                      //
                                      Row(
                                        children: [
                                          Text(
                                            // nairaFormat.format(
                                            "N ${widget.amountz}",
                                            style: const TextStyle(
                                                fontFamily: "Neulis",
                                                color: Color(0xff006C70),
                                                fontSize: 15.5,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          PopupMenuButton(
                                            surfaceTintColor: Colors.white,
                                            shadowColor:
                                                const Color(0xffC1C3C3),
                                            // color: const Color(0xffC1C3C3),
                                            itemBuilder:
                                                (BuildContext context) => [
                                              PopupMenuItem(
                                                value: 'edit',
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        'assets/svgs/edit.svg'),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    const Text('Edit'),
                                                  ],
                                                ),
                                              ),
                                              PopupMenuItem(
                                                value: 'strike_off',
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        'assets/svgs/strike.svg'),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    const Text('Strike off'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                            onSelected: (String value) {
                                              if (value == 'edit') {
                                                // Handle edit action
                                              } else if (value ==
                                                  'strike_off') {
                                                // Handle strike off action
                                              }
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),

                                MyTotalWidget(
                                  totalAmount: totalSum.toString(),
                                  partAmount: widget.amountz,
                                ),

                                //divider
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Divider(
                                    thickness: 1.2,
                                    color: Color(0xffCDD2D2),
                                  ),
                                ),
                              ],
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
                                  _loadSavedText();
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
                                            _clearState();
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

                                      widget.isDone == false
                                          ? const SizedBox()
                                          : Expanded(
                                              child: Consumer(builder:
                                                  (context, ref, child) {
                                                final model = ref.read(
                                                    profileProvider.notifier);
                                                final state =
                                                    ref.watch(profileProvider);

                                                return state.loading ==
                                                        Loader.loading
                                                    ?
                                                    // const MoticarLoader(
                                                    //     size: 30,
                                                    //     color:
                                                    //         AppColors.appThemeColor,
                                                    //   )

                                                    const SizedBox(
                                                        height: 100,
                                                        width: 100,
                                                        child:
                                                            RiveAnimation.asset(
                                                          'assets/images/preloader.riv',
                                                        ),
                                                      )
                                                    : MoticarLoginButton(
                                                        myColor:
                                                            AppColors.indieC,
                                                        borderColor:
                                                            AppColors.indieC,
                                                        onTap: () async {
                                                          List<
                                                                  Map<String,
                                                                      dynamic>>
                                                              carPartsList = [
                                                            {
                                                              "category": widget
                                                                  .carParts,
                                                              "product_name":
                                                                  widget
                                                                      .productName,
                                                              "brand":
                                                                  widget.brand,
                                                              "condition": widget
                                                                  .conditionz,
                                                              "unit_of_measurement":
                                                                  widget
                                                                      .measure,
                                                              "price": widget
                                                                  .amountz
                                                                  .replaceAll(
                                                                      ',', ''),
                                                              "quantity": widget
                                                                  .quantity,
                                                            },
                                                          ];

                                                          final signUpResult =
                                                              await model
                                                                  .addNewExpenses(
                                                            formData: {
                                                              "category":
                                                                  selectedCategory
                                                                      .toString(),
                                                              "title":
                                                                  titleController
                                                                      .text,
                                                              "description":
                                                                  descriptionController
                                                                      .text,
                                                              "technician":
                                                                  _selectTechie
                                                                      .toString(),
                                                              "amount":
                                                                  amountController
                                                                      .text
                                                                      .replaceAll(
                                                                          ',',
                                                                          ''),
                                                              "method_of_payment":
                                                                  payType,
                                                              "date": _formatDate(
                                                                  _selectedDate),
                                                              "carparts":
                                                                  carPartsList
                                                            },
                                                          );

                                                          if (signUpResult
                                                              .successMessage
                                                              .isNotEmpty) {
                                                            // Navigator.pop(context);

                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                              return const BottomHomePage();
                                                            }));

                                                            _clearState();
                                                          } else if (signUpResult
                                                              .errorMessage
                                                              .isNotEmpty) {
                                                            // Sign-up failed, show error dialog
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return MoticarDialog(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .error_outline_sharp,
                                                                      color: AppColors
                                                                          .red,
                                                                      size: 50),
                                                                  title: '',
                                                                  subtitle:
                                                                      signUpResult
                                                                          .errorMessage,
                                                                  onTap: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  buttonColor:
                                                                      AppColors
                                                                          .red,
                                                                  textColor:
                                                                      AppColors
                                                                          .white,
                                                                  buttonText:
                                                                      "Dismiss",
                                                                );
                                                              },
                                                            );

                                                            _clearState();
                                                          }
                                                        },
                                                        child:
                                                            const MoticarText(
                                                          fontColor: AppColors
                                                              .appThemeColor,
                                                          text: 'Save',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
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

  int calculateTotal(String str1, String str2) {
    // Parse strings to integers
    int int1 = int.tryParse(str1) ?? 0; // Use 0 if parsing fails
    int int2 = int.tryParse(str2) ?? 0; // Use 0 if parsing fails

    // Calculate the total
    int total = int1 + int2;

    return total;
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

  // show expense Category
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
                      // password = value!;
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

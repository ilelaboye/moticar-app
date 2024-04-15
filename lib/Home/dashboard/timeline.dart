import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moticar/auth/add_car.dart';
import '../../models/expensesmodel.dart';
import '../../providers/app_providers.dart';
import '../../utils/enums.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/bottom_sheet_service.dart';
import '../../widgets/colors.dart';
import 'package:intl/intl.dart';
import 'package:clean_calendar/clean_calendar.dart';

import '../../widgets/eard_loader.dart';
import '../expense/add_expense.dart';
import '../expense/add_technician.dart';
import '../profile/my_cars.dart';

class TimelinePage extends StatefulHookConsumerWidget {
  const TimelinePage({super.key});

  @override
  ConsumerState<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends ConsumerState<TimelinePage> {
  List myMonthz = [
    "January",
    'Febraury',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  String? selectedMonth;
  List<int> daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  int selectedYear = DateTime.now().year;

  int currentMonthIndex = DateTime.now().month - 1;

  late DateTime _selectedDate;

  List<DateTime> selectedDates = [];

  // Function to get the days of the week
  List<String> _getDaysOfWeek() {
    DateFormat dateFormat = DateFormat('E');
    List<String> daysOfWeek = [];
    for (int i = 1; i <= 7; i++) {
      DateTime date =
          DateTime(2022, 1, i); // Use any date to get the days of the week
      daysOfWeek.add(dateFormat.format(date));
    }
    return daysOfWeek;
  }

  // Function to get the dates of the selected month
  List<int> _getDatesInMonth(DateTime date) {
    int daysInMonth = DateTime(date.year, date.month + 1, 0).day;
    return List<int>.generate(daysInMonth, (index) => index + 1);
  }

  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // ref.read(profileProvider.notifier).getExpenses();
      ref.read(profileProvider.notifier).getMyCars();
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime endOfYear = DateTime(now.year + 1, 1, 1);
    int remainingDays = endOfYear.difference(now).inDays;

    // List<String> daysOfWeek = _getDaysOfWeek();
    // List<int> datesInMonth = _getDatesInMonth(_selectedDate);
    final state = ref.read(profileProvider);
    final model = ref.read(profileProvider.notifier);

    List<GetCarz> myCarz = state.getallCarz;
    return Scaffold(
      backgroundColor: AppColors.teal,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddExpensesPage();
          }));
        },
        child: const Icon(
          Icons.add,
          color: AppColors.appThemeColor,
        ),
      ),
      //  const Color(0xffEFF5F5),
      body: Column(
        children: [
          // top green screen
          if (state.loading != Loader.loading && myCarz.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(6),
              // height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.12,
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: AppColors.teal,
                    ),
                    child: ListView.builder(
                      itemCount: 1, //myCarz.length,
                      itemBuilder: (BuildContext context, int index) {
                        final carz = myCarz[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showMoticarBottom(
                                    context: context,
                                    child: FractionallySizedBox(
                                      heightFactor: 0.89,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                        ),
                                        child: MyCarInfoPage(
                                            plateNumber: carz.plateNumber,
                                            chasisNumber: carz.chasisNumber,
                                            engineNumber: carz.engineNumber,
                                            dateOfPurchase: carz.dateOfPurchase,
                                            vehicleLicense: carz.vehicleLicense,
                                            roadWorthiness: carz.roadWorthiness,
                                            thirdPartyInsurance:
                                                carz.thirdPartyInsurance,
                                            engine: carz.engine.toString(),
                                            gearbox: carz.gearbox.toString(),
                                            car: carz.car.toString(),
                                            model: carz.model.toString(),
                                            category: carz.category.toString()),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4),
                                        topRight: Radius.circular(4),
                                        bottomLeft: Radius.circular(4),
                                        bottomRight: Radius.circular(4)),
                                  ),
                                  child: Image.asset(
                                    'assets/images/car_ai.png',
                                    height: 45,
                                  ),
                                ),
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
                                      Text(
                                        "${carz.car} ${carz.model}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
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
                                            left: 8,
                                            right: 8,
                                            top: 4,
                                            bottom: 4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xff00343f),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: Text(
                                          "exp. $remainingDays dayss",
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      "${carz.engine} . ${carz.category} . ${carz.gearbox}",
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontFamily: "NeulisAlt",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Color(0xff7AE6EB),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8.0),
                                child: GestureDetector(
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
                              ),

                              // notfication

                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _showMyNotification(context);
                                  },
                                  child: isVisible
                                      ? const SizedBox()
                                      : const Icon(
                                          Icons.notifications_none_sharp,
                                          color: AppColors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: isVisible,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: MoticarLoginButton(
                                  borderColor: const Color(0xff00AEB5),
                                  myColor: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Edit',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'NeulisAlt',
                                          color: Color(0xff00AEB5),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      SvgPicture.asset(
                                          'assets/svgs/new_edit.svg'),
                                    ],
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ),

                            //delete
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: MoticarLoginButton(
                                  borderColor: const Color(0xff00AEB5),
                                  myColor: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Delete',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'NeulisAlt',
                                          color: Color(0xff00AEB5),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      SvgPicture.asset(
                                          'assets/svgs/delete.svg'),
                                    ],
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            )
                          ],
                        ),
                        // const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: MoticarLoginButton(
                            borderColor: const Color(0xff29D7DE),
                            myColor: const Color(0xff29D7DE),
                            child: const Center(
                              child: Text(
                                'Add new Car',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'NeulisAlt',
                                  color: AppColors.appThemeColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const AddCarPage();
                              }));
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
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

          //other half
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(2),
              // height: MediaQuery.of(context).size.height * 0.78,
              // width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Color(0xffEFF5F5),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Dashboard",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "NeulisAlt",
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: AppColors.appThemeColor,
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 40,
                                width: 145,
                                child: Container(
                                  // alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: const Color(0xffCDD2D2),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                      // alignment: AlignmentDirectional.center,
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                      ),
                                      decoration: const InputDecoration(
                                        hintText: 'Select Month',
                                        // fillColor: const Color(0xffCDD2D2),
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff002D36)),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                      items: myMonthz
                                          .map<DropdownMenuItem<String>>(
                                            (entry) => DropdownMenuItem<String>(
                                              value: entry,
                                              child: Text(
                                                entry,
                                                style: const TextStyle(
                                                    color: Color(0xff002D36),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      value: selectedMonth,
                                      onChanged: (nvalue) {
                                        setState(() {
                                          selectedMonth = nvalue;
                                          updateDaysInMonth(selectedMonth);
                                        });
                                      }),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.search_sharp,
                                    size: 30,
                                    color: Color(0xff5E7A7C),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),

                    //new calendar

                    SizedBox(
                      height: 150,
                      child: ListView(
                        children: [
                          CleanCalendar(
                            datePickerCalendarView:
                                DatePickerCalendarView.weekView,
                            enableDenseViewForDates: true,
                            enableDenseSplashForDates: true,
                            datesForStreaks: [
                              DateTime(2023, 01, 5),
                              DateTime(2023, 01, 6),
                              DateTime(2023, 01, 7),
                              DateTime(2023, 01, 9),
                              DateTime(2023, 01, 10),
                              DateTime(2023, 01, 11),
                              DateTime(2023, 01, 13),
                              DateTime(2023, 01, 20),
                              DateTime(2023, 01, 21),
                              DateTime(2023, 01, 23),
                              DateTime(2023, 01, 24),
                              DateTime(2023, 01, 25),
                            ],
                            dateSelectionMode:
                                DatePickerSelectionMode.singleOrMultiple,
                            onCalendarViewDate: (DateTime calendarViewDate) {
                              // print(calendarViewDate);
                            },
                            selectedDates: selectedDates,
                            onSelectedDates: (List<DateTime> value) {
                              setState(() {
                                if (selectedDates.contains(value.first)) {
                                  selectedDates.remove(value.first);
                                } else {
                                  selectedDates.add(value.first);
                                }
                              });
                              // print(selectedDates);
                            },
                          ),
                        ],
                      ),
                    ),

                    //

                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Divider(
                        thickness: 1.2,
                        color: Color(0xffCDD2D2),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 2, bottom: 10.0),
                      child:
                          Image.asset('assets/images/rocket.png', height: 180),
                    ),
                    // const SizedBox(height: 20),

                    const Text(
                      "You are off to a great start!",
                      style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          color: AppColors.appThemeColor,
                          letterSpacing: 1.2,
                          fontSize: 18),
                    ),

                    const SizedBox(height: 20),

                    const Center(
                      child: Text(
                        'This is a good sight! \nBut try to remember if there was some expenses you actually made but have forgotten to put in here',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "NeulisAlt",
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: AppColors.appThemeColor,
                            height: 1.2,
                            fontSize: 12),
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Padding(
                      padding: EdgeInsets.only(
                          left: 30, right: 30, top: 15, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              // height: 10,
                              width: 50,
                              child: Divider(
                                thickness: 1.5,
                                color: Color(0xff5E7A7C),
                                // indent: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            "Meanwhile, you could...",
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff202A2A),
                                // letterSpacing: 1.2,
                                fontSize: 13),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              // height: 10,
                              width: 50,
                              child: Divider(
                                thickness: 1.5,
                                color: Color(0xff5E7A7C),
                                // indent: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //
                    SizedBox(
                      height: 194,
                      child: ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              // height: 165,
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 8, bottom: 8),
                              decoration: BoxDecoration(
                                  color: const Color(0xffFDF8C5),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    //picture
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/images/moti_car.png',
                                          height: 100,
                                          width: 100,
                                        ),
                                        // const SizedBox(height: 12),
                                        const Text(''),
                                      ],
                                    ),

                                    //text & car tech button
                                    Column(
                                      children: [
                                        Container(
                                          height: 160,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.62,
                                          // color: Colors.red,
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8, bottom: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Text(
                                                  'Add the names of your trusted mechanics straight from your phone directory ',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily: 'NeulisAlt',
                                                    color:
                                                        AppColors.appThemeColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),

                                                const SizedBox(height: 8),

                                                //
                                                GestureDetector(
                                                  onTap: () {
                                                    showMoticarBottom(
                                                      context: context,
                                                      child:
                                                          const FractionallySizedBox(
                                                        heightFactor: 0.89,
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      20.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      20.0),
                                                            ),
                                                            child:
                                                                AddNewTechie()),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: const Text(
                                                        'Add Car Technician',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'NeulisAlt',
                                                          color: AppColors
                                                              .appThemeColor,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ]),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updateDaysInMonth(String? month) {
    if (month == null) return;
    int days = DateTime.now().month;
    switch (month) {
      case 'January':
      case 'March':
      case 'May':
      case 'July':
      case 'August':
      case 'October':
      case 'December':
        days = 31;
        break;
      case 'April':
      case 'June':
      case 'September':
      case 'November':
        days = 30;
        break;
      case 'February':
        days = DateTime.now().year % 4 == 0 ? 29 : 28;
        break;
    }
    setState(() {
      daysInMonth = List<int>.generate(days, (index) => index + 1);
    });
  }

  //notification
  void _showMyNotification(
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
        height: MediaQuery.of(context).size.height * 0.65,
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

                const SizedBox(height: 12),
                const Center(
                  child: Text(
                    'Notifications',
                    style: TextStyle(
                      fontFamily: "NeulisAlt",
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

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
                    child: const Center(
                      child: Text(
                        '- Today -',
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

                const SizedBox(height: 5),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'You have not logged in since 7 days',
                            style: TextStyle(
                              fontFamily: "NeulisAlt",
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          SvgPicture.asset('assets/svgs/delete.svg',
                              height: 25),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Not like we are watching and monitoring you. We just discovered you haven’t had any activitity in the past 5 days.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    thickness: 1,
                    color: Color(0xff001A1F),
                  ),
                ),

                //list of categories
                const SizedBox(height: 5),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xff00232A),
                      borderRadius: BorderRadius.circular(64),
                    ),
                    child: const Center(
                      child: Text(
                        '- Yesterday -',
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

                // Add your terms and conditions content here
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'You have not logged in since 7 days',
                            style: TextStyle(
                              fontFamily: "NeulisAlt",
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          SvgPicture.asset('assets/svgs/delete.svg',
                              height: 25),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Not like we are watching and monitoring you. We just discovered you haven’t had any activitity in the past 5 days.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    thickness: 1,
                    color: Color(0xff001A1F),
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

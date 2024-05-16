import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moticar/widgets/app_texts.dart';
import 'package:moticar/widgets/dashboard/navbar.dart';
import 'package:rive/rive.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../auth/add_car.dart';
import '../../models/expensesmodel.dart';
import '../../network/dio_utils.dart';
import '../../providers/app_providers.dart';
import '../../utils/enums.dart';
import '../../widgets/bottom_sheet_service.dart';
import '../../widgets/colors.dart';
import '../../widgets/eard_dialog.dart';
import '../../widgets/tabz.dart';
import '../../Home/bottom_bar.dart';
import '../../Home/profile/my_cars.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:intl/intl.dart';

class SpendPage extends StatefulHookConsumerWidget {
  const SpendPage({super.key});

  @override
  ConsumerState<SpendPage> createState() => _SpendPageState();
}

class _SpendPageState extends ConsumerState<SpendPage> {
  @override
  void initState() {
    super.initState();
    // _selectedDate = DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // ref.read(profileProvider.notifier).getExpenses(date: myDate);
      ref.read(profileProvider.notifier).getMyCars();
    });
  }

  List<Widget> myTab = const [
    // "Invited Events", 'My Events'
    Tabs(
      text: 'Show All',
    ),
    Tabs(
      text: 'By Car Technicians',
    ),
  ];

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

  bool isVisible = false;
  String selectedCarID = "";

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now(); // Get current date and time
    final day = now.day; // Extract the day of the month
    // Define suffixes for different days
    final suffixes = ["st", "nd", "rd"];
    suffixes
        .addAll(List.generate(20, (index) => "th")); // Handle days 4th to 23th
    // Handle days 24th to 31st
    final suffix = day > 23 ? suffixes[day - 24] : suffixes[day - 1];

    final state = ref.read(profileProvider);
    final model = ref.read(profileProvider.notifier);
    List<GetCarz> myCarz = state.getallCarz;

//     int getPricefromMonth(int month) {
//       final List<SprayedChart> transaction = state.receivedChart;

//       if (month >= 0 && month < transaction.length) {
//         final monthData = transaction[month].value;

//         // Assuming 'transaction' contains month names as keys (e.g., 'January', 'February', etc.)
//         // and numeric values as values
//         final monthNames = [
//           'January',
//           'February',
//           'March',
//           'April',
//           'May',
//           'June',
//           'July',
//           'August',
//           'September',
//           'October',
//           'November',
//           'December'
//         ];

//         if (month < monthNames.length) {
//           final monthName = monthNames[month];
//           final numericValue = monthData ?? 0;
//           return numericValue.toInt();
//         }
//       }

//       return 0; // Return a default value if the data is not found or if the indices are out of bounds
//     }

//     int getPriceSprayMonth(int month) {
//       final List<SprayedChart> transaction = state.sprayedchart;

//       if (month >= 0 && month < transaction.length) {
//         final monthData = transaction[month].value;

// //
//         final monthNames = [
//           'January',
//           'February',
//           'March',
//           'April',
//           'May',
//           'June',
//           'July',
//           'August',
//           'September',
//           'October',
//           'November',
//           'December'
//         ];

//         if (month < monthNames.length) {
//           final monthName = monthNames[month];
//           final numericValue = monthData ?? 0;
//           return numericValue.toInt();
//         }
//       }

//       return 0;
//       // Return a default value if the data is not found or if the indices are out of bounds
//     }

    final List<SalesData> receivedData = [
      SalesData(month: 'Jan', price: 3000), //getPricefromMonth(0)
      SalesData(month: 'Feb', price: 4001),
      SalesData(month: 'Mar', price: 10002),
      SalesData(month: 'Apr', price: 503),
      SalesData(month: 'May', price: 5004),
      SalesData(month: 'Jun', price: 505),
      SalesData(month: 'Jul', price: 500006),
      SalesData(month: 'Aug', price: 50007),
      SalesData(month: 'Sept', price: 5208),
      SalesData(month: 'Oct', price: 509),
      SalesData(month: 'Nov', price: 5001),
      SalesData(month: 'Dec', price: 51),
    ];

    final List<SalesData> sprayedData = [
      SalesData(month: 'Jan', price: 4000), //getPriceSprayMonth(0)
      SalesData(month: 'Feb', price: 50001),
      SalesData(month: 'Mar', price: 50002),
      SalesData(month: 'Apr', price: 50003),
      SalesData(month: 'May', price: 467),
      SalesData(month: 'Jun', price: 59),
      SalesData(month: 'Jul', price: 800),
      SalesData(month: 'Aug', price: 500),
      SalesData(month: 'Sept', price: 5008),
      SalesData(month: 'Oct', price: 509),
      SalesData(month: 'Nov', price: 501),
      SalesData(month: 'Dec', price: 5001),
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: AppColors.teal,
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //     //   return const AddExpensesPage(
          //     //       partImage: "",
          //     //       quantity: "",
          //     //       isDone: false,
          //     //       productName: "",
          //     //       carParts: "",
          //     //       amountz: "",
          //     //       conditionz: '',
          //     //       measure: '',
          //     //       brand: '');
          //     // }));
          //   },
          //   child: const Icon(
          //     Icons.add,
          //     color: AppColors.appThemeColor,
          //   ),
          // ),
          body: Column(
            children: [
              Navbar(),
              SizedBox(
                height: 10,
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
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Spend",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "NeulisAlt",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: AppColors.appThemeColor,
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
                          ),
                        ),

                        //
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 8, bottom: 2),
                          child: Container(
                            height: 65,
                            // padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: const Color(0xffDCE7E6),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: TabBar(
                              padding: const EdgeInsets.all(8),
                              indicator: BoxDecoration(
                                  color: AppColors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        blurRadius: 1, color: Colors.black38)
                                  ],
                                  border: Border.all(
                                      style: BorderStyle.solid,
                                      color: const Color(0xffDCE7E6)),
                                  borderRadius: BorderRadius.circular(32)),
                              labelColor: const Color(0xff00AEB5),
                              unselectedLabelColor: const Color(0xff006C70),
                              labelPadding: const EdgeInsets.all(2),
                              dividerColor: Colors
                                  .transparent, // Set divider color to transparent
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorPadding:
                                  const EdgeInsets.only(top: 2, bottom: 2),

                              tabs: myTab,
                            ),
                          ),
                        ),

                        const Padding(
                          padding:
                              EdgeInsets.only(left: 12, right: 12, bottom: 8),
                          child: Divider(
                            color: Color(0xffCDD2D2),
                          ),
                        ),

                        //tab contents for bothshow All and technicians
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.45,
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TabBarView(children: [
                                //show all tab
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            // state.result?.totalMoneySprayed != null
                                            //     ? nairaFormat.format(double.parse(
                                            //         state.result!.totalMoneySprayed
                                            //             .toString()))
                                            //     :
                                            "₦ 500,000",

                                            style: TextStyle(
                                                fontFamily: "NeulisAlt",
                                                fontSize: 25,
                                                color: Color(0xff001013),
                                                fontWeight: FontWeight.w600),
                                          ),

                                          //dropdown for monthz
                                          SizedBox(
                                            height: 40,
                                            width: 145,
                                            child: Container(
                                              // alignment: Alignment.center,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                color: const Color(0xffCDD2D2),
                                              ),
                                              child: DropdownButtonFormField<
                                                      String>(
                                                  // alignment: AlignmentDirectional.center,
                                                  icon: const Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                  ),
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: 'Select Month',
                                                    // fillColor: const Color(0xffCDD2D2),
                                                    hintStyle: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xff002D36)),
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                  ),
                                                  items: myMonthz
                                                      .map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                        (entry) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                          value: entry,
                                                          child: Text(
                                                            entry,
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xff002D36),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 13),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                  value: selectedMonth,
                                                  onChanged: (nvalue) {
                                                    setState(() {
                                                      selectedMonth = nvalue;
                                                      // updateDaysInMonth(selectedMonth);
                                                    });
                                                  }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.all(2),
                                      child: SfCartesianChart(
                                        primaryXAxis: CategoryAxis(
                                          // rangePadding: ChartRangePadding.round,
                                          majorGridLines:
                                              const MajorGridLines(width: 0),
                                          labelStyle: const TextStyle(
                                              fontFamily: "NeulisAlt",
                                              fontSize: 8,
                                              color: AppColors.textColor,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        primaryYAxis: NumericAxis(
                                          // rangePadding: ChartRangePadding.round,
                                          autoScrollingMode:
                                              AutoScrollingMode.start,
                                          // majorGridLines:
                                          //     const MajorGridLines(width: 1),
                                          // axisLine: const AxisLine(width: 1),
                                          labelStyle: const TextStyle(
                                              fontFamily: "NeulisAlt",
                                              fontSize: 8,
                                              color: AppColors.textColor,
                                              fontWeight: FontWeight.w400),
                                          labelFormat: 'N {value}',
                                        ),
                                        plotAreaBorderWidth: 0,
                                        series: <ChartSeries>[
                                          ColumnSeries<SalesData, String>(
                                            color: AppColors.appThemeColor,
                                            dataSource: sprayedData,
                                            xValueMapper: (SalesData data, _) =>
                                                data.month,
                                            yValueMapper: (SalesData data, _) =>
                                                data.price,
                                            dataLabelSettings:
                                                const DataLabelSettings(
                                              isVisible: false,
                                              labelAlignment:
                                                  ChartDataLabelAlignment.auto,
                                              textStyle: TextStyle(
                                                fontSize: 10,
                                                color: AppColors.textColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                //all tech tab
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            // state.result?.totalMoneySprayed != null
                                            //     ? nairaFormat.format(double.parse(
                                            //         state.result!.totalMoneySprayed
                                            //             .toString()))
                                            //     :
                                            "₦ 100,000",
                                            style: TextStyle(
                                                fontFamily: "NeulisAlt",
                                                fontSize: 25,
                                                color: Color(0xff001013),
                                                fontWeight: FontWeight.w600),
                                          ),

                                          //
                                          SizedBox(
                                            height: 40,
                                            width: 145,
                                            child: Container(
                                              // alignment: Alignment.center,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                color: const Color(0xffCDD2D2),
                                              ),
                                              child: DropdownButtonFormField<
                                                      String>(
                                                  // alignment: AlignmentDirectional.center,
                                                  icon: const Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                  ),
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: 'Select Month',
                                                    // fillColor: const Color(0xffCDD2D2),
                                                    hintStyle: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xff002D36)),
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                  ),
                                                  items: myMonthz
                                                      .map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                        (entry) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                          value: entry,
                                                          child: Text(
                                                            entry,
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xff002D36),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 13),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                  value: selectedMonth,
                                                  onChanged: (nvalue) {
                                                    setState(() {
                                                      selectedMonth = nvalue;
                                                      // updateDaysInMonth(selectedMonth);
                                                    });
                                                  }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.all(2),
                                      child: SfCartesianChart(
                                        primaryXAxis: CategoryAxis(
                                          // rangePadding: ChartRangePadding.round,
                                          majorGridLines:
                                              const MajorGridLines(width: 0),
                                          labelStyle: const TextStyle(
                                              fontFamily: "NeulisAlt",
                                              fontSize: 8,
                                              color: AppColors.textColor,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        primaryYAxis: NumericAxis(
                                          // rangePadding: ChartRangePadding.round,
                                          autoScrollingMode:
                                              AutoScrollingMode.start,
                                          // majorGridLines:
                                          //     const MajorGridLines(width: 1),
                                          // axisLine: const AxisLine(width: 1),
                                          labelStyle: const TextStyle(
                                              fontFamily: "NeulisAlt",
                                              fontSize: 8,
                                              color: AppColors.textColor,
                                              fontWeight: FontWeight.w400),
                                          labelFormat: 'N {value}',
                                        ),
                                        plotAreaBorderWidth: 0,
                                        series: <ChartSeries>[
                                          ColumnSeries<SalesData, String>(
                                            color: AppColors.appThemeColor,
                                            dataSource: receivedData,
                                            xValueMapper: (SalesData data, _) =>
                                                data.month,
                                            yValueMapper: (SalesData data, _) =>
                                                data.price,
                                            dataLabelSettings:
                                                const DataLabelSettings(
                                              isVisible: false,
                                              labelAlignment:
                                                  ChartDataLabelAlignment.auto,
                                              textStyle: TextStyle(
                                                  fontSize: 10,
                                                  color: AppColors.textColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                          ),
                        ),

                        //
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 4, bottom: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xffE0EAEA),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Divider(
                                    thickness: 1.5,
                                    color: AppColors.divider,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Summary of Spends",
                                  style: TextStyle(
                                      fontFamily: "NeulisAlt",
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff293536),
                                      letterSpacing: 1.5,
                                      fontSize: 10),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 1.5,
                                    color: AppColors.divider,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        //
                        SizedBox(
                          height: 300,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TimelineTile(
                                alignment: TimelineAlign.manual,
                                lineXY: 0.1,
                                // isFirst: true,
                                endChild: Container(
                                  // padding: EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                    minHeight: 60,
                                  ),
                                  color: Colors.transparent,
                                  child: const SpendTimeline(
                                      amountz: '250,000',
                                      expensePartz: 'Car Wash',
                                      entriez: '6'),
                                ),
                                // startChild: Container(
                                //   color: Colors.amberAccent,
                                // ),
                                hasIndicator: true,
                                indicatorStyle: IndicatorStyle(
                                  width: 40,
                                  height: 55,
                                  // color: Colors.purple,
                                  padding: const EdgeInsets.all(8),
                                  indicator: Column(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svgs/calendar.svg',
                                      ),
                                      Text(
                                        '$day$suffix', // Format day of the month (e.g., 15)
                                        style: const TextStyle(
                                            fontFamily: "NeulisAlt",
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff006C70)),
                                      ),
                                      Text(
                                        DateFormat('HH:mm').format(
                                            now), // Format time (e.g., 10:15)
                                        style: const TextStyle(
                                            fontFamily: "NeulisAlt",
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff006C70)),
                                      ),
                                    ],
                                  ),
                                  // iconStyle: IconStyle(
                                  //   color: Colors.white,
                                  //   iconData: Icons.insert_emoticon,
                                  // ),
                                ),
                              ),

                              //2nd
                              TimelineTile(
                                alignment: TimelineAlign.manual,
                                lineXY: 0.1,
                                // isFirst: true,
                                endChild: Container(
                                  // padding: EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                    minHeight: 60,
                                  ),
                                  color: Colors.transparent,
                                  child: const SpendTimeline(
                                      amountz: '20,000',
                                      expensePartz: 'Alignment',
                                      entriez: '2'),
                                ),
                                // startChild: Container(
                                //   color: Colors.amberAccent,
                                // ),
                                hasIndicator: true,
                                indicatorStyle: IndicatorStyle(
                                  width: 40,
                                  height: 55,
                                  color: Colors.cyan,
                                  padding: const EdgeInsets.all(8),
                                  indicator: Column(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svgs/calendar.svg',
                                      ),
                                      Text(
                                        '$day$suffix', // Format day of the month (e.g., 15)
                                        style: const TextStyle(
                                            fontFamily: "NeulisAlt",
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff006C70)),
                                      ),
                                      Text(
                                        DateFormat('HH:mm').format(
                                            now), // Format time (e.g., 10:15)
                                        style: const TextStyle(
                                            fontFamily: "NeulisAlt",
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff006C70)),
                                      ),
                                    ],
                                  ),
                                  // iconStyle: IconStyle(
                                  //   color: Colors.white,
                                  //   iconData: Icons.alarm_rounded,
                                  // ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //

                        const SizedBox(height: 50),

                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width - 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                                width: 1, color: const Color(0xff00343F)),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Export',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'NeulisAlt',
                                  color: AppColors.appThemeColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              SvgPicture.asset('assets/svgs/export.svg')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  //notifications:
  void _showMyNotification(context) {
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

class SpendTimeline extends StatelessWidget {
  const SpendTimeline({
    super.key,
    required this.amountz,
    required this.entriez,
    required this.expensePartz,
  });

  final String amountz, entriez, expensePartz;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //amount & no of entries
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "₦ $amountz",
                    style: const TextStyle(
                      fontFamily: 'NeulisAlt',
                      color: Color(0xff00232A),
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xff7AE6EB),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Text(
                      '$entriez entries',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'NeulisAlt',
                        color: Color(0xff006C70),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
                color: Color(0xff7BA0A3),
              )
            ],
          ),
        ),

        //
        //
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xff92BEC1),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Text(
              expensePartz,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'NeulisAlt',
                color: Color(0xff00232A),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SalesData {
  final String month;
  final int price;

  SalesData({required this.month, required this.price});
}

class EventData {
  final String label;
  final int count;

  EventData(this.label, this.count);
}
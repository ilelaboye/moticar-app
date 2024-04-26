// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// import '../../../widgets/colors.dart';
// import 'indicator_pie.dart';

// class PieChartSample2 extends StatefulWidget {
//   const PieChartSample2({super.key});

//   @override
//   State<StatefulWidget> createState() => PieChart2State();
// }

// class PieChart2State extends State {
//   int touchedIndex = -1;

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.3,
//       child: Row(
//         children: <Widget>[
//           const SizedBox(
//             height: 18,
//           ),
//           Expanded(
//             child: AspectRatio(
//               aspectRatio: 1,
//               child: PieChart(
//                 PieChartData(
//                   pieTouchData: PieTouchData(
//                     touchCallback: (FlTouchEvent event, pieTouchResponse) {
//                       setState(() {
//                         if (!event.isInterestedForInteractions ||
//                             pieTouchResponse == null ||
//                             pieTouchResponse.touchedSection == null) {
//                           touchedIndex = -1;
//                           return;
//                         }
//                         touchedIndex = pieTouchResponse
//                             .touchedSection!.touchedSectionIndex;
//                       });
//                     },
//                   ),
//                   borderData: FlBorderData(
//                     show: false,
//                   ),
//                   sectionsSpace: 0,
//                   centerSpaceRadius: 40,
//                   sections: showingSections(),
//                 ),
//               ),
//             ),
//           ),
//           const Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Indicator(
//                 color: AppColors.diaColor,
//                 text: 'First',
//                 isSquare: true,
//               ),
//               SizedBox(
//                 height: 4,
//               ),
//               Indicator(
//                 color: AppColors.yellow,
//                 text: 'Second',
//                 isSquare: true,
//               ),
//               SizedBox(
//                 height: 4,
//               ),
//               Indicator(
//                 color: AppColors.skipColor,
//                 text: 'Third',
//                 isSquare: true,
//               ),
//               SizedBox(
//                 height: 4,
//               ),
//               Indicator(
//                 color: AppColors.appThemeColor,
//                 text: 'Fourth',
//                 isSquare: true,
//               ),
//               SizedBox(
//                 height: 18,
//               ),
//             ],
//           ),
//           const SizedBox(
//             width: 28,
//           ),
//         ],
//       ),
//     );
//   }

//   List<PieChartSectionData> showingSections() {
//     return List.generate(4, (i) {
//       final isTouched = i == touchedIndex;
//       final fontSize = isTouched ? 25.0 : 16.0;
//       final radius = isTouched ? 60.0 : 50.0;
//       const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
//       switch (i) {
//         case 0:
//           return PieChartSectionData(
//             color: AppColors.diaColor,
//             value: 40,
//             title: '40%',
//             radius: radius,
//             titleStyle: TextStyle(
//               fontSize: fontSize,
//               fontWeight: FontWeight.bold,
//               color: AppColors.textColor,
//               shadows: shadows,
//             ),
//           );
//         case 1:
//           return PieChartSectionData(
//             color: AppColors.yellow,
//             value: 30,
//             title: '30%',
//             radius: radius,
//             titleStyle: TextStyle(
//               fontSize: fontSize,
//               fontWeight: FontWeight.bold,
//               color: AppColors.textColor,
//               shadows: shadows,
//             ),
//           );
//         case 2:
//           return PieChartSectionData(
//             color: AppColors.skipColor,
//             value: 15,
//             title: '15%',
//             radius: radius,
//             titleStyle: TextStyle(
//               fontSize: fontSize,
//               fontWeight: FontWeight.bold,
//               color: AppColors.textColor,
//               shadows: shadows,
//             ),
//           );
//         case 3:
//           return PieChartSectionData(
//             color: AppColors.appThemeColor,
//             value: 15,
//             title: '15%',
//             radius: radius,
//             titleStyle: TextStyle(
//               fontSize: fontSize,
//               fontWeight: FontWeight.bold,
//               color: AppColors.textColor,
//               shadows: shadows,
//             ),
//           );
//         default:
//           throw Error();
//       }
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:moticar/widgets/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/expensesmodel.dart';
import '../../../providers/app_providers.dart';
import '../../../utils/enums.dart';
import '../../../widgets/app_texts.dart';
import '../../../widgets/eard_loader.dart';

class PieChartSample2 extends StatefulHookConsumerWidget {
  const PieChartSample2({super.key});

  @override
  ConsumerState<PieChartSample2> createState() => _PieChartSample2State();
}

class _PieChartSample2State extends ConsumerState<PieChartSample2> {
  late List<GetExpenses> data;
  late TooltipBehavior _tooltip;

  String myDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    data = [
      // _ChartData('David', 5, AppColors.anotherYellow),
      // _ChartData('Keywork', 20, AppColors.yellow),
      // _ChartData('Fuel', 13, AppColors.diaColor),
      // _ChartData('Alignment', 25, AppColors.greyColor),
      // _ChartData('Servicing', 12, AppColors.appThemeColor)
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(profileProvider.notifier).getExpenses(date: myDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.read(profileProvider);
    final model = ref.read(profileProvider.notifier);
    List<GetExpenses> myTechies = state.getexpenses;

    return Column(
      children: [
        if (state.loading == Loader.loading)
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MoticarLoader(
                  size: 40,
                )
              ],
            ),
          )
        else if (myTechies.isNotEmpty)
          SfCircularChart(
            margin: EdgeInsets.all(1),

            // title: ChartTitle(text: 'Moticar'),
            // legend: const Legend(position: LegendPosition.bottom),

            // legendPosition: LegendPosition.bottom,
            tooltipBehavior: _tooltip,
            annotations: <CircularChartAnnotation>[
              // CircularChartAnnotation(
              //     widget: Container(
              //         child: PhysicalModel(
              //             child: Container(),
              //             shape: BoxShape.circle,
              //             elevation: 10,
              //             shadowColor: Colors.black,
              //             color: const Color.fromRGBO(230, 230, 230, 1)))
              //             ),
              CircularChartAnnotation(
                  widget: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Total Expense',
                              style: TextStyle(
                                  color: Color(0xff5E7A7C),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),

                          //
                          Text('N ${calculateTotalExpense(myTechies)}',
                              style: const TextStyle(
                                  // fontFamily: "NeulisAlt",
                                  color: Color(0xff006C70),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500)),
                        ],
                      )))
            ],
            series: <CircularSeries<GetExpenses, String>>[
              DoughnutSeries<GetExpenses, String>(
                dataSource: myTechies,
                pointColorMapper: (GetExpenses myTechies, _) =>
                    getImageColor(myTechies.category.toString()),
                xValueMapper: (GetExpenses myTechies, _) =>
                    myTechies.category.toString(),
                yValueMapper: (GetExpenses myTechies, _) =>
                    double.parse(myTechies.amount).toInt(),
                // name: 'Gold',
                innerRadius: '75%',
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
                  text: 'No Expenses Available',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontColor: AppColors.textColor,
                ),
              ],
            ),
          )
      ],
    );
  }

  int calculateTotalExpense(List<GetExpenses> expenses) {
    int total = 0;
    for (var expense in expenses) {
      total += double.parse(expense.total).toInt();
    }
    return total;
  }

  Color getImageColor(String category) {
    switch (category) {
      case 'Body works':
        return AppColors.anotherYellow; // Set color for bodywork category
      case 'Engine':
        return AppColors.diaColor; // Set color for engine category
      case 'Servicing':
        return const Color(0xff006C70);
      case 'Keywork':
        return AppColors.yellow;
      case 'Balancing':
      case 'Car Wash':
        return const Color(0xff00AEB5);
      case 'Dues':
        return const Color(0xff00AEB5);

      case 'Electronics':
        return const Color(0xff00AEB5);
      case 'Fuel':
        return const Color(0xffB8F2F4);
      case 'Hydraulics':
        return const Color(0xff00AEB5);
      case 'Alignment':
        return const Color(0xff29D7DE);

      case 'Tyre':
        return AppColors.textGrey;
      default:
        return AppColors
            .skipColor; // Default color if no specific color is available
    }
  }
}

// class _ChartData {
//   _ChartData(this.x, this.y, this.color);

//   final String x;
//   final double y;
//   final Color color;
// }

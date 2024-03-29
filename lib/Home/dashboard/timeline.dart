import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key});

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
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
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime endOfYear = DateTime(now.year + 1, 1, 1);
    int remainingDays = endOfYear.difference(now).inDays;
    return Scaffold(
      backgroundColor: AppColors.teal,
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: AppColors.appThemeColor,
        ),
      ),
      //  const Color(0xffEFF5F5),
      body: Column(
        children: [
          // top green screen
          Expanded(
            flex: 1,
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
            flex: 7,
            child: Container(
              decoration: const BoxDecoration(
                  color: Color(0xffEFF5F5),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                              Container(
                                alignment: Alignment.center,
                                width: 130,
                                height: 55,
                                child: Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color(0xffCDD2D2),
                                    ),
                                    child: DropdownButtonFormField<String>(
                                        alignment: AlignmentDirectional.center,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down_rounded),
                                        decoration: const InputDecoration(
                                          hintText: 'Select Month',
                                          // fillColor: const Color(0xffCDD2D2),
                                          hintStyle: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.textGrey),
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                        items: myMonthz
                                            .map<DropdownMenuItem<String>>(
                                              (entry) =>
                                                  DropdownMenuItem<String>(
                                                value: entry,
                                                child: Text(
                                                  entry,
                                                  style: const TextStyle(
                                                      color: Color(0xff002D36),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        value: selectedMonth,
                                        onChanged: (nvalue) {
                                          setState(() {
                                            selectedMonth = nvalue;
                                          });
                                        }),
                                  ),
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
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Expanded(
                        child: Divider(
                          thickness: 1.2,
                          color: Color(0xffCDD2D2),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Image.asset('assets/images/rocket.png'),
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
                          Expanded(
                            child: Divider(
                              thickness: 1.5,
                              color: Color(0xff5E7A7C),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Meanwhile, you could....",
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff202A2A),
                                letterSpacing: 1.2,
                                fontSize: 12),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1.5,
                              color: Color(0xff5E7A7C),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //
                    SizedBox(
                      height: 175,
                      child: ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 160,
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 12),
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
                                          color: Colors.transparent,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0,
                                                right: 8,
                                                bottom: 15),
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

                                                // const SizedBox(height: 10),

                                                //
                                                Container(
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
                                                        fontFamily: 'NeulisAlt',
                                                        color: AppColors
                                                            .appThemeColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                )
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

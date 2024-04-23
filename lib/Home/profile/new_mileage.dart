import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../services/hivekeys.dart';
import '../../services/localdatabase.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';

class NewMileage extends StatefulWidget {
  const NewMileage({super.key});

  @override
  State<NewMileage> createState() => _NewMileageState();
}

class _NewMileageState extends State<NewMileage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeef5f5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "motiBuddie",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "NeulisAlt",
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: AppColors.appThemeColor,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Mileage Tracker",
                        style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          color: AppColors.appThemeColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),

                      //showDialog here
                      GestureDetector(
                        onTap: () {
                          // showDialog(
                          //   builder: (context) {
                          //     return AlertDialog(
                          //       backgroundColor: Colors
                          //           .transparent, // Make the background transparent
                          //       contentPadding: EdgeInsets
                          //           .zero, // Remove any default padding
                          //       shape:
                          //           const RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.only(
                          //           bottomLeft:
                          //               Radius.circular(10),
                          //           bottomRight:
                          //               Radius.circular(10),
                          //         ),
                          //       ),
                          //       content: ClipRRect(
                          //         // Clip content to match the dialog's shape
                          //         borderRadius:
                          //             const BorderRadius.only(
                          //           bottomLeft:
                          //               Radius.circular(10),
                          //           bottomRight:
                          //               Radius.circular(10),
                          //         ),
                          //         child: Container(
                          //           color: Colors.white,
                          //           child: Column(
                          //             mainAxisSize:
                          //                 MainAxisSize.min,
                          //             children: [
                          //               Row(
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment
                          //                         .end,
                          //                 children: [
                          //                   IconButton(
                          //                     icon: const Icon(Icons
                          //                         .close), // Close icon
                          //                     onPressed: () {
                          //                       Navigator.of(
                          //                               context)
                          //                           .pop(); // Close the dialog
                          //                     },
                          //                   ),
                          //                 ],
                          //               ),
                          //               Image.asset(
                          //                   'assets/images/car_diagram.png'),
                          //               Container(
                          //                 padding:
                          //                     const EdgeInsets
                          //                         .only(
                          //                         top: 15,
                          //                         bottom: 15,
                          //                         left: 8,
                          //                         right: 8),
                          //                 color: const Color(
                          //                     0xffece6b7),
                          //                 child: const Padding(
                          //                   padding: EdgeInsets
                          //                       .symmetric(
                          //                           vertical: 8),
                          //                   child: Text(
                          //                     "Gear Box",
                          //                     textAlign: TextAlign
                          //                         .center,
                          //                     style: TextStyle(
                          //                       fontFamily:
                          //                           "NeulisAlt",
                          //                       fontSize: 14,
                          //                       fontStyle:
                          //                           FontStyle
                          //                               .normal,
                          //                       height: 1.2,
                          //                       fontWeight:
                          //                           FontWeight
                          //                               .w400,
                          //                       color: AppColors
                          //                           .appThemeColor,
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //     );
                          //   },
                          //   context: context,
                          // );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          // height: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: AppColors.lightGreen),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Icon(Icons.question_mark_rounded,
                              size: 13, color: AppColors.lightGreen),
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
                    ],
                  ),

                  //
                  const SizedBox(
                    height: 8,
                  ),
                  // sub
                  const Text(
                    "Keep an eye on how much distance your car has covered over time.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "NeulisAlt",
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff667085),
                      fontSize: 12,
                    ),
                  ),

                  //
                  const SizedBox(
                    height: 12,
                  ),
                  //

                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xffF8F6E7),
                      // Color(0xffeef5f5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      children: [
                        //info & image
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Info",
                              style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff293536),
                                fontSize: 14,
                              ),
                            ),
                            SvgPicture.asset('assets/images/speedometer-02.svg')
                          ],
                        ),

                        //
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              // "1324567",
                              HiveStorage.get(HiveKeys.mileage) ?? "18101",
                              style: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff006C70),
                                fontSize: 57,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 4, bottom: 4),
                                  decoration: BoxDecoration(
                                      color: const Color(0xff7AE6EB),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: const Text(
                                    "6 entries",
                                    style: TextStyle(
                                      fontFamily: "NeulisAlt",
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff006C70),
                                      fontSize: 11,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 2,
                                ),

                                //last entry
                                const Text(
                                  "Last entry: 12.09.24",
                                  style: TextStyle(
                                    fontFamily: "NeulisAlt",
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff006C70),
                                    fontSize: 11,
                                  ),
                                ),

                                Row(
                                  children: [
                                    const Text(
                                      "aprrox. 269km",
                                      style: TextStyle(
                                        fontFamily: "NeulisAlt",
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff006C70),
                                        fontSize: 11,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      height: 34,
                                      width: 34,
                                      // padding: const EdgeInsets.all(8),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: AppColors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: const Center(
                                        child: Icon(
                                          Icons.add,
                                          color: AppColors.appThemeColor,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 35,
                  ),

                  //reminders
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Reminders",
                        style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          color: AppColors.appThemeColor,
                          fontSize: 16,
                        ),
                      ),

                      //
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

                  //
                  const SizedBox(
                    height: 8,
                  ),

                  const Text(
                    "Never be late to attend to issues or concerns surrounding your car. Schedule reminders and keep revisions, maintenance and payments up to date.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "NeulisAlt",
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff667085),
                      fontSize: 12,
                    ),
                  ),

                  //others
                ],
              ),
            ),

            //

            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MileageBoards(
                      onTap: () {
                        // Navigator
                      },
                      imagePath: "assets/images/toll_free.svg",
                      mileageCount: "5",
                      mileageType: "Toll Fee",
                    ),
                  ),
                  //
                  Expanded(
                    child: MileageBoards(
                      onTap: () {
                        // Navigator
                      },
                      imagePath: "assets/images/serVic.svg",
                      mileageCount: "2",
                      mileageType: "Servicing",
                    ),
                  ),
                ],
              ),
            ),

            //
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MileageBoards(
                      onTap: () {
                        // Navigator
                      },
                      imagePath: "assets/images/dues_levels.svg",
                      mileageCount: "4",
                      mileageType: "Dues & Levels",
                    ),
                  ),
                  //
                  Expanded(
                    child: MileageBoards(
                      onTap: () {
                        // Navigator
                      },
                      imagePath: "assets/images/penalties.svg",
                      mileageCount: "0",
                      mileageType: "Penalties",
                    ),
                  ),
                ],
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MileageBoards(
                      onTap: () {
                        // Navigator
                      },
                      imagePath: "assets/images/trips.svg",
                      mileageCount: "6",
                      mileageType: "Planned Trips",
                    ),
                  ),
                  //
                  Expanded(
                    child: MileageBoards(
                      onTap: () {
                        // Navigator
                      },
                      imagePath: "assets/images/penalties.svg",
                      mileageCount: "8",
                      mileageType: "Others",
                    ),
                  ),
                ],
              ),
            ),

            //
            const SizedBox(
              height: 30,
            ),

            //expense statements
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Expense Statements",
                        style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          color: AppColors.appThemeColor,
                          fontSize: 16,
                        ),
                      ),

                      //
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
                  SizedBox(
                    height: 8,
                  ),

                  Text(
                    "Never be late to attend to issues or concerns surrounding your car. Schedule reminders and keep revisions, maintenance and payments up to date.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "NeulisAlt",
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff667085),
                      fontSize: 12,
                    ),
                  ),

                  //
                ],
              ),
            ),

            // exports
            ListTile(
              leading: SvgPicture.asset('assets/images/pdf-02.svg'),
              title: const Text(
                "Export Analytics",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "NeulisAlt",
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  color: AppColors.appThemeColor,
                  fontSize: 16,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xff7BA0A3),
                size: 15,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15.0, top: 1),
              child: Divider(
                thickness: 0.5,
                color: Color(0xff7BA0A3),
              ),
            ),

            const SizedBox(
              height: 50,
            ),

            //sell your car
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sell your car",
                        style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          color: AppColors.appThemeColor,
                          fontSize: 16,
                        ),
                      ),

                      //
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
                  SizedBox(
                    height: 8,
                  ),

                  Text(
                    "Your records on moticar shows how much care you have given to your car. Support your car valuation with records you have gotten so far.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "NeulisAlt",
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff667085),
                      fontSize: 12,
                    ),
                  ),

                  //
                ],
              ),
            ),

            // exports
            ListTile(
              leading: SvgPicture.asset('assets/images/key-02.svg'),
              title: const Text(
                "Prepare car handover",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "NeulisAlt",
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  color: AppColors.appThemeColor,
                  fontSize: 16,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xff7BA0A3),
                size: 15,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15.0, top: 1),
              child: Divider(
                thickness: 0.5,
                color: Color(0xff7BA0A3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MileageBoards extends StatelessWidget {
  const MileageBoards({
    super.key,
    required this.imagePath,
    required this.mileageType,
    required this.mileageCount,
    this.onTap,
  });
  final String imagePath, mileageType, mileageCount;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 180,
          height: 160,
          padding: const EdgeInsets.all(3),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xffB8F2F4),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 4, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MoticarText(
                        text: mileageType,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontColor: const Color(0xff293536)),
                    MoticarText(
                        text: mileageCount,
                        fontSize: 70,
                        fontWeight: FontWeight.w500,
                        fontColor: const Color(0xff00AEB5)),
                  ],
                ),

                //
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(imagePath),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 15.0),
                      child: Icon(
                        Icons.add,
                        size: 30,
                        color: Color(0xff00AEB5),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

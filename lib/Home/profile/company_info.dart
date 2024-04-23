import 'package:flutter/material.dart';

import '../../widgets/colors.dart';
import 'terms_policies.dart';

class ComapnyInfoPage extends StatefulWidget {
  const ComapnyInfoPage({super.key});

  @override
  State<ComapnyInfoPage> createState() => _ComapnyInfoPageState();
}

class _ComapnyInfoPageState extends State<ComapnyInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEF5F5),
      appBar: AppBar(
        title: const Text(
          "Company Information",
          style: TextStyle(
            fontFamily: "NeulisAlt",
            fontSize: 16,
            fontStyle: FontStyle.normal,
            color: AppColors.white,
            fontWeight: FontWeight.w500,
          ),
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              // flex: 10,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Company Information",
                        style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          color: AppColors.lightGreen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),

                      Padding(
                        padding:
                            EdgeInsets.only(right: 8.0, top: 12, bottom: 8),
                        child: Text(
                          "moticar is a web application that provides a simple and yet effective way to track all your vehicle related expenses (refuels, maintenance, repairs) from anywhere and anytime.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'NeulisAlt',
                            color: AppColors.appThemeColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: 8.0, top: 12, bottom: 8),
                        child: Text(
                          "Additionally, you can keep track all your trips. A variety of reports is available for analysis. The service supports imperial and metric units, and allows to use different currencies so it is easy to travel between different countries!",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'NeulisAlt',
                            color: AppColors.appThemeColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 8,
                      ),

                      Padding(
                        padding:
                            EdgeInsets.only(right: 8.0, top: 12, bottom: 8),
                        child: Text(
                          "It is so simple that you have to just keep track of all expenses you incur and we can provide you the insights you need for taking money saving decisions.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'NeulisAlt',
                            color: AppColors.appThemeColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                      Padding(
                        padding:
                            EdgeInsets.only(right: 8.0, top: 12, bottom: 8),
                        child: Text(
                          "You can add mileage and time based reminders for recurring car related actions, e.g. general inspection once a year.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'NeulisAlt',
                            color: AppColors.appThemeColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                      Padding(
                        padding:
                            EdgeInsets.only(right: 8.0, top: 12, bottom: 8),
                        child: Text(
                          "It offers synchronization with webdav and has basic backup/restore and CSV import/export functions.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'NeulisAlt',
                            color: AppColors.appThemeColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                      ////
                      SizedBox(
                        height: 15,
                      ),
                      //others
                      Text(
                        "Features",
                        style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          color: AppColors.lightGreen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),

                      //
                      NewMotInfo(
                        title: "Refuels",
                        subz:
                            "Feel free to track vehicle's refuels and take note of the fuel economy.Enjoy your ride!",
                      ),
                      NewMotInfo(
                        title: "Expenses",
                        subz:
                            "Stop spending blindly! Now you can track your expenses (oil change, repair, parking, etc.) with just a few clicks!",
                      ),
                      NewMotInfo(
                        title: "Checkpoints",
                        subz:
                            "Tracking mileage is hard, right? Not anymore! Save events and location info, track your mileage and save time!",
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //version
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "App version: 1.029.123",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "NeulisAlt",
                    fontSize: 10,
                    fontStyle: FontStyle.normal,
                    color: Color(0xffC1C3C3),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//
class NewMotInfo extends StatelessWidget {
  const NewMotInfo({
    super.key,
    required this.title,
    required this.subz,
  });
  final String title, subz;
  // final WorMode items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontFamily: 'NeulisAlt',
              color: AppColors.appThemeColor,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 6, bottom: 8),
            child: Text(
              subz,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontFamily: 'NeulisAlt',
                color: AppColors.appThemeColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

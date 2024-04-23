import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moticar/models/menu_items.dart';
import 'package:moticar/widgets/app_texts.dart';

import '../../widgets/colors.dart';
import 'email_sub.dart';

class NotifyMotPage extends StatefulWidget {
  const NotifyMotPage({super.key});

  @override
  State<NotifyMotPage> createState() => _NotifyMotPageState();
}

class _NotifyMotPageState extends State<NotifyMotPage> {
  bool muteZ = false;
  bool priceX = false;
  bool weeklY = false;

  @override
  Widget build(BuildContext context) {
    List<AppMenuItem> menuItems = [
      //
      AppMenuItem(
        title: 'Mute all Push Notifications',
        subTitle: "Only if you are not interested in any notifications at all",
        icon: ' ',
        leading: Transform.scale(
          scale: 0.6,
          child: CupertinoSwitch(
            value: muteZ,
            // state.hasEnabledBiometricLogin,
            onChanged: (value) {
              setState(() {
                muteZ = !muteZ;
              });
              // model.enableBiometricLogin(value);
            },
            activeColor: AppColors.yellow,
          ),
        ),
      ),

      //remind
      AppMenuItem(
        title: 'Price change in items listed',
        subTitle: "Let me know when the price of items changes",
        icon: ' ',
        leading: Transform.scale(
          scale: 0.6,
          child: CupertinoSwitch(
            value: priceX,
            // state.hasEnabledBiometricLogin,
            onChanged: (value) {
              setState(() {
                priceX = !priceX;
              });
              // model.enableBiometricLogin(value);
            },
            activeColor: AppColors.yellow,
          ),
        ),
      ),

      //marke
      AppMenuItem(
        title: 'Weekly Car Maintenance Tips',
        subTitle: "Let me know when the price of items changes",
        icon: ' ',
      ),
    ];
    return Scaffold(
      backgroundColor: const Color(0xffEEF5F5),
      appBar: AppBar(
        title: const Text(
          "Notification Settings",
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      ListTile(
                        onTap: () {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return const ChangePassPage();
                          // }));
                        },
                        leading: Transform.scale(
                          scale: 0.6,
                          child: CupertinoSwitch(
                            value: muteZ,
                            // state.hasEnabledBiometricLogin,
                            onChanged: (value) {
                              setState(() {
                                muteZ = !muteZ;
                              });
                              // model.enableBiometricLogin(value);
                            },
                            activeColor: AppColors.yellow,
                          ),
                        ),
                        title: const Text(
                          'Mute all Push Notifications',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff293536),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: const Text(
                          'Only if you are not interested in any notifications at all',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff667085),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        // ignore: prefer_if_null_operators
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

                      //price
                      ListTile(
                        onTap: () {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return const ChangePassPage();
                          // }));
                        },
                        leading: Transform.scale(
                          scale: 0.6,
                          child: CupertinoSwitch(
                            value: priceX,
                            // state.hasEnabledBiometricLogin,
                            onChanged: (value) {
                              setState(() {
                                priceX = !priceX;
                              });
                              // model.enableBiometricLogin(value);
                            },
                            activeColor: AppColors.yellow,
                          ),
                        ),
                        title: const Text(
                          'Price Changed in items listed',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff293536),
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        subtitle: const Text(
                          'Let me know when the price of items changes',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff667085),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        // ignore: prefer_if_null_operators
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

                      //
                      ListTile(
                        onTap: () {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return const ChangePassPage();
                          // }));
                        },
                        leading: Transform.scale(
                          scale: 0.6,
                          child: CupertinoSwitch(
                            value: weeklY,
                            // state.hasEnabledBiometricLogin,
                            onChanged: (value) {
                              setState(() {
                                weeklY = !weeklY;
                              });
                              // model.enableBiometricLogin(value);
                            },
                            activeColor: AppColors.yellow,
                          ),
                        ),
                        title: const Text(
                          'Weekly Car Maintenance Tips',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff293536),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: const Text(
                          'Let me know when the price of items changes',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff667085),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        // ignore: prefer_if_null_operators
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
              ),
            ),

            //version
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
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

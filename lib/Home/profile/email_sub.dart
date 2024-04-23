import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moticar/models/menu_items.dart';
import 'package:moticar/widgets/app_texts.dart';

import '../../widgets/colors.dart';

class EmailSubPage extends StatefulWidget {
  const EmailSubPage({super.key});

  @override
  State<EmailSubPage> createState() => _EmailSubPageState();
}

class _EmailSubPageState extends State<EmailSubPage> {
  bool offerz = false;
  bool remind = false;
  bool insights = false;
  bool featurez = false;
  bool subPlanz = false;

  @override
  Widget build(BuildContext context) {
    List<AppMenuItem> menuItems = [
      //
      AppMenuItem(
        title: 'Marketing Offers & Promos',
        subTitle: "Only tailored deals you might like",
        icon: ' ',
        leading: Transform.scale(
          scale: 0.6,
          child: CupertinoSwitch(
            value: offerz,
            // state.hasEnabledBiometricLogin,
            onChanged: (value) {
              setState(() {
                offerz = !offerz;
              });
              // model.enableBiometricLogin(value);
            },
            activeColor: AppColors.yellow,
          ),
        ),
      ),

      //remind
      AppMenuItem(
        title: 'Reminders',
        subTitle: "Only necessary information that you need of now",
        icon: ' ',
        leading: Transform.scale(
          scale: 0.6,
          child: CupertinoSwitch(
            value: remind,
            // state.hasEnabledBiometricLogin,
            onChanged: (value) {
              setState(() {
                remind = !remind;
              });
              // model.enableBiometricLogin(value);
            },
            activeColor: AppColors.yellow,
          ),
        ),
      ),

      //marke
      AppMenuItem(
        title: 'Marketing Insights',
        subTitle:
            "Get informed analysis on how best to spend money on ypur car",
        icon: ' ',
        leading: Transform.scale(
          scale: 0.6,
          child: CupertinoSwitch(
            value: insights,
            // state.hasEnabledBiometricLogin,
            onChanged: (value) {
              setState(() {
                insights = !insights;
              });
              // model.enableBiometricLogin(value);
            },
            activeColor: AppColors.yellow,
          ),
        ),
      ),

      //features
      AppMenuItem(
        title: 'App Features',
        subTitle:
            "Everytime we release a new feature, you are among the first to know",
        icon: ' ',
        leading: Transform.scale(
          scale: 0.6,
          child: CupertinoSwitch(
            value: featurez,
            // state.hasEnabledBiometricLogin,
            onChanged: (value) {
              setState(() {
                featurez = !featurez;
              });
              // model.enableBiometricLogin(value);
            },
            activeColor: AppColors.yellow,
          ),
        ),
      ),

      //member
      AppMenuItem(
        title: 'Membership subscription plans',
        subTitle:
            "We can let you know how many days left before your next renewal",
        icon: ' ',
        leading: Transform.scale(
          scale: 0.6,
          child: CupertinoSwitch(
            value: subPlanz,
            // state.hasEnabledBiometricLogin,
            onChanged: (value) {
              setState(() {
                subPlanz = !subPlanz;
              });
              // model.enableBiometricLogin(value);
            },
            activeColor: AppColors.yellow,
          ),
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: const Color(0xffEEF5F5),
      appBar: AppBar(
        title: const Text(
          "How does it work?",
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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color(0xffECE6B7),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "All mails are sent to",
                          style: TextStyle(
                            fontFamily: "NeulisAlt",
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            color: Color(0xff293536),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "bamideleakeem@gmail.com",
                          style: TextStyle(
                            fontFamily: "NeulisAlt",
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            color: AppColors.appThemeColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //
                  Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.all(0.3),
                          child: Divider(
                            thickness: 1.2,
                            color: Color(0xffCDD2D2),
                          ),
                        );
                      },
                      itemCount: menuItems.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return SubList(items: menuItems[index]);
                      },
                    ),
                  ),

                  const Padding(
                    padding: const EdgeInsets.all(2),
                    child: Divider(
                      thickness: 1.2,
                      color: Color(0xffCDD2D2),
                    ),
                  )
                ],
              ),

              //version
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
        ),
      ),
    );
  }
}

class SubList extends StatelessWidget {
  const SubList({super.key, required this.items});
  final AppMenuItem items;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(1),
      leading: items.leading,
      title: Text(
        items.title,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontFamily: 'NeulisAlt',
          color: Color(0xff293536),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        items.subTitle.toString(),
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontFamily: 'NeulisAlt',
          color: Color(0xff667085),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

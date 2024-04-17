import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moticar/widgets/app_texts.dart';

import '../../widgets/colors.dart';

class HowWorks extends StatefulWidget {
  const HowWorks({super.key});

  @override
  State<HowWorks> createState() => _HowWorksState();
}

class _HowWorksState extends State<HowWorks> {
  List<WorMode> menuItems = [
    //
    WorMode(
      subz: "Once you're logged into Moticar, navigate to the "
          "Refer a Friend"
          " section to generate your unique referral link. Share it with friends via social media, messaging apps, or good old-fashioned word of mouth",
      title: 'Share Your Unique Referral Link',
    ),

    WorMode(
        subz:
            "When your friend clicks on your referral link and signs up for Moticar, they instantly become part of the community.",
        title: "Your Friend Joins Moticar"),

    WorMode(
        subz:
            "As your friend explores the features of Moticar, both of you will start reaping the rewards. From enhanced app features to exclusive discounts on vehicle services, the benefits keep rolling in.",
        title: "Earn Rewards Together"),
  ];
  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "How Does It Work?",
                    style: TextStyle(
                      fontFamily: "NeulisAlt",
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      color: AppColors.lightGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  //
                  Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height * 0.38,
                    child: ListView.builder(
                      itemCount: menuItems.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return WorkList(items: menuItems[index]);
                      },
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 28.0),
                    child: Divider(
                      thickness: 1.2,
                      color: Color(0xffCDD2D2),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Text(
                      "Ready to transform the way you and your friends manage your vehicles? Start referring today and embark on a journey of seamless car ownership with Moticar. Every referral brings you and your friends closer to a smarter, more connected automotive future.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'NeulisAlt',
                        color: AppColors.textColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(right: 8.0, top: 15),
                    child: Text(
                      "Join Moticar, where vehicle management becomes an adventure worth sharing! 🚗💨 #MoticarAdventures #ReferAFriend",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'NeulisAlt',
                        color: AppColors.textColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
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

class WorMode {
  final String subz, title;

  WorMode({required this.subz, required this.title});
}

class WorkList extends StatelessWidget {
  const WorkList({super.key, required this.items});
  final WorMode items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            items.title,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontFamily: 'NeulisAlt',
              color: AppColors.textColor,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              items.subz,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontFamily: 'NeulisAlt',
                color: AppColors.textColor,
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

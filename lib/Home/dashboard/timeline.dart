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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFF5F5),
      body: Column(
        children: [
          const Center(
            child: Text('Timeline Page'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: const Color(0xffFDF8C5),
                borderRadius: BorderRadius.circular(8)),
            child: Row(children: [
              SvgPicture.asset('assets/svgs/time_car.svg'),
              Column(
                children: [
                  const MoticarText(
                    fontColor: AppColors.appThemeColor,
                    text: 'Finish',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const MoticarText(
                      fontColor: AppColors.appThemeColor,
                      text: 'Finish',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              )
            ]),
          )
        ],
      ),
    );
  }
}

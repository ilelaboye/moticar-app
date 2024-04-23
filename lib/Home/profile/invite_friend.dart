import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moticar/widgets/app_texts.dart';

import '../../widgets/colors.dart';
import 'how_works.dart';

class InviteFriend extends StatefulWidget {
  const InviteFriend({super.key});

  @override
  State<InviteFriend> createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEF5F5),
      appBar: AppBar(
        title: const Text(
          "Invite Friend",
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
                    "Extend the joy of knowledge sharing",
                    style: TextStyle(
                      fontFamily: "NeulisAlt",
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      color: AppColors.lightGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  //
                  const SizedBox(height: 20),
                  const Text(
                    "Revolutionize the way you and your friends manage your vehicles with Moticar, the ultimate application for personal vehicle management! We believe in the power of shared experiences, and what better way to enhance your automotive journey than by inviting your friends to join the Moticar community?",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "NeulisAlt",
                      fontSize: 12,
                      fontStyle: FontStyle.normal,
                      color: AppColors.appThemeColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  //
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const HowWorks();
                      }));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "How does it works",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: "NeulisAlt",
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            color: AppColors.appThemeColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded,
                            size: 20, color: Color(0xff7BA0A3))
                      ],
                    ),
                  ),

                  //divider

                  const Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 28.0),
                    child: Divider(
                      thickness: 1.2,
                      color: Color(0xffCDD2D2),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: const Color(0xffECE6B7),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(''),
                        const Text(
                          "MOTICAR",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: "NeulisAlt",
                            fontSize: 34,
                            fontStyle: FontStyle.normal,
                            color: AppColors.appThemeColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SvgPicture.asset('assets/images/copy_sign.svg'),
                      ],
                    ),
                  ),

                  //share
                  const SizedBox(height: 40),
                  MoticarLoginButton(
                    borderColor: AppColors.greyColor,
                    myColor: AppColors.greyColor,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Share",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: "NeulisAlt",
                            fontSize: 14,
                            fontStyle: FontStyle.normal,
                            color: AppColors.appThemeColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(Icons.share_rounded,
                            size: 20, color: Color(0xff101828))
                      ],
                    ),
                    onTap: () {},
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

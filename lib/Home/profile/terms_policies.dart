import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moticar/widgets/app_texts.dart';

import '../../widgets/colors.dart';

class TermsPoliciesPage extends StatefulWidget {
  const TermsPoliciesPage({super.key});

  @override
  State<TermsPoliciesPage> createState() => _TermsPoliciesPageState();
}

class _TermsPoliciesPageState extends State<TermsPoliciesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEF5F5),
      appBar: AppBar(
        title: const Text(
          "Terms & Policies",
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
                      Text(
                        "Introduction",
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
                          "Welcome to Moticar, your trusted companion for managing vehicles in the vibrant Nigerian market. Before embarking on the journey of streamlined vehicle management with Moticar, we want to ensure that you are well-informed about our terms and policies. By using the Moticar application, you agree to abide by the following terms and guidelines:",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'NeulisAlt',
                            color: AppColors.appThemeColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),

                      Text(
                        "User Responsibilities",
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
                      TermsWidget(
                        title: "Accurate Information",
                        subz:
                            "Users are responsible for providing accurate and up-to-date information about their vehicles for effective management within the Moticar application.",
                      ),
                      TermsWidget(
                        title: "Account Security",
                        subz:
                            "Users must keep their login credentials secure. Any activity under a user's account is their responsibility.",
                      ),

                      //
                      SizedBox(
                        height: 18,
                      ),

                      Text(
                        "Data usuage & privacy",
                        style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          color: AppColors.lightGreen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      //
                      TermsWidget(
                        title: "Data Security",
                        subz:
                            "Moticar prioritizes the security of your data. All information provided is stored and transmitted securely to protect your privacy. Rest assured, your data is treated with the highest standards of confidentiality and security.",
                      ),
                      TermsWidget(
                        title: "Anonymous Data",
                        subz:
                            "Moticar may collect anonymized data for analytical purposes to enhance user experience and improve the application's functionality.",
                      ),

                      //service usage
                      SizedBox(
                        height: 18,
                      ),

                      Text(
                        "Service Usuage",
                        style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          color: AppColors.lightGreen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      //
                      TermsWidget(
                        title: "Vehicle Management",
                        subz:
                            "Moticar is designed for personal use to facilitate efficient control over fueling, maintenance, oil changes, and other essential services related to your vehicle.",
                      ),
                      TermsWidget(
                        title: "Third Party Services",
                        subz:
                            "Moticar may integrate with third-party services for added functionality. Users are subject to the terms and policies of these external services.",
                      ),

                      //payments
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        "Payments & Subscriptions",
                        style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          color: AppColors.lightGreen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TermsWidget(
                        title: "Subscriptions Plans",
                        subz:
                            "Users opting for premium features are subject to the terms of their chosen subscription plan. Payment details are handled securely by our trusted payment partners.",
                      ),
                      TermsWidget(
                        title: "Cancellation and Refunds",
                        subz:
                            "Users can cancel their subscription at any time, but refunds may be subject to the terms outlined in our refund policy.",
                      ),

                      //Termination service
                      SizedBox(
                        height: 18,
                      ),

                      Text(
                        "Termination of Service",
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
                          "Moticar reserves the right to terminate or suspend service to users who violate our terms of use or engage in any behavior that compromises the integrity of the application.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'NeulisAlt',
                            color: AppColors.appThemeColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                      //use cookies
                      SizedBox(
                        height: 18,
                      ),

                      Text(
                        "Use of Cookies",
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
                          "Moticar utilizes cookies to enhance your user experience. Our Cookie Policy provides insights into how we use cookies, what information they gather, and how you can manage your cookie preferences.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'NeulisAlt',
                            color: AppColors.appThemeColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                      //change terms n policy
                      SizedBox(
                        height: 18,
                      ),

                      Text(
                        "Changes to Terms & Policies",
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
                          "Moticar may update its terms and policies periodically. Users will be notified of any changes, and continued use of the application implies acceptance of the updated terms.",
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
                        padding: EdgeInsets.only(top: 8, bottom: 28.0),
                        child: Divider(
                          thickness: 1.2,
                          color: Color(0xffCDD2D2),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Text(
                          "If you have any questions or concerns regarding our terms and policies, please reach out to us at contact@moticar.com.",
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
                        padding: EdgeInsets.only(right: 8.0, top: 15),
                        child: Text(
                          "Thank you for choosing Moticar to manage your vehicle. Let's drive together into a future of efficient and hassle-free vehicle management!",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'NeulisAlt',
                            color: AppColors.appThemeColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
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

class TermsWidget extends StatelessWidget {
  const TermsWidget({
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
            padding: const EdgeInsets.only(right: 8.0, top: 12, bottom: 8),
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

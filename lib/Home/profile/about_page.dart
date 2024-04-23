import 'package:flutter/material.dart';
import '../../widgets/colors.dart';
import 'company_info.dart';

class AboutMoticarPage extends StatefulWidget {
  const AboutMoticarPage({super.key});

  @override
  State<AboutMoticarPage> createState() => _AboutMoticarPageState();
}

class _AboutMoticarPageState extends State<AboutMoticarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEF5F5),
      appBar: AppBar(
        title: const Text(
          "About Moticar",
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
        backgroundColor: AppColors.appThemeColor,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
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
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),

            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ComapnyInfoPage();
                }));
              },

              title: const Text(
                'Company Information',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.appThemeColor,
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

              title: const Text(
                'Visit our website',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.appThemeColor,
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

            //partners
            ListTile(
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) {
                //   return const ChangePassPage();
                // }));
              },

              title: const Text(
                'Partners & Affiliates',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.appThemeColor,
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
    );
  }
}

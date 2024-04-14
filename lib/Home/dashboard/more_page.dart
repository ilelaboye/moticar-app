import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';

import '../../auth/add_car.dart';
import '../../models/menu_items.dart';
import '../../widgets/colors.dart';
import '../../widgets/menu_list_tile.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
 Widget build(BuildContext context) {
    // final state = ref.watch(profileProvider);
    // final model = ref.read(profileProvider.notifier);
    // var images = useState(XFile(''));
    // final imagePicker = ref.read(imagePickerService);
    // // final hasFp = ref.watch(fingerPrintProvider);

    List<AppMenuItem> menuItems = [
      AppMenuItem(
          title: 'FAQ',
          icon: 'assets/misc_moticar/key_me_.svg',
          action: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return const ChangePassPage();
            // }));
            // context.router.pushNamed('/home-nav/resetPin');
          }),
      AppMenuItem(
        title: 'Feedback',
        icon: 'assets/misc_moticar/compass_me_.svg',
        action: () {
          // context.router.pushNamed('/home-nav/changePin');
        },
      ),
      AppMenuItem(
        title: 'Community',
        icon: 'assets/misc_moticar/inbox_me_.svg',
        action: () {
          // context.router.pushNamed('/home-nav/changePassword');
        },
      ),
      // if (hasTierSystem)
      AppMenuItem(
        title: 'Rate Us',
        icon: 'assets/misc_moticar/gift_me_.svg',
        action: () {
          // context.router.pushNamed('/home-nav/accountInformation');
        },
      ),
      // if (hasFp)
      // AppMenuItem(
      //   title: 'Biometric Login',
      //   icon: 'assets/svgs/updates.svg',
      //   trailing: Row(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: [
      //       Transform.scale(
      //         scale: 0.6,
      //         child: CupertinoSwitch(
      //           value: state.hasEnabledBiometricLogin,
      //           onChanged: (value) {
      //             model.enableBiometricLogin(value);
      //           },
      //           activeColor: AppColors.appThemeColor,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),

      AppMenuItem(
          title: 'Notification Settings',
          icon: 'assets/misc_moticar/users_me_.svg',
          action: () {},
          // trailing: const SizedBox(),
          ),

      AppMenuItem(
        title: 'Contact Us',
        icon: 'assets/misc_moticar/coffee_me_.svg',
        action: () {
          // context.router.pushNamed('/home-nav/accountInformation');
        },
        // trailing: const SizedBox(),
      ),

      AppMenuItem(
        title: 'Terms & Policies',
        icon: 'assets/misc_moticar/download_me_.svg',
        // trailing: const SizedBox(),
        action: () {
          // context.router.pushNamed('/home-nav/accountInformation');
        },
      ),

      //
      AppMenuItem(
        title: 'Currency',
        icon: 'assets/misc_moticar/log-out_me_.svg',
        // trailing: const SizedBox(),
        action: () {
          // context.router.pushNamed('/home-nav/accountInformation');
        },
      ),
    ];

    
    return Scaffold(
      backgroundColor: const Color(0xffeef5f5),
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            //profile card
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xffB8F2F4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About Moticar",
                    style: TextStyle(
                      fontFamily: "NeulisAlt",
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: AppColors.appThemeColor,
                    ),
                  ),


                   SizedBox(
                    height: 80,
                    width: 150,
                    child: RiveAnimation.asset(
                      'assets/images/splashscreenanim.riv',
                    ),
                  ),

                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(
                  //     Icons.arrow_forward_ios_rounded,
                  //     color: Color(0xff5E7A7C),
                  //   ),
                  // ),
                  // const SizedBox(height: 10),

                  //logo


                  // const SizedBox(height: 10),
                  //other texts
                   Padding(
                     padding: EdgeInsets.only(right:20.0, bottom: 20),
                     child: Text(
                      "It is so simple that you have to just keep track of all expenses you incur and we can provide you the insights you need for taking money saving decisions.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "NeulisAlt",
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: AppColors.appThemeColor,
                      ),
                                     ),
                   ),

                   
                ],
              ),
            ),

            //listtile

            const SizedBox(height: 10),

            Expanded(
              child: Container(
                color: const Color(0xffeef5f5),
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const Divider(thickness: 0.6, color: Color(0xff7BA0A3)),
                  itemCount: menuItems.length,
                  padding: const EdgeInsets.fromLTRB(3, 10, 3, 3),
                  itemBuilder: (context, index) {
                    return MenuTile(
                      item: menuItems[index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

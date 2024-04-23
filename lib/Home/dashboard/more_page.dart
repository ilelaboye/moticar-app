import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';

import '../../auth/add_car.dart';
import '../../models/menu_items.dart';
import '../../services/hivekeys.dart';
import '../../services/localdatabase.dart';
import '../../widgets/colors.dart';
import '../../widgets/menu_list_tile.dart';
import '../profile/about_page.dart';
import '../profile/notification_sett.dart';
import '../profile/terms_policies.dart';

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
          icon: 'assets/svgs/faq.svg',
          action: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return const TermsPoliciesPage();
            // }));
            // context.router.pushNamed('/home-nav/resetPin');
          }),
      AppMenuItem(
        title: 'Feedback',
        icon: 'assets/svgs/feedback.svg',
        action: () {
          // context.router.pushNamed('/home-nav/changePin');
        },
      ),
      AppMenuItem(
        title: 'Community',
        icon: 'assets/svgs/community.svg',
        action: () {
          // context.router.pushNamed('/home-nav/changePassword');
        },
      ),
      // if (hasTierSystem)
      AppMenuItem(
        title: 'Rate Us',
        icon: 'assets/svgs/rate_us.svg',
        action: () {
          // context.router.pushNamed('/home-nav/accountInformation');
        },
      ),

      AppMenuItem(
        title: 'Notification Settings',
        icon: 'assets/svgs/notification.svg',
        action: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const NotifyMotPage();
          }));
        },
        // trailing: const SizedBox(),
      ),

      AppMenuItem(
        title: 'Contact Us',
        icon: 'assets/svgs/contact_us.svg',
        action: () {
          // context.router.pushNamed('/home-nav/accountInformation');
        },
        // trailing: const SizedBox(),
      ),

      AppMenuItem(
        title: 'Terms & Policies',
        icon: 'assets/svgs/terms.svg',
        // trailing: const SizedBox(),
        action: () {
          // context.router.pushNamed('/home-nav/accountInformation');
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const TermsPoliciesPage();
          }));
        },
      ),

      //
      AppMenuItem(
        title: 'Currency',
        icon: 'assets/svgs/currency.svg',
        // trailing: const SizedBox(),
        action: () {
          // context.router.pushNamed('/home-nav/accountInformation');
        },
        //  trailing: Row(
        //   children: [
        //    Text(
        //      "${HiveStorage.get(HiveKeys.currency)}",
        //     style: const TextStyle(
        //       fontFamily: "NeulisAlt",
        //       fontWeight: FontWeight.w600,
        //       fontSize: 16,
        //       color: Color(0xff00AEB5),
        //     ),
        //   ),

        //   const Icon(
        //     Icons.arrow_forward_ios,
        //     color: Color(0xff7BA0A3),
        //     // size: 10,
        //   ),
        //   ],
        // ),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xffeef5f5),
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 30),
        child: Column(
          children: [
            //profile card
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AboutMoticarPage();
                }));
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xffB8F2F4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "About Moticar",
                      style: TextStyle(
                        fontFamily: "NeulisAlt",
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: AppColors.appThemeColor,
                      ),
                    ),

                    const SizedBox(
                      height: 80,
                      width: 150,
                      child: RiveAnimation.asset(
                        'assets/images/splashscreenanim.riv',
                      ),
                    ),

                    //
                    Row(
                      children: [
                        SizedBox(
                          height: 80,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: const Padding(
                            padding: EdgeInsets.only(right: 20.0, bottom: 10),
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
                        ),
                        //
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                          color: Color(0xff5E7A7C),
                        ),
                      ],
                    ),
                  ],
                ),
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

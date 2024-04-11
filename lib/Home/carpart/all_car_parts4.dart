import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/menu_items.dart';
import '../../widgets/colors.dart';

class AllCarsParts4 extends StatefulWidget {
  const AllCarsParts4({super.key});

  @override
  State<AllCarsParts4> createState() => _AllCarsParts4State();
}

class _AllCarsParts4State extends State<AllCarsParts4> {
  List<AppMenuItem> menuItems = [
    //senseor
    AppMenuItem(
      title: 'Sensors',
      icon: 'assets/carPartsIcons/sensors.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //steering
    AppMenuItem(
      title: 'Steering',
      icon: 'assets/carPartsIcons/steering.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //suspension
    AppMenuItem(
      title: 'Suspension',
      icon: 'assets/carPartsIcons/suspension.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //tools
    AppMenuItem(
      title: 'Tools Equipment',
      icon: 'assets/carPartsIcons/toolsEquipments.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //towbar
    AppMenuItem(
      title: 'Tow bar',
      icon: 'assets/carPartsIcons/towbarParts.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //transmission
    AppMenuItem(
      title: 'Transmission',
      icon: 'assets/carPartsIcons/transmission.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //tuning
    AppMenuItem(
      title: 'Tuning',
      icon: 'assets/carPartsIcons/tuning.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //tyres
    AppMenuItem(
      title: 'Tyres',
      icon: 'assets/carPartsIcons/tyres.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //wiper
    AppMenuItem(
      title: 'Wiper Washer',
      icon: 'assets/carPartsIcons/wiperWasherSystem.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.builder(
        itemCount: menuItems.length,
        // padding: const EdgeInsets.fromLTRB(3, 10, 3, 3),
        itemBuilder: (BuildContext context, int index) {
          return CarPartItem(
            item: menuItems[index],
          );
        },
      ),
    );
  }
}

class CarPartItem extends StatelessWidget {
  const CarPartItem({super.key, required this.item});

  final AppMenuItem item;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 0,
      color: const Color(0xffeef5f5),
      child: ListTile(
        leading: SvgPicture.asset(
          item.icon,
          // height: 30,
          // width: 30,
          // color: AppColors.appThemeColor,
          fit: BoxFit.scaleDown,
        ),
         title: Row(
           children: [
             Text(
              item.title,
              style: const TextStyle(
                fontFamily: "NeulisAlt",
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                color: Color(0xff202A2A),
                letterSpacing: 1.5,
                fontSize: 14,
              ),
        ),
        const SizedBox(
              width: 8,
            ),
            const Expanded(
              child: Divider(
                thickness: 1.0,
                color: AppColors.divider,
              ),
            ),
           ],
         ),
        // ignore: prefer_if_null_operators
        trailing: item.trailing != null
            ? item.trailing
            : const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Color(0xff7BA0A3),
                // size: 10,
              ),
      ),
    );
  }
}

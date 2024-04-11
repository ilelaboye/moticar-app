import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/menu_items.dart';
import '../../widgets/colors.dart';

class AllCarsParts2 extends StatefulWidget {
  const AllCarsParts2({super.key});

  @override
  State<AllCarsParts2> createState() => _AllCarsParts2State();
}

class _AllCarsParts2State extends State<AllCarsParts2> {
  List<AppMenuItem> menuItems = [
    AppMenuItem(
        title: 'Air Conditioning',
        icon: 'assets/carPartsIcons/Air Conditioning.svg',
        action: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return const ChangePassPage();
          // }));
          // context.router.pushNamed('/home-nav/resetPin');
        }),
    AppMenuItem(
      title: 'Auto Car Care',
      icon: 'assets/carPartsIcons/autodetailingCarCare.svg',
      action: () {
        // context.router.pushNamed('/home-nav/changePin');
      },
    ),
    AppMenuItem(
      title: 'Bearing',
      icon: 'assets/carPartsIcons/bearings.svg',
      action: () {
        // context.router.pushNamed('/home-nav/changePassword');
      },
    ),
    // if (hasTierSystem)
    AppMenuItem(
      title: 'Belts Chains',
      icon: 'assets/carPartsIcons/BeltsChainsRollers.svg',
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    AppMenuItem(
      title: 'Body',
      icon: 'assets/carPartsIcons/body.svg',
      action: () {},
      trailing: const SizedBox(),
    ),

    AppMenuItem(
      title: 'Brakes',
      icon: 'assets/carPartsIcons/brakes.svg',
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
      trailing: const SizedBox(),
    ),

    AppMenuItem(
      title: 'Car Accessories',
      icon: 'assets/carPartsIcons/carAccessories.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //
    AppMenuItem(
      title: 'Clutch',
      icon: 'assets/carPartsIcons/clutch.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //damping
    AppMenuItem(
      title: 'Damping',
      icon: 'assets/carPartsIcons/Damping.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //
    AppMenuItem(
      title: 'Drive Shaft',
      icon: 'assets/carPartsIcons/driveShaftCVJoint.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //electrics
    AppMenuItem(
      title: 'Electrics',
      icon: 'assets/carPartsIcons/electrics.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    AppMenuItem(
      title: 'Engine',
      icon: 'assets/carPartsIcons/engine.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //cooling
    AppMenuItem(
      title: 'Engine Cooling System',
      icon: 'assets/carPartsIcons/EngineCoolingSystem.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //exhaust
    AppMenuItem(
      title: 'Exhaust',
      icon: 'assets/carPartsIcons/exhaust.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

     AppMenuItem(
      title: 'Engine Cooling System',
      icon: 'assets/carPartsIcons/fuelSupplySystem.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //fastners
    AppMenuItem(
      title: 'Fastners',
      icon: 'assets/carPartsIcons/fastners.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //filters
    AppMenuItem(
      title: 'Filters',
      icon: 'assets/carPartsIcons/filters.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //fuel supply
   

    //gasket
    AppMenuItem(
      title: 'Gasket',
      icon: 'assets/carPartsIcons/gasket.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //ignition
    AppMenuItem(
      title: 'Ignition',
      icon: 'assets/carPartsIcons/ignitionPreheatingSystem.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //interior
    AppMenuItem(
      title: 'Interior',
      icon: 'assets/carPartsIcons/interior.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //light
    AppMenuItem(
      title: 'Lighting',
      icon: 'assets/carPartsIcons/lighting.svg',
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

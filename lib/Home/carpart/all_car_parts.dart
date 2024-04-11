import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/menu_items.dart';
import '../../widgets/colors.dart';

class AllCarsParts extends StatefulWidget {
  const AllCarsParts({super.key});

  @override
  State<AllCarsParts> createState() => _AllCarsPartsState();
}

class _AllCarsPartsState extends State<AllCarsParts> {
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
    AppMenuItem(
      title: 'Engine Cooling System',
      icon: 'assets/carPartsIcons/fuelSupplySystem.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

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
      title: 'Ignition',
      icon: 'assets/carPartsIcons/ignitionPreheatingSystem.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //oild
    AppMenuItem(
      title: 'Oil Fluids',
      icon: 'assets/carPartsIcons/oilsFluids.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //
    // pipes
    AppMenuItem(
      title: 'Pipe Hose',
      icon: 'assets/carPartsIcons/pipesHoses.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //preheat
    AppMenuItem(
      title: 'Pre Heat',
      icon: 'assets/carPartsIcons/preheat.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //
    // shafts
    AppMenuItem(
      title: 'Props Shaft',
      icon: 'assets/carPartsIcons/propsShafts.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

    //repair
    AppMenuItem(
      title: 'Repair Kit',
      icon: 'assets/carPartsIcons/repairKit.svg',
      trailing: const SizedBox(),
      action: () {
        // context.router.pushNamed('/home-nav/accountInformation');
      },
    ),

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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/menu_items.dart';
import '../../widgets/colors.dart';

class AllCarsParts3 extends StatefulWidget {
  const AllCarsParts3({super.key});

  @override
  State<AllCarsParts3> createState() => _AllCarsParts3State();
}

class _AllCarsParts3State extends State<AllCarsParts3> {
  List<AppMenuItem> menuItems = [

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

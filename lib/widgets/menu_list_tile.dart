import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/menu_items.dart';
import 'colors.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({super.key, required this.item, this.height = 60});

  final AppMenuItem item;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 0,
      color: const Color(0xffeef5f5),
      child: Container(
        // height: height ?? 50,
        padding: const EdgeInsets.all(2),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(10),
        //   // color: AppColors.skipColor,
        // ),
        child: ListTile(
          onTap: item.action,
          leading: SvgPicture.asset(
            item.icon,
            // height: 30,
            // width: 30,
            // color: AppColors.appThemeColor,
            fit: BoxFit.scaleDown,
          ),
          title: Text(
            item.title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          // ignore: prefer_if_null_operators
          trailing: item.trailing != null
              ? item.trailing
              : const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff7BA0A3),
                  size: 15,
                ),
        ),
      ),
    );
  }
}

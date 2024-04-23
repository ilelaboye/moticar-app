import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/svg.dart';

import 'colors.dart';
import 'general_widgets.dart';

class MoticarDialog extends StatelessWidget {
  const MoticarDialog({
    Key? key,
    this.title = '',
    this.subtitle = '',
    this.onTap,
    this.buttonText,
    this.buttonColor,
    this.textColor,
    this.icon,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final void Function()? onTap;
  final String? buttonText;
  final Widget? icon;
  final Color? buttonColor, textColor;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon ??
              Image.asset(
                "assets/images/failed_mo.png",
                height: 100,
                // color: const Color(0xff000000),
              ),
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: "NeulisAlt",
                fontSize: 13,
                color: AppColors.appThemeColor,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "NeulisAlt",
              fontSize: 14,
              color: AppColors.appThemeColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      actions: [
        agencyDefaultButton(
          color: buttonColor,
          textColor: textColor ?? Colors.white,
          text: buttonText ?? "Continue",
          onTap: onTap,
        ),
      ],
    );
  }
}

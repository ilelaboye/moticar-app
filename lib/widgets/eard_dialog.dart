import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      backgroundColor: Theme.of(context).colorScheme.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon ??
              SvgPicture.asset(
                "assets/svgs/success.svg",
                height: 30,
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
                color: AppColors.textColor,
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
              color: AppColors.textColor,
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

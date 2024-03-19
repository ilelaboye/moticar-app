// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types

import 'package:flutter/material.dart';
import 'colors.dart';

class MoticarText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;
  const MoticarText(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.fontWeight,
      required this.fontColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: 'Onest',
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: fontColor),
    );
  }
}

class MoticarButton extends StatelessWidget {
  final child;
  final double width;
  final double height;
  final void Function() onTap;
  const MoticarButton(
      {super.key,
      required this.child,
      required this.width,
      required this.height,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColors.green, borderRadius: BorderRadius.circular(30)),
          child: child),
    );
  }
}

class MoticarLoginButton extends StatelessWidget {
  final child;
  final void Function() onTap;
  const MoticarLoginButton({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 60,
          width: 330,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColors.successYellow,
              border: Border.all(
                  color: AppColors.appThemeColor, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(40)),
          child: child),
    );
  }
}

class errorButton extends StatelessWidget {
  final child;
  const errorButton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.red, borderRadius: BorderRadius.circular(10)),
        child: child);
  }
}

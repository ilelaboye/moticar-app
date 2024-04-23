// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'colors.dart';
import 'eard_loader.dart';

Widget defaultButton({
  onTap,
  color,
  text,
  height,
  icon,
  textColor = AppColors.white,
  bool loading = false,
}) =>
    Padding(
      padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
      child: InkWell(
        onTap: loading ? null : onTap,
        child: Container(
          decoration: BoxDecoration(
            color: icon != null
                ? Colors.transparent
                : color ?? const Color(0xff29D7DE),
            borderRadius: BorderRadius.circular(32),
            border: icon != null ? Border.all(color: textColor) : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
                child: loading
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Loading",
                            style: TextStyle(
                              color: textColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 2),
                          const MoticarLoader(
                              size: 20, color: AppColors.appThemeColor),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (icon != null)
                            SvgPicture.asset(
                              "assets/svg/$icon.svg",
                              color: textColor,
                            ),
                          const SizedBox(width: 5),
                          Text(
                            text ?? '',
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                        ],
                      )),
          ),
        ),
      ),
    );

Widget strengthText(text, {color}) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Row(children: [
      Icon(Icons.circle, color: color, size: 8),
      const SizedBox(width: 5),
      Expanded(
        child: Text(
          text,
          style: TextStyle(fontSize: 13, color: color),
        ),
      )
    ]),
  );
}

Widget smallButton({onTap, color, text, textColor}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 53,
      width: 150,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color ?? AppColors.white,
        // border: Border.all(color: PRIMARY, width: 1)
      ),
      child: Center(
        child: Text(
          text ?? 'Close',
          style: TextStyle(
            // fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            color: textColor ?? AppColors.white,
          ),
        ),
      ),
    ),
  );
}

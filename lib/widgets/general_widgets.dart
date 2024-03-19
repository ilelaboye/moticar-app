import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'colors.dart';
import 'eard_loader.dart';

Widget agencyDefaultButton({
  onTap,
  color,
  text,
  height,
  icon,
  textColor = AppColors.black,
  bool loading = false,
}) =>
    Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: InkWell(
        onTap: loading ? null : onTap,
        child: Container(
          decoration: BoxDecoration(
              color: icon != null
                  ? Colors.transparent
                  : color ?? AppColors.white,
              borderRadius: BorderRadius.circular(8),
              border: icon != null ? Border.all(color: textColor) : null,
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 91, 91, 100).withOpacity(0.20),
                  offset: const Offset(0, 2),
                  blurRadius: 4.0,
                ),
                // BoxShadow(color: Colors.black54, blurRadius: 2, spreadRadius: 1)
              ]),
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
                              fontFamily: "Onest",
                              color: textColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 2),
                          const MoticarLoader(size: 20, color: AppColors.white),
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
                              fontFamily: "Onest",
                                color: textColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
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
          style: TextStyle(
            fontFamily: "Onest",fontSize: 12, color: color),
        ),
      )
    ]),
  );
}

Widget smallButton({onTap, color, text, textColor}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color ?? AppColors.white,
        // border: Border.all(color: PRIMARY, width: 1)
      ),
      child: Center(
        child: Text(
          text ?? 'Close',
          style: TextStyle(
            fontFamily: "Onest",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor ?? AppColors.black,
          ),
        ),
      ),
    ),
  );
}

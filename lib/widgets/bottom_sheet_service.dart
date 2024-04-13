import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showMoticarBottom(
    {required Widget child,
    required BuildContext context,
    double radius = 50,
    bool isDismissible = false,
    bool background = false}) {
  final BorderRadiusGeometry borderRadius = BorderRadius.circular(radius);

  showMaterialModalBottomSheet(
    backgroundColor: Colors.transparent,
    enableDrag: false,
    isDismissible: isDismissible,
    barrierColor: Colors.black.withOpacity(0.5),
    context: context,
    builder: (context) => Material(
      borderRadius: borderRadius,
      color: background ? Colors.transparent : Colors.white,
      child: child,
    ),
  );
}

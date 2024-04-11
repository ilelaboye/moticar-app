import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showMoticarBottom({required Widget child, required BuildContext context}) {
  final BorderRadiusGeometry borderRadius = BorderRadius.circular(50.0);

  showMaterialModalBottomSheet(
    backgroundColor: Colors.transparent,
    enableDrag: false,
    isDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    context: context,
    builder: (context) => Material(borderRadius: borderRadius, child: child),
  );
}

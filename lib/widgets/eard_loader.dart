import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'colors.dart';


class MoticarLoader extends StatelessWidget {
  const MoticarLoader({Key? key, this.color, this.size = 50.0})
      : super(key: key);
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitSquareCircle(
          duration: const Duration(seconds: 2),
          color: color ?? AppColors.appThemeColor,
          size: size,
        ),
      ],
    );
  }
}

class OverlayLoader extends StatelessWidget {
  const OverlayLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black.withOpacity(0.2),
      child: Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (context) {
              return const MoticarLoader(
                size: 60,
              );
            },
            opaque: true,
          )
        ],
      ),
    );
  }
}
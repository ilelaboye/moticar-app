import 'package:flutter/material.dart';

class Tabs extends StatelessWidget {
  final String text;
  final Color? color;
  const Tabs({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: "NeulisAlt",
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

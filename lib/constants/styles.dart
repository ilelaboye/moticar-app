import 'package:flutter/material.dart';

class MoticarStyle{
  static label({Color? color, double? fontSize}){
    return TextStyle(fontSize: fontSize ?? 16.0, color: color ?? const Color(0xFF232323));
  }
}
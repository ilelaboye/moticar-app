// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String? subTitle;
  final String icon;
  final String? trailingText;
  final Widget? trailing;
  final String? trailingIconUrl;
  final void Function()? action;
  final String? headerText;
  final String? bottomText;
  final bool showTrailingIcon;
  const MenuItem({
    required this.title,
    required this.icon,
    this.subTitle,
    this.action,
    this.trailingText,
    this.trailing,
    this.headerText,
    this.bottomText,
    this.trailingIconUrl,
    this.showTrailingIcon = true,
  });
}

class AppMenuItem {
  final String title;
  final String? subTitle;
  final String icon;
  final String? trailingText;
  final Widget? trailing;
  final Widget? leading;
  final Widget? child;
  final String? trailingIconUrl;
  final void Function()? action;
  final String? headerText;
  final String? bottomText;
  final bool showTrailingIcon;
  // final color;
  const AppMenuItem({
    this.leading,
    required this.title,
    required this.icon,
    this.subTitle,
    this.child,
    this.action,
    this.trailingText,
    this.trailing,
    this.headerText,
    this.bottomText,
    this.trailingIconUrl,
    this.showTrailingIcon = true,
  });
}

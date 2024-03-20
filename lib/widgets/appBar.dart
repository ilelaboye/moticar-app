import 'package:flutter/material.dart';

import 'colors.dart';

class MoticarAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  // final void Function() onTap;
  final List<Widget>? actions;
  const MoticarAppBar(
      {super.key,
      required this.title,
      // required this.onTap,
      this.actions});

  @override
  State<MoticarAppBar> createState() => _MoticarAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(53);
}

class _MoticarAppBarState extends State<MoticarAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: const TextStyle(
          fontFamily: "Neulis",
          fontSize: 16,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.2,
          color: AppColors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      elevation: 1,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 20,
          color: Colors.white,
        ),
      ),
      backgroundColor: AppColors.appThemeColor,
      shadowColor: Colors.white,
      surfaceTintColor: Colors.white,
    );
  }
}

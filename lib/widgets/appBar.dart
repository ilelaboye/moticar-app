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
          fontFamily: "Onest",
          fontSize: 15,
          letterSpacing: 1,
          color: AppColors.textGrey,
          // const Color(0xff344054),
          fontWeight: FontWeight.w700,
        ),
      ),
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Container(
          height: 40,
          width: 40,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
               color: AppColors.fadeWhite
               ),
          child: const Icon(
            Icons.keyboard_backspace_rounded,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      surfaceTintColor: Colors.white,
    );
  }
}

// import 'dart:io';

import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;

  const NavBar({
    super.key,
    required this.pageIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0.0,
      child: ClipRRect(
        // borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          color: Colors.green,
          child: Row(
            children: [
              navItem(
                Icons.home_outlined,
                pageIndex == 0,
                onTap: () => onTap(0),
              ),
              navItem(
                Icons.message_outlined,
                pageIndex == 1,
                onTap: () => onTap(1),
              ),
              const SizedBox(width: 80),
              navItem(
                Icons.notifications_none_outlined,
                pageIndex == 2,
                onTap: () => onTap(2),
              ),
              navItem(
                Icons.person_outline,
                pageIndex == 3,
                onTap: () => onTap(3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem(IconData icon, bool selected, {Function()? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Icon(
          icon,
          color: selected ? Colors.white : Colors.white.withOpacity(0.4),
        ),
      ),
    );
  }
}

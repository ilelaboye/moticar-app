import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Color indicatorColor;

  const PageIndicator(
      {super.key,
      required this.currentPage,
      required this.indicatorColor,
      required this.totalPages});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(totalPages, (index) {
              return Container(
                width: 40.0,
                height: 5.0,
                // padding: EdgeInsets.all(2),
                margin: const EdgeInsets.symmetric(
                  horizontal: 3.0,
                ),
                decoration: BoxDecoration(
                  // shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  color: index == currentPage - 1
                      ? indicatorColor
                      : Colors.grey.withOpacity(0.5),
                ),
              );
            }),
          ),
          const SizedBox()
        ],
      ),
    );
  }
}

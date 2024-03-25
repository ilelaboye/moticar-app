import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Color indicatorColor, inactiveIndicatorColor;

  const PageIndicator({
    Key? key,
    required this.currentPage,
    required this.indicatorColor,
    required this.totalPages,
    required this.inactiveIndicatorColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(totalPages, (index) {
              return Container(
                width: 75.0,
                height: 5.0,
                margin: const EdgeInsets.only(right: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: index + 1 <= currentPage
                      ? indicatorColor
                      : inactiveIndicatorColor,
                ),
              );
            }),
          ),
          // const SizedBox(),
        ],
      ),
    );
  }
}

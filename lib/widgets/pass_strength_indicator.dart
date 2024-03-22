import 'package:flutter/material.dart';

class PassStrenghtIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Color indicatorColor;

  const PassStrenghtIndicator(
      {super.key,
      required this.currentPage,
      required this.indicatorColor,
      required this.totalPages});

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
                width: 110.0,
                height: 3.0,
                // padding: EdgeInsets.all(2),
                margin: const EdgeInsets.only(
                  right: 4.0,
                ),
                decoration: BoxDecoration(
                  // shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(1),
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

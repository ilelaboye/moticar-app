import 'package:flutter/cupertino.dart';

import 'colors.dart';

class MyTotalWidget extends StatelessWidget {
  const MyTotalWidget(
      {super.key, required this.partAmount, required this.totalAmount});
  final String partAmount, totalAmount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(2), topRight: Radius.circular(2)),
              color: Color(0xff92BEC1),
              // breakdown.imageColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total :',
                  style: TextStyle(
                    fontFamily: "NeulisAlt",
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xff00232A),
                  ),
                ),
                Text(
                  'N ${partAmount}',
                  style: const TextStyle(
                    fontFamily: "NeulisAlt",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.appThemeColor,
                  ),
                ),
              ],
            ),
          ),
          //total
          Container(
            padding:
                const EdgeInsets.only(top: 20, left: 12, right: 12, bottom: 20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4)),
              color: AppColors.appThemeColor,
              // breakdown.imageColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Sum Total of Expenses:',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: "NeulisAlt",
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xff7AE6EB),
                  ),
                ),
                Text(
                  "N ${totalAmount}",
                  // 'N ${calculateTotalExpense(widget.carparts)}',
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontFamily: "NeulisAlt",
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

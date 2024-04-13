import 'package:flutter/material.dart';

class MonthSelector extends StatefulWidget {
  const MonthSelector({Key? key}) : super(key: key);

  @override
  _MonthSelectorState createState() => _MonthSelectorState();
}

class _MonthSelectorState extends State<MonthSelector> {
  List<String> myMonthz = [
    "January",
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  List<int> daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  String? selectedMonth;
  int selectedYear = DateTime.now().year;

  int currentMonthIndex = DateTime.now().month - 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_left),
          onPressed: () {
            setState(() {
              if (currentMonthIndex > 0) {
                currentMonthIndex--;
              } else {
                currentMonthIndex = 11;
                selectedYear--;
              }
            });
          },
        ),
        Container(
          alignment: Alignment.center,
          width: 130,
          height: 55,
          child: Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xffCDD2D2),
              ),
              child: DropdownButtonFormField<String>(
                alignment: AlignmentDirectional.center,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                decoration: const InputDecoration(
                  hintText: 'Select Months',
                  hintStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                items: myMonthz
                    .map<DropdownMenuItem<String>>(
                      (entry) => DropdownMenuItem<String>(
                        value: entry,
                        child: Text(
                          entry,
                          style: const TextStyle(
                              color: Color(0xff002D36),
                              fontWeight: FontWeight.w600,
                              fontSize: 13),
                        ),
                      ),
                    )
                    .toList(),
                value: selectedMonth,
                onChanged: (nvalue) {
                  setState(() {
                    selectedMonth = nvalue;
                  });
                },
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_right),
          onPressed: () {
            setState(() {
              if (currentMonthIndex < 11) {
                currentMonthIndex++;
              } else {
                currentMonthIndex = 0;
                selectedYear++;
              }
            });
          },
        ),
      ],
    );
  }
}

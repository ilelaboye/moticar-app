import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_texts.dart';

class MileageBoards extends StatelessWidget {
  const MileageBoards({
    super.key,
    required this.imagePath,
    required this.mileageType,
    required this.mileageCount,
    this.onTap,
  });
  final String imagePath, mileageType, mileageCount;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 180,
          height: 160,
          padding: const EdgeInsets.all(3),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xffB8F2F4),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 4, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MoticarText(
                        text: mileageType,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontColor: const Color(0xff293536)),
                    MoticarText(
                        text: mileageCount,
                        fontSize: 70,
                        fontWeight: FontWeight.w500,
                        fontColor: const Color(0xff00AEB5)),
                  ],
                ),

                //
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(imagePath),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 15.0),
                      child: Icon(
                        Icons.add,
                        size: 30,
                        color: Color(0xff00AEB5),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

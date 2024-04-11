import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickedImageDisplay extends StatelessWidget {
  const PickedImageDisplay({
    super.key,
    required this.imageList,
    required this.isDark,
  });

  final ValueNotifier<XFile> imageList;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Container(
        //   height: 130,
        //   width: 130,
        //   alignment: Alignment.center,
        //   padding: const EdgeInsets.all(8),
        //   decoration: const BoxDecoration(
        //     color: Color(0xffb8f2f4),
        //     shape: BoxShape.circle,
        //   ),
        //   clipBehavior: Clip.antiAlias,
        //   margin: const EdgeInsets.only(right: 5, bottom: 5),
        //   // decoration: BoxDecoration(
        //   //   shape: BoxShape.circle,
        //   //   // borderRadius: BorderRadius.circular(10)
        //   // ),
        //   child:
        // Image.file(
        //     File(imageList.value.path),
        //     fit: BoxFit.cover,
        //   ),
        // ),

        CircleAvatar(
          radius: 70,
          backgroundColor: const Color(0xffb8f2f4),
          child:

              //  Container(
              //   padding: EdgeInsets.all(8),
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //   ),
              //   child: Image.asset(imageList.value.path),
              // )

              CircleAvatar(
            backgroundImage: AssetImage(imageList.value.path),
            radius: 65,
          ),
        )
      ],
    );
  }
}

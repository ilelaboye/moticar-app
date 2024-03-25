import 'dart:developer';

import 'package:flutter/material.dart';
// hide ModalBottomSheetRoute;
import 'package:image_picker/image_picker.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import 'package:sizer/sizer.dart';
import '../services/imagepicker.dart';
import 'colors.dart';
import 'dotted_border.dart';
// import '../../../../core/services/imagepicker.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  const ImagePickerBottomSheet({
    super.key,
    required MoticarImagePicker picker,
    required this.imageList,
    required this.onImageSelected,
  })  : _picker = picker;

  final MoticarImagePicker _picker;
  final ValueNotifier<XFile> imageList;
  final void Function() onImageSelected;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      alignment: Alignment.center,
      onPressed: () {
        showModalBottomSheet(
          // backgroundColor: Colors.transparent,
          barrierColor: Colors.black.withOpacity(0.5),
          context: context,
          builder: (context) => ImagePickerWidget(
            picker: _picker,
            imageList: imageList,
            onImageSelected: onImageSelected,
          ),
          // context: context,
        );
        // showMaterialModalBottomSheet(
        //   context: context,
        //   backgroundColor: Colors.transparent,
        //   barrierColor: AppColors.textGrey,
        //   builder: (context) => ImagePickerWidget(
        //     picker: _picker,
        //     imageList: imageList,
        //     onImageSelected: onImageSelected,
        //   ),
        // );
      },
      icon: const Icon(
        Icons.camera_alt,
        size: 23,
        color: Colors.white,
      ),
      color: Colors.white,
    );
  }
}

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({
    super.key,
    required this.picker,
    required this.imageList,
    required this.onImageSelected,
  });
  final MoticarImagePicker picker;
  final ValueNotifier<XFile> imageList;
  final void Function() onImageSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Select Image",
            style: TextStyle(
              fontFamily: "NeulisAlt",
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            "Select an image to upload",
            style: TextStyle(
              fontFamily: "NeulisAlt",
              fontSize: 12,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () async {
                      await picker
                          .pickImage(
                        source: ImageSource.camera,
                        imageList: imageList,
                      )
                          .then((value) {
                        if (imageList.value.path.isNotEmpty) {
                          log(imageList.value.toString());
                          Navigator.pop(context);
                          onImageSelected();
                        }
                      });
                    },
                    child: DotBorder(
                      borderType: BorderType.oval,
                      radius: const Radius.circular(12),
                      padding: const EdgeInsets.all(4),
                      dashPattern: const [10, 10],
                      color: AppColors.textColor,
                      child: const Icon(
                        Icons.camera,
                        color: AppColors.textColor,
                        size: 70,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Camera",
                    style: TextStyle(
                      fontFamily: "NeulisAlt",
                      fontSize: 15,
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () async {
                      await picker
                          .pickImage(
                        source: ImageSource.gallery,
                        imageList: imageList,
                      )
                          .then((value) {
                        if (imageList.value.path.isNotEmpty) {
                          log(imageList.value.toString());
                          Navigator.pop(context);
                          onImageSelected();
                        }
                      });
                    },
                    child: DotBorder(
                      borderType: BorderType.rRect,
                      radius: const Radius.circular(12),
                      padding: const EdgeInsets.all(4),
                      dashPattern: const [10, 10],
                      color: AppColors.textColor,
                      child: const Icon(
                        Icons.photo_outlined,
                        color: AppColors.textColor,
                        size: 70,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Gallery",
                    style: TextStyle(
                      fontFamily: "NeulisAlt",
                      fontSize: 15,
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

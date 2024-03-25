

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MoticarImagePicker {
  MoticarImagePicker(this._picker);
  final ImagePicker _picker;

  Future<void> pickImage(
      {required ImageSource source,
      required ValueNotifier<XFile> imageList}) async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
    }

    if (Platform.isIOS) {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
    }

    final XFile? images = await _picker.pickImage(
      source: source,
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    if (images != null) {
      if (Platform.isAndroid) {
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          await Permission.storage.request();
        }
      }

      imageList.value = (images);
    }
  }
}

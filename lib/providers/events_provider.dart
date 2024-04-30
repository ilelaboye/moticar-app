import 'package:flutter/material.dart';
import 'package:moticar/constants/styles.dart';
import 'package:moticar/widgets/colors.dart';

class EventProvider{
  const EventProvider();

  static showNotification(BuildContext context, String? message){
    if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: AppColors.lightGreen,
        content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            child: Text(
              message ?? "",
              style: MoticarStyle.label(
                  color: AppColors.yellow, fontSize: 18.0),
            )),
      ));
    }
  }
}
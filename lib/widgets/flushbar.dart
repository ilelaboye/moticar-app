import 'package:another_flushbar/flushbar.dart';
// import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:moticar/widgets/eard_dialog.dart';

import 'colors.dart';

class Alert {
  static void showNotification({
    int notificationType = 0,
    String message = "",
    required BuildContext context,
    Duration? duration,
  }) {
    Flushbar(
      //padding: const EdgeInsets.only(bottom: 10),
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: notificationType == 0
          ? Color(0xFF64DD17)
          : const Color.fromARGB(255, 142, 19, 11),
      maxWidth: MediaQuery.of(context).size.width * 0.8,
      boxShadows: const [
        BoxShadow(
          color: AppColors.appThemeColor,
          offset: Offset(0.0, 2.0),
          blurRadius: 3.0,
        ),
      ],
      isDismissible: true,
      duration: duration ?? const Duration(seconds: 30),
      showProgressIndicator: false,
      icon: notificationType == 1
          ? Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: Colors.transparent,
                  shape: BoxShape.circle),
              child: InkWell(
                onTap: () {
                  // context.router.pop();
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            )
          : InkWell(
              onTap: () {
                // context.router.pop();
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.check_circle_outline,
                color: Colors.black,
              ),
            ),
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'NeulisAlt',
          fontSize: 13,
          color: Colors.white,
        ),
      ),
    ).show(context);
  }

  static void showNotificationError({
    int notificationType = 0,
    String message = "",
    String? buttonText,
    required BuildContext context,
    Duration? duration,
    VoidCallback? onTap,
  }) {
    showGeneralDialog(
      transitionBuilder: (context, a1, a2, widget) {
        return
            // GestureDetector(
            //   onTap: onTap ?? () => context.router.pop(),
            //   child: CITAnimatedDialog(
            //     header: 'Error',
            //     body: message,
            //     isBalance: false,
            //     animation: a1,
            //     footer: buttonText ?? 'Dismiss',
            //   ),
            // );
            MoticarDialog(
          title: 'Error',
          icon: const Icon(
            Icons.error,
            color: AppColors.red,
            size: 30,
          ),
          subtitle: message,
          onTap: onTap ??
              () {
                // pop twice because there are two popup dialog
                Navigator.pop(context);
                // Navigator.pop(context);
              },
          buttonColor: AppColors.red,
          buttonText: buttonText ?? 'Dismiss',
        );
      },
      transitionDuration: duration ?? const Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return const SizedBox();
      },
    );
  }
}

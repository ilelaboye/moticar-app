import 'package:flutter/material.dart';
import 'package:moticar/widgets/colors.dart';
import 'package:rive/rive.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoaderAnimation extends EasyLoadingAnimation {
  LoaderAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: SizedBox(
          height: 100,
          width: 100,
          child: RiveAnimation.asset(
            'assets/images/preloader.riv',
          ),
        ),
      ),
    );
  }
}

// class Loader extends StatefulWidget {
//   const Loader({super.key});

//   @override
//   State<Loader> createState() => _LoaderState();
// }

// class _LoaderState extends State<Loader> {
// @override
// void initState() {
//   super.initState();
//   showDialog(
//     context: context,
//     barrierDismissible: true,
//     builder: (context) {
//       return Center(
//         child: AlertDialog(
//           backgroundColor: AppColors.appThemeColor,
//           shadowColor: AppColors.appThemeColor,
//           content: Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(
//                   height: 100,
//                   width: 100,
//                   child: RiveAnimation.asset(
//                     'assets/images/preloader.riv',
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text('Loading',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.white))
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

// @override
// Widget build(BuildContext context) {
  //   return Center(
  //     child: AlertDialog(
  //       backgroundColor: AppColors.appThemeColor,
  //       shadowColor: AppColors.appThemeColor,
  //       content: Container(
  //         padding: const EdgeInsets.all(20),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         child: const Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             SizedBox(
  //               height: 100,
  //               width: 100,
  //               child: RiveAnimation.asset(
  //                 'assets/images/preloader.riv',
  //               ),
  //             ),
  //             SizedBox(height: 8),
  //             Text('Loading',
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(color: Colors.white))
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  //   ;
  // }
// }

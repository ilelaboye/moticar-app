import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:moticar/Home/bottom_bar.dart';
import 'package:moticar/providers/auth_provider.dart';
import 'package:moticar/providers/events_provider.dart';
import 'package:moticar/services/hivekeys.dart';
import 'package:moticar/services/localdatabase.dart';
import 'package:moticar/widgets/colors.dart';
import 'package:rive/rive.dart';
import 'package:twitter_login/twitter_login.dart';

class AuthService {
  static setUser(user) async {
    print('set user');
    print(user);
    await HiveStorage.put(HiveKeys.token, user['token']);
    await HiveStorage.put(HiveKeys.userEmail, user["email"]);
    await HiveStorage.put(HiveKeys.userPassword, user["password"]);
    await HiveStorage.put(HiveKeys.hasLoggedIn, true);
    await HiveStorage.put(HiveKeys.hasLoggedIn, true);
  }
  // google sign-in

  static signInwithGoogle(BuildContext context) async {
    try {
      // lets sign in
      MoticarAuthProvider provider = MoticarAuthProvider();
      Map<String, dynamic> res = await provider.signInWithGoogle(context);

      if (res["status"] == true) {
        //       if (await Storage.setUser(res["data"], res["token"])) {
        if (context.mounted) {
          EventProvider.showNotification(context, "Successfully logged in");

          await Future.delayed(const Duration(milliseconds: 100), () async {
            await HiveStorage.put(HiveKeys.userEmail, res["email"]);
            await HiveStorage.put(HiveKeys.token, res["token"]);
            await HiveStorage.put(HiveKeys.hasLoggedIn, true);
          });

          await EasyLoading.dismiss();

          if (context.mounted) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const BottomHomePage();
            }));
          }
        }
      } else {
        if (context.mounted) {
          Navigator.pop(context);

          EventProvider.showNotification(
              context, "Something went wrong, Try again.");
        }
      }
    } catch (e) {
      if (context.mounted) {
        EventProvider.showNotification(
            context, "Something went wrong, Try again.");
      }
    }
  }

  static signInwithFacebook(BuildContext context) async {
    try {
      // lets sign in
      MoticarAuthProvider provider = MoticarAuthProvider();
      Map<String, dynamic> res = await provider.signInWithFacebook();

      // if (context.mounted) {
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
      //                 Text('Welcome to Moticar',
      //                     textAlign: TextAlign.center,
      //                     style: TextStyle(color: Colors.white))
      //               ],
      //             ),
      //           ),
      //         ),
      //       );
      //     },
      //   );

      //   await Future.delayed(const Duration(seconds: 3));
      // }

      // if (res["status"] == true) {
      //   //       if (await Storage.setUser(res["data"], res["token"])) {
      //   if (context.mounted) {
      //     Navigator.pop(context);
      //     EventProvider.showNotification(context, "Successfully logged in");

      //     await Future.delayed(const Duration(milliseconds: 100), () async {
      //       await HiveStorage.put(HiveKeys.userEmail, res["email"]);
      //       await HiveStorage.put(HiveKeys.token, res["token"]);
      //       await HiveStorage.put(HiveKeys.hasLoggedIn, true);
      //     });

      //     if (context.mounted) {
      //       Navigator.push(context, MaterialPageRoute(builder: (context) {
      //         return const BottomHomePage();
      //       }));
      //     }
      //   }
      // } else {
      //   if (context.mounted) {
      //     EventProvider.showNotification(
      //         context, "Something went wrong, Try again.");
      //   }
      // }
    } catch (e) {
      if (context.mounted) {
        EventProvider.showNotification(
            context, "Something went wrong, Try again.");
      }
    }
  }

  // signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final loginResult = await FacebookAuth.instance.login();

  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken.token);

  //   // Once signed in, return the UserCredential
  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }

  static signInWithTwitter(BuildContext context) async {
    try {
      final twitterLogin = TwitterLogin(
        apiKey: '49utyiWtpasaRuWnJtFsdcHfO',
        apiSecretKey: 'jntsXJvxcPySW1fh3LSGXGYh1IhWNzayxiHEIxQ8k4MX6Nr3LU',
        redirectURI: 'moticar://',
      );

      final authResult = await twitterLogin.loginV2();
      print(authResult.user!.name);
      // if (context.mounted) {
      //     showDialog(
      //       context: context,
      //       barrierDismissible: true,
      //       builder: (context) {
      //         return Center(
      //           child: AlertDialog(
      //             backgroundColor: AppColors.appThemeColor,
      //             shadowColor: AppColors.appThemeColor,
      //             content: Container(
      //               padding: const EdgeInsets.all(20),
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(10),
      //               ),
      //               child: const Column(
      //                 mainAxisSize: MainAxisSize.min,
      //                 children: [
      //                   SizedBox(
      //                     height: 100,
      //                     width: 100,
      //                     child: RiveAnimation.asset(
      //                       'assets/images/preloader.riv',
      //                     ),
      //                   ),
      //                   SizedBox(height: 8),
      //                   Text('Welcome to Moticar',
      //                       textAlign: TextAlign.center,
      //                       style: TextStyle(color: Colors.white))
      //                 ],
      //               ),
      //             ),
      //           ),
      //         );
      //       },
      //     );

      //     await Future.delayed(const Duration(seconds: 3));
      //   }

      //   if (res["status"] == true) {
      //     //       if (await Storage.setUser(res["data"], res["token"])) {
      //     if (context.mounted) {
      //       Navigator.pop(context);
      //       EventProvider.showNotification(context, "Successfully logged in");

      //       await Future.delayed(const Duration(milliseconds: 100), () async {
      //         await HiveStorage.put(HiveKeys.userEmail, res["email"]);
      //         await HiveStorage.put(HiveKeys.token, res["token"]);
      //         await HiveStorage.put(HiveKeys.hasLoggedIn, true);
      //       });

      //       if (context.mounted) {
      //         Navigator.push(context, MaterialPageRoute(builder: (context) {
      //           return const BottomHomePage();
      //         }));
      //       }
      //     }
      //   } else {
      //     if (context.mounted) {
      //       EventProvider.showNotification(
      //           context, "Something went wrong, Try again.");
      //     }
      //   }
      // final TwitterAuthCredential credential = TwitterAuthProvider.credential(
      //         accessToken: authResult.authToken, secret: authResult.authTokenSecret);

      // final TwitterAuthCredential credential = TwitterAuthProvider.credential(
      //     accessToken: authResult.authToken, secret: authResult.authTokenSecret);
      // await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {}
  }
}

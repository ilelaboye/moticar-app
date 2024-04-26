import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:moticar/providers/auth_provider.dart';
import 'package:moticar/providers/events_provider.dart';
import 'package:twitter_login/twitter_login.dart';

class AuthService {
  // google sign-in

  static signInwithGoogle(BuildContext context) async {
    try {
      // lets sign in
      MoticarAuthProvider provider = MoticarAuthProvider();
      Map<String, dynamic> res = await provider.signInWithGoogle();

      print(res);

      if (res["status"] == true) {
        //       if (await Storage.setUser(res["data"], res["token"])) {
        if (context.mounted) {
          EventProvider.showNotification(context, "Successfully logged in");
          //           Navigator.pushAndRemoveUntil(
          //               context,
          //               MaterialPageRoute(builder: (context) => const Home()),
          //               (route) => false);
        }
      } else {
        if (context.mounted) {
          EventProvider.showNotification(
              context, "Something went wrong, Try again.");
        }
      }
    } catch (e) {
      print(e);
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

      print(res);

      if (res["status"] == true) {
        //       if (await Storage.setUser(res["data"], res["token"])) {
        if (context.mounted) {
          EventProvider.showNotification(context, "Successfully logged in");
          //           Navigator.pushAndRemoveUntil(
          //               context,
          //               MaterialPageRoute(builder: (context) => const Home()),
          //               (route) => false);
        }
      } else {
        if (context.mounted) {
          EventProvider.showNotification(
              context, "Something went wrong, Try again.");
        }
      }
    } catch (e) {
      print(e);
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
    final twitterLogin = TwitterLogin(
      apiKey: '49utyiWtpasaRuWnJtFsdcHfO',
      apiSecretKey: 'jntsXJvxcPySW1fh3LSGXGYh1IhWNzayxiHEIxQ8k4MX6Nr3LU',
      redirectURI: 'moticar://',
    );

    final authResult = await twitterLogin.loginV2();
    print(authResult.user!.name);
    // final TwitterAuthCredential credential = TwitterAuthProvider.credential(
    //         accessToken: authResult.authToken, secret: authResult.authTokenSecret);

    // final TwitterAuthCredential credential = TwitterAuthProvider.credential(
    //     accessToken: authResult.authToken, secret: authResult.authTokenSecret);
    // await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

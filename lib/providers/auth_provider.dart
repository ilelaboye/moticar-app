import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:moticar/network/dio.dart';
import 'package:moticar/utils/constants.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MoticarAuthProvider with ChangeNotifier {
  String? _token;
  DioClient dioClient = DioClient(Dio(), Constant.baseUrl);
  String? get token => _token;

  set token(String? value) {
    _token = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final res = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = res.additionalUserInfo!.profile!;

      //send data to API
      if (context.mounted) {
        final apiRes = await dioClient.post(context, "/auth/social-login",
            data: {
              "email": user["email"],
              "user_id": res.user!.uid,
              "platform": "google"
            });

        return {
          "status": true,
          "message": "Login successful",
          "data": {
            "uid": res.user!.uid,
            "image": user["picture"],
            "firstname": user["given_name"],
            "lastname": user["family_name"],
            "email": user["email"],
            // "phoneNumber": res.user!.phoneNumber ?? "",
          },
          "token": apiRes.data["data"]["token"]
        };
      } else {
        return {"status": false, "message": "Something went wrong"};
      }
    } on FirebaseAuthException catch (e) {
      return handleFirebaseError(e);
    } catch (e) {
      print(e);
      return {"status": false, "message": ""};
    }
  }

  Future<Map<String, dynamic>> signInWithFacebook() async {
    try {
      final LoginResult fbUser = await FacebookAuth.instance.login();
      final credential =
          FacebookAuthProvider.credential(fbUser.accessToken!.token);
      final res = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = res.additionalUserInfo!.profile!;

      return {
        "status": true,
        "message": "Login successful",
        "data": {
          "uid": res.user!.uid,
          "image": user["picture"],
          "firstname": user["given_name"],
          "lastname": user["family_name"],
          "email": user["email"],
          // "phoneNumber": res.user!.phoneNumber ?? "",
        },
        "token": res.credential!.accessToken
      };
    } on FirebaseAuthException catch (e) {
      return handleFirebaseError(e);
    } catch (e) {
      print(e);
      return {"status": false, "message": ""};
    }
  }

  Future<Map<String, dynamic>> signInWithTwitter() async {
    try {
      // Create a TwitterLogin instance
      final twitterLogin = TwitterLogin(
          apiKey: dotenv.env['X_API_KEY'] ?? "",
          apiSecretKey: dotenv.env['X_API_SECRET'] ?? "",
          redirectURI: dotenv.env['X_REDIRECT_URI'] ?? "moticar://");

      // Trigger the sign-in flow
      final authResult = await twitterLogin.login();

      // Create a credential from the access token
      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: authResult.authToken!,
        secret: authResult.authTokenSecret!,
      );

      // Once signed in, return the UserCredential
      final res = await FirebaseAuth.instance
          .signInWithCredential(twitterAuthCredential);
      final user = res.additionalUserInfo!.profile!;
      return {
        "status": true,
        "message": "Login successful",
        "data": {
          "uid": res.user!.uid,
          "image": user["picture"],
          "firstname": user["given_name"],
          "lastname": user["family_name"],
          "email": user["email"],
          // "phoneNumber": res.user!.phoneNumber ?? "",
        },
        "token": res.credential!.accessToken
      };
    } on FirebaseAuthException catch (e) {
      return handleFirebaseError(e);
    } catch (e) {
      print(e);
      return {"status": false, "message": ""};
    }
  }

  Map<String, dynamic> handleFirebaseError(FirebaseAuthException e) {
    Map<String, dynamic> res = {
      "status": false,
      "message": "Something went wrong, Try again.",
    };

    switch (e.code) {
      case "user-not-found":
        res["message"] = "Account does not exist";
        break;
      case "weak-password":
        res["message"] = "Password is too weak";
        break;
      case "wrong-password":
        res["message"] = "Incorrect password";
        break;
      case "email-already-in-use":
        res["message"] =
            "This email is already associated with another account";
        break;
      case "invalid-email":
        res["message"] = "Enter a valid email address";
        break;
      case "user-disabled":
        res["message"] =
            "Your account has been disabled, contact the administrator to resolve this error";
        break;
      case "account-exists-with-different-credential":
        res["message"] = "Account exists with different Signing credentials";
        break;
      case "invalid-verification-code" || "invalid-verification-id":
        res["message"] = "Unable to verify sign-in, Try again";
      case "operation-not-allowed":
        break;
      case "channel-error":
        break;
      case "invalid-credential":
        break;
      case "permission-denied":
        res["message"] = "Unable to add to cart, Try again";
        break;
      case "no-app":
        res["message"] = "Contact the administrators to resolve this isssues";
        break;
    }
    return res;
  }
}

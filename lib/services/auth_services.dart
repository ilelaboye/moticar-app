// import 'package:google_sign_in/google_sign_in.dart';
// // import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AuthService {
//   //google sign-in

//   signInwithGoogle() async {
//     //sign process
//     final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

//     //obtaining auth details
//     final GoogleSignInAuthentication gAuth = await gUser!.authentication;

//     //creating a new credential

//     final credential = GoogleAuthProvider.credential(
//       accessToken: gAuth.accessToken,
//       idToken: gAuth.idToken,
//     );

//     //lets sign in
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }

//   // signInWithFacebook() async {
//   //   // Trigger the sign-in flow
//   //   final loginResult = await FacebookAuth.instance.login();

//   //   // Create a credential from the access token
//   //   final OAuthCredential facebookAuthCredential =
//   //       FacebookAuthProvider.credential(loginResult.accessToken.token);

//   //   // Once signed in, return the UserCredential
//   //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
//   // }

// //  signInWithTwitter() async {
// //     final TwitterAuthCredential credential = TwitterAuthProvider.credential(accessToken: accessToken, secret: secret);
// // await FirebaseAuth.instance.signInWithCredential(credential);
// //   }
// }

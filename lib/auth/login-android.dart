import 'package:flutter/material.dart';

import '../widgets/app_texts.dart';
import '../widgets/colors.dart';
import 'otp.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Username field
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Username',
                ),
              ),
              const SizedBox(height: 20),
              // Password field
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
              const SizedBox(height: 20),
              // Login button
              ElevatedButton(
                onPressed: () {
                  // Perform login action
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 10),
              // Forgot password button
              TextButton(
                onPressed: () {
                   
                  // Show forgot password bottom sheet
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    builder: (context) => const FractionallySizedBox(
                        heightFactor: 0.88, child: ForgotPasswordBottomSheet()),
                  );
                },
                child: const Text('Forgot Password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordBottomSheet extends StatefulWidget {
  const ForgotPasswordBottomSheet({super.key});

  @override
  State<ForgotPasswordBottomSheet> createState() =>
      _ForgotPasswordBottomSheetState();
}

class _ForgotPasswordBottomSheetState extends State<ForgotPasswordBottomSheet> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // padding: const EdgeInsets.all(20),
        padding: const EdgeInsets.only(bottom: 50, left: 10, right: 10, top: 10),
        margin: const EdgeInsets.only(top: 90),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Add your forgot password UI here
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Forgot Password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.appThemeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            const Text(
                "Enter your email address and we’ll send you a \n4-digit code to reset your password.",
                style: TextStyle(
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w400,
                    fontSize: 14)),

            //
            const SizedBox(height: 20),
            const Text("Email address",
                style: TextStyle(
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w400,
                    fontSize: 14)),

            //
            const SizedBox(height: 8),

            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              // onTap: () {
              //   // Close the keyboard
              //   FocusScope.of(context).unfocus();
              // },
              decoration: InputDecoration(
                hintText: 'Enter your email address',
                hintStyle: const TextStyle(color: AppColors.textGrey),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:
                        const BorderSide(color: AppColors.textGrey, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:
                        const BorderSide(color: AppColors.appThemeColor)),
              ),
            ),

            //
            const SizedBox(height: 30),
            MoticarButton(
              height: 60,
              width: MediaQuery.of(context).size.width - 30,
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return VerificationPage(email: emailController.text);
                }));
              },
              child: const MoticarText(
                fontColor: AppColors.white,
                text: 'Submit',
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

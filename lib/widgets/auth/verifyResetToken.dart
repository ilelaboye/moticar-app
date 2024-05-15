import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moticar/views/auth/signup/sign_2.dart';
import 'package:moticar/providers/app_providers.dart';
import 'package:moticar/providers/authentication.dart';
import 'package:moticar/services/auth_services.dart';
import 'package:moticar/widgets/app_texts.dart';
import 'package:moticar/widgets/auth/setNewPassword.dart';
import 'package:moticar/widgets/bottom_sheet_service.dart';
import 'package:moticar/widgets/colors.dart';
import 'package:moticar/widgets/eard_dialog.dart';
import 'package:moticar/widgets/flushbar.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rive/rive.dart';

class ForgotPasswordTokenVerification extends StatefulHookConsumerWidget {
  const ForgotPasswordTokenVerification(
      {super.key, required this.emailController, this.phone});
  final String emailController;
  final String? phone;

  @override
  ConsumerState<ForgotPasswordTokenVerification> createState() =>
      _ForgotPasswordTokenVerificationState();
}

class _ForgotPasswordTokenVerificationState
    extends ConsumerState<ForgotPasswordTokenVerification> {
  final TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.diaColor,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Color(0xff101828)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),

              //
              //image
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 40, right: 40, bottom: 20),
                child: Image.asset("assets/images/verify_motic.png"),
              ),

              const Text(
                "Enter Reset Password Code",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "NeulisAlt",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.textColor,
                ),
              ),

              const SizedBox(height: 20),

              // Add your terms and conditions here
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: "NeulisAlt",
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.textColor,
                  ),
                  children: [
                    const TextSpan(
                      text: "We have sent a code to ",
                    ),
                    TextSpan(
                      text: widget.emailController,
                      // completePhoneNumber.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              // Add your terms and conditions content here
              const Text(
                'Please enter it below',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "NeulisAlt",
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: AppColors.textColor,
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              PinCodeTextField(
                // obscureText: true,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                pinTheme: PinTheme(
                    inactiveColor: Colors.grey,
                    activeColor: AppColors.appThemeColor,
                    selectedColor: AppColors.appThemeColor,
                    fieldHeight: 60,
                    fieldWidth: 50,
                    borderWidth: 0.7,
                    activeBorderWidth: 0.7,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(15)),
                appContext: context,
                controller: pinController,
                length: 5,
                onChanged: (value) {
                  // Handle PIN code changes
                },
              ),

              const SizedBox(
                height: 15,
              ),

              Consumer(builder: (context, ref, child) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MoticarLoginButton(
                    myColor: AppColors.appThemeColor,
                    borderColor: AppColors.diaColor,
                    onTap: () async {
                      String pinCode = pinController.text;
                      if (pinCode.length == 5) {
                        EasyLoading.show(status: 'Loading');
                        Authentication provider = Authentication();

                        final res = await provider.verifyResetToken(
                            context, widget.emailController, pinCode);
                        if (res['status']) {
                          EasyLoading.dismiss();
                          Alert.showNotification(
                            message: "Code verified successfully",
                            notificationType: 0,
                            context: context,
                          );

                          AuthService.setUser({
                            'token': res['data']['data']['token'],
                            "email": res['data']['data']["email"],
                            "password": res['data']["password"]
                          });
                          // Navigator.pop(context);
                          showMoticarBottomSheet(
                              context: context,
                              child: SetNewPassword(),
                              radius: 0,
                              isDismissible: false,
                              background: true);
                        }
                      } else {
                        Alert.showNotificationError(
                          message: "Please enter a valid 5-digit PIN code.",
                          context: context,
                          notificationType: 1,
                        );
                      }
                    },
                    child: const MoticarText(
                      fontColor: AppColors.white,
                      text: 'Continues',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              }),
              const SizedBox(
                height: 45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

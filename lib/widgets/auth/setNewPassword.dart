import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:moticar/Home/bottom_bar.dart';
import 'package:moticar/utils/validator.dart';
import 'package:moticar/widgets/app_texts.dart';
import 'package:moticar/widgets/colors.dart';

import '../../providers/authentication.dart';
import '../bottom_sheet_service.dart';
import '../flushbar.dart';

class SetNewPassword extends StatefulWidget {
  const SetNewPassword({super.key});

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final passwordController = TextEditingController(text: '');
  final confirmPasswordController = TextEditingController(text: '');
  String password = '';
  String confirmPassword = '';
  bool _isObscure = true;
  bool _isPassObscure = true;

  void forgotPassword() async {
    final form = _formKey.currentState!;

    if (form.validate()) {
      form.save();
      EasyLoading.show(status: 'Loading');
      Authentication provider = Authentication();

      print('entered');
      print(password);
      final res = await provider.resetPassword(context, password);
      if (res['status']) {
        EasyLoading.dismiss();
        Alert.showNotification(
          message: "Reset code sent successfully",
          notificationType: 0,
          context: context,
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const BottomHomePage();
        }));
      }
    } else {
      Alert.showNotificationError(
        message: 'Invalid password',
        context: context,
        notificationType: 1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 15,
          right: 15,
          top: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Reset Password',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColors.appThemeColor),
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 4, left: 3),
                  child: MoticarText(
                      text: "New Password",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontColor: AppColors.textColor),
                ),
                TextFormField(
                  obscureText: _isPassObscure,
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus(); // Close the keyboard
                  },
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(
                      fontFamily: "NeulisAlt",
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    PasswordValidator.validatePassword(value!);
                    if (value.isEmpty) {
                      return 'New password field is required';
                    }
                    if (value.length < 6) {
                      return 'Password should be more than 6 characters';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  onSaved: (value) {
                    password = value!;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: AppColors.appThemeColor)),
                    // errorBorder: InputBorder.none,
                    hintText: 'Enter new password',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 11),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: Color(0xffD0D5DD), width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: AppColors.appThemeColor)),
                    filled: true,
                    fillColor: Colors.white,
                    // hintText: 'Enter your password',
                    hintStyle: const TextStyle(
                        fontFamily: "NeulisAlt",
                        fontWeight: FontWeight.w400,
                        color: Color(0xffC1C3C3),
                        letterSpacing: 1.2,
                        fontSize: 14),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isPassObscure = !_isPassObscure;
                        });
                      },
                      icon: Icon(
                          _isPassObscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: _isPassObscure
                              ? AppColors.oldGrey
                              : Colors.black.withOpacity(0.55)),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 4, left: 3),
                  child: MoticarText(
                      text: "Confirm new password",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontColor: AppColors.textColor),
                ),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: _isObscure,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus(); // Close the keyboard
                  },
                  textInputAction: TextInputAction.done,
                  style: const TextStyle(
                      fontFamily: "NeulisAlt",
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    PasswordValidator.validatePassword(value!);
                    if (value != password) {
                      return 'New password and confirm new password does not match';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    confirmPassword = value!;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    hintText: 'Enter confirm password',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 11),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: Color(0xffD0D5DD), width: 1.5)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: AppColors.appThemeColor)),
                    filled: true,
                    fillColor: Colors.white,
                    // hintText: 'Enter your password',
                    hintStyle: const TextStyle(
                        fontFamily: "NeulisAlt",
                        fontWeight: FontWeight.w400,
                        color: Color(0xffC1C3C3),
                        letterSpacing: 1.2,
                        fontSize: 14),

                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: Icon(
                          _isObscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: _isObscure
                              ? AppColors.oldGrey
                              : Colors.black.withOpacity(0.55)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
          MoticarLoginButton(
            myColor: AppColors.appThemeColor,
            borderColor: AppColors.white,
            onTap: () {
              forgotPassword();
              // context.router.push(const LoginRouteCopy());
            },
            child: const MoticarText(
              fontColor: Colors.white,
              text: 'Reset Password',
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

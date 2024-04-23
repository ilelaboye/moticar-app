import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moticar/utils/enums.dart';
import 'package:rive/rive.dart';

import '../../providers/app_providers.dart';
import '../../utils/validator.dart';
import '../../widgets/colors.dart';
import '../../widgets/eard_dialog.dart';
import '../../widgets/gen_widgets.dart';

class ChangePassPage extends ConsumerStatefulWidget {
  const ChangePassPage({super.key});

  @override
  ConsumerState<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends ConsumerState<ChangePassPage> {
  final oldpassCont = TextEditingController();
  final newpassCont = TextEditingController();
  final confirmCont = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeef5f5),
      appBar: AppBar(
        title: const Text(
          "Change Password",
          style: TextStyle(
            fontFamily: "NeulisAlt",
            fontSize: 16,
            fontStyle: FontStyle.normal,
            letterSpacing: 1.2,
            color: AppColors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            // keyboard_backspace
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.appThemeColor,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20.0, left: 10, right: 10, bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: PartyTimecolumnTitle(
                            text: 'Enter Current Password',
                            textColor: AppColors.textColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: oldpassCont,
                          obscureText: _isObscure,
                          style: const TextStyle(
                              fontFamily: 'NeulisAlt',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textColor),
                          keyboardType: TextInputType.name,
                          validator: (value) =>
                              PasswordValidator.validatePassword(value!),
                          onSaved: (value) {
                            // amount_String = value!;
                          },
                          decoration: InputDecoration(
                              hintText: 'Enter Current password',
                              hintStyle: const TextStyle(
                                  fontFamily: 'NeulisAlt',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textGrey),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppColors.textGrey, width: 0.5)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: AppColors.appThemeColor)),
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
                                        ? AppColors.textGrey
                                        : AppColors.appThemeColor,
                                  ))),
                        ),
                      ),

                      //email address
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: PartyTimecolumnTitle(
                            text: 'Enter New Password',
                            textColor: AppColors.textColor),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: newpassCont,
                          obscureText: _isObscure1,
                          style: const TextStyle(
                              fontFamily: 'NeulisAlt',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textColor),
                          keyboardType: TextInputType.name,
                          validator: (value) =>
                              PasswordValidator.validatePassword(value!),
                          onSaved: (value) {
                            // amount_String = value!;
                          },
                          decoration: InputDecoration(
                              hintText: 'Enter new password',
                              hintStyle: const TextStyle(
                                  fontFamily: 'NeulisAlt',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textGrey),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppColors.textGrey, width: 0.5)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: AppColors.appThemeColor)),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isObscure1 = !_isObscure1;
                                    });
                                  },
                                  icon: Icon(
                                    _isObscure1
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: _isObscure1
                                        ? AppColors.textGrey
                                        : AppColors.appThemeColor,
                                  ))),
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 2, left: 8),
                        child: PartyTimecolumnTitle(
                          text: 'Confirm New Password',
                          textColor: AppColors.textColor,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: confirmCont,
                          obscureText: _isObscure2,
                          style: const TextStyle(
                              fontFamily: 'NeulisAlt',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textColor),
                          keyboardType: TextInputType.name,
                          validator: (value) =>
                              ConfirmPasswordValidator.validateConfirmPassword(
                                  value!, newpassCont.text),
                          onSaved: (value) {
                            // amount_String = value!;
                          },
                          decoration: InputDecoration(
                              hintText: 'Confirm password',
                              hintStyle: const TextStyle(
                                  fontFamily: 'NeulisAlt',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textGrey),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppColors.textGrey, width: 0.5)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: AppColors.appThemeColor)),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isObscure2 = !_isObscure2;
                                  });
                                },
                                icon: Icon(
                                  _isObscure2
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: _isObscure2
                                      ? AppColors.textGrey
                                      : AppColors.appThemeColor,
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                //save button
                Consumer(builder: (context, ref, child) {
                  final model = ref.read(profileProvider.notifier);
                  final state = ref.watch(profileProvider);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: defaultButton(
                        loading: state.loading == Loader.loading,
                        text: 'Save',
                        textColor: AppColors.appThemeColor,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            final old = oldpassCont.text.trim();
                            final newP = newpassCont.text.trim();
                            final confirm = confirmCont.text;

                            if (old.isNotEmpty &&
                                newP.isNotEmpty &&
                                confirm.isNotEmpty) {
                                   // if(myEmail.isNotEmpty && myPass.isNotEmpty){
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) {
                                  return Center(
                                    child: AlertDialog(
                                      backgroundColor: AppColors.appThemeColor,
                                      shadowColor: AppColors.appThemeColor,
                                      content: Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: RiveAnimation.asset(
                                                'assets/images/preloader.riv',
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text('Welcome to Moticar',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white))
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );

                              await Future.delayed(const Duration(seconds: 3));

                              
                              await model.changePassword(formData: {
                                "old_password": old,
                                "new_password": newP,
                                // "confirmPassword": confirm,
                              }).then((value) async {
                                if (value.successMessage.isNotEmpty) {
                                  Navigator.pop(context);
                                  await showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) {
                                        return MoticarDialog(
                                          subtitle: value.successMessage,
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        );
                                      });
                                } else {
                                  if (value.errorMessage.isNotEmpty) {
                                    await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return MoticarDialog(
                                          // textColor: Colors.white,
                                          title: 'Failed',
                                          icon: const Icon(Icons.error,
                                              color: Colors.red, size: 50),
                                          buttonColor: Colors.red,
                                          buttonText: 'Dismiss',
                                          subtitle: value.errorMessage,
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    );
                                  }
                                }
                              });
                            }
                          }
                        }),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
class PartyTimecolumnTitle extends StatelessWidget {
  const PartyTimecolumnTitle({
    super.key,
    required this.text,
    required this.textColor,
  });
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontFamily: "NeulisAlt",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: Color(0xff293536),
          ),
        ),
      ],
    );
  }
}

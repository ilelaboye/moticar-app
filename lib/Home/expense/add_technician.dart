// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:moticar/Home/bottom_bar.dart';
import 'package:moticar/auth/login/login_email.dart';
import 'package:moticar/auth/signup/sign_3.dart';
import 'package:moticar/widgets/appBar.dart';
import 'package:moticar/widgets/page_indicator.dart';
import 'package:rive/rive.dart';

import '../../providers/app_providers.dart';
import '../../utils/validator.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../widgets/eard_dialog.dart';
import '../../widgets/image_picker_bottom_sheet.dart';
import '../../widgets/picked_image_display.dart';

class AddNewTechie extends StatefulHookConsumerWidget {
  const AddNewTechie({
    super.key,
  });

  @override
  ConsumerState<AddNewTechie> createState() => _AddNewTechieState();
}

class _AddNewTechieState extends ConsumerState<AddNewTechie> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final firstController = TextEditingController();
  final lastNameController = TextEditingController();
  final preferControl = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  String email = '', password = '';

  String? completePhoneNumber;

  final List myCategory = ['Mechanic', "Rewire"];
  String? selectedCat;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    firstController.dispose();
    lastNameController.dispose();
    preferControl.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    final model = ref.read(profileProvider.notifier);
    var images = useState(XFile(''));
    final _imagePicker = ref.read(imagePickerService);
    return Scaffold(
      backgroundColor: const Color(0xff002D36),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 8, right: 8.0, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                //
                const Center(
                  child: MoticarText(
                      text: "Add Motor Technician",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontColor: AppColors.white),
                ),

                const SizedBox(
                  height: 15,
                ),

                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // showModalBottomSheet(
                        //   // backgroundColor: Colors.transparent,
                        //   barrierColor: Colors.black.withOpacity(0.5),
                        //   context: context,
                        //   builder: (context) => ImagePickerWidget(
                        //     picker: _imagePicker,
                        //     imageList: images,
                        //     onImageSelected: () {},
                        //   ),
                        //   // context: context,
                        // );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (images.value.path.isNotEmpty)
                            PickedImageDisplay(
                              imageList: images,
                              isDark: false,
                            ),
                          if (images.value.path.isEmpty)
                            Container(
                              height: 120,
                              width: 120,
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0xffb8f2f4),
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff7AE6EB),

                                  // borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.person_3_outlined,
                                    size: 45,
                                    color: AppColors.appThemeColor,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    //
                    Positioned(
                      bottom: 6,
                      left: MediaQuery.of(context).size.width * 0.525,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            // backgroundColor: Colors.transparent,
                            barrierColor: Colors.black.withOpacity(0.5),
                            context: context,
                            builder: (context) => ImagePickerWidget(
                              picker: _imagePicker,
                              imageList: images,
                              onImageSelected: () {},
                            ),
                            // context: context,
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          padding: const EdgeInsets.all(3),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                color: Color(0xff002D36),
                                shape: BoxShape.circle),
                            child: SvgPicture.asset(
                              'assets/svgs/camera-01.svg',
                              height: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                //
                const SizedBox(
                  height: 12,
                ),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 8.0, bottom: 8, left: 3),
                                    child: MoticarText(
                                        text: "First Name",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        fontColor: AppColors.white),
                                  ),
                                  //email
                                  SizedBox(
                                    height: 55,
                                    child: TextFormField(
                                      controller: firstController,
                                      keyboardType: TextInputType.text,
                                      // onTapOutside: (event) {
                                      //   FocusScope.of(context)
                                      //       .unfocus(); // Close the keyboard
                                      // },
                                      textInputAction: TextInputAction.next,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      style: const TextStyle(
                                          fontFamily: "NeulisAlt",
                                          color: AppColors.textColor,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.2,
                                          fontSize: 15),
                                      validator: (value) =>
                                          FieldValidaor.validateEmptyfield(
                                              value!),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: AppColors.red, width: 1.5),
                                        ),
                                        hintText: 'Enter first Name',
                                        // errorText:
                                        //     _emailError, // Show the error message here

                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Color(0xffD0D5DD),
                                              width: 1.5),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color:
                                                    AppColors.appThemeColor)),
                                        filled: true,
                                        fillColor: Colors.white,
                                        // hintText: 'Enter your password',
                                        hintStyle: const TextStyle(
                                            fontFamily: "NeulisAlt",
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffC1C3C3),
                                            letterSpacing: 1.2,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 8.0, bottom: 8, left: 3),
                                    child: MoticarText(
                                        text: "Last Name",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        fontColor: AppColors.white),
                                  ),
                                  //email
                                  SizedBox(
                                    height: 55,
                                    child: TextFormField(
                                      controller: lastNameController,
                                      keyboardType: TextInputType.text,
                                      // onTapOutside: (event) {
                                      //   FocusScope.of(context)
                                      //       .unfocus(); // Close the keyboard
                                      // },
                                      textCapitalization:
                                          TextCapitalization.words,
                                      validator: (value) =>
                                          FieldValidaor.validateEmptyfield(
                                              value!),
                                      textInputAction: TextInputAction.next,
                                      style: const TextStyle(
                                          fontFamily: "NeulisAlt",
                                          color: AppColors.textColor,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.2,
                                          fontSize: 15),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: AppColors.red, width: 1.5),
                                        ),
                                        hintText: 'Enter Last Name',
                                        // errorText:
                                        //     _emailError, // Show the error message here

                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Color(0xffD0D5DD),
                                              width: 1.5),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color:
                                                    AppColors.appThemeColor)),
                                        filled: true,
                                        fillColor: Colors.white,
                                        // hintText: 'Enter your password',
                                        hintStyle: const TextStyle(
                                            fontFamily: "NeulisAlt",
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffC1C3C3),
                                            letterSpacing: 1.2,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      //
                      const SizedBox(
                        height: 12,
                      ),

                      //preffered

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 8.0, bottom: 8, left: 3),
                            child: MoticarText(
                                text: "Preferred Name (optional)",
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontColor: AppColors.white),
                          ),
                          //email
                          SizedBox(
                            height: 55,
                            child: TextFormField(
                              controller: preferControl,
                              keyboardType: TextInputType.text,
                              // onTapOutside: (event) {
                              //   FocusScope.of(context).unfocus(); // Close the keyboard
                              // },
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(
                                  fontFamily: "NeulisAlt",
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2,
                                  fontSize: 15),
                              // validator: (value) =>
                              //     FieldValidaor.validateEmptyfield(value!),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppColors.red, width: 1.5),
                                ),
                                hintText: 'Any alias name would work',
                                // errorText:
                                //     _emailError, // Show the error message here

                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Color(0xffD0D5DD), width: 1.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: AppColors.appThemeColor)),
                                filled: true,
                                fillColor: Colors.white,
                                // hintText: 'Enter your password',
                                hintStyle: const TextStyle(
                                    fontFamily: "NeulisAlt",
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffC1C3C3),
                                    letterSpacing: 1.2,
                                    fontSize: 14),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                              "Afterall, who needs to be reminded of their names every single time",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.divider,
                                fontFamily: "NeulisAlt",
                              )),

                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      ),

                      //

//confirm password

                      const Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8, left: 3),
                        child: Row(
                          children: [
                            MoticarText(
                                text: "Email",
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontColor: AppColors.white),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 55,
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          // onTapOutside: (event) {
                          //   FocusScope.of(context).unfocus(); // Close the keyboard
                          // },
                          textInputAction: TextInputAction.done,
                          style: const TextStyle(
                              fontFamily: "NeulisAlt",
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                              fontSize: 15),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              EmailValidator.validateEmail(value!),
                          onSaved: (value) {
                            // confirmPassword = value!;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            hintText: 'Enter your email',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Color(0xffD0D5DD), width: 1.5)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: AppColors.appThemeColor)),
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontWeight: FontWeight.w400,
                                color: Color(0xffC1C3C3),
                                letterSpacing: 1.2,
                                fontSize: 14),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      //
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8, left: 3),
                        child: Row(
                          children: [
                            MoticarText(
                                text: "Phone number",
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontColor: AppColors.white),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 55,
                        child: IntlPhoneField(
                          key: const Key('phoneField'),
                          controller: phoneController,
                          style: const TextStyle(
                              fontFamily: "NeulisAlt",
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                              fontSize: 16),
                          // validator: (value) =>
                          //     PhoneNumberValidator.validatePhoneNumber(value as String),
                          decoration: InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            hintText: 'Enter your phone number',

                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Color(0xffD0D5DD), width: 1.5)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColors.appThemeColor),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            // hintText: 'Enter your password',
                            hintStyle: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontWeight: FontWeight.w400,
                                color: Color(0xffC1C3C3),
                                letterSpacing: 1.2,
                                fontSize: 14),
                          ),
                          initialCountryCode: 'NG',
                          onChanged: (phone) {
                            print(phone.completeNumber);
                            completePhoneNumber = phone.completeNumber;
                          },
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 8.0, bottom: 8, left: 3),
                            child: MoticarText(
                                text: "Currency ",
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontColor: AppColors.white),
                          ),
                          //lga drop down
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8, left: 3, right: 3),
                            child: SizedBox(
                              height: 55,
                              child: DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'Category',
                                    hintStyle: TextStyle(
                                        fontFamily: "NeulisAlt",
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xffC1C3C3),
                                        letterSpacing: 1.2,
                                        fontSize: 14),
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(
                                          color: Color(0xffD0D5DD), width: 1.5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(
                                          color: AppColors.appThemeColor,
                                          width: 1.5),
                                    ),
                                  ),
                                  items: myCategory
                                      .map<DropdownMenuItem<String>>(
                                          (value) => DropdownMenuItem<String>(
                                              value: value.toString(),
                                              child: Text(
                                                value.toString(),
                                                style: const TextStyle(
                                                    fontFamily: "NeulisAlt",
                                                    color: AppColors.textColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13),
                                              )))
                                      .toList(),
                                  value: selectedCat,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCat = value!;
                                    });
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),

              //
              Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: SizedBox(
                        height: 55,
                        child: MoticarLoginButton(
                            borderColor: const Color(0xff00AEB5),
                            myColor: Colors.transparent,
                            child: const MoticarText(
                              fontColor: Color(0xff00AEB5),
                              text: 'Cancel',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            }),
                      )),

                      const SizedBox(
                        width: 12,
                      ),

                      //share
                      Expanded(
                        child: SizedBox(
                          height: 55,
                          child: Consumer(builder: (context, ref, child) {
                            final model =
                                ref.read(registerViewmodelProvider.notifier);

                            return MoticarLoginButton(
                              myColor: const Color(0xff29D7DE),
                              borderColor: const Color(0xff29D7DE),
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  final String firstName = firstController.text;
                                  final String lastName =
                                      lastNameController.text;
                                  final String nickname = preferControl.text;
                                  final String passW = password;
                                  final String confam = phoneController.text;
                                  final String phonie = completePhoneNumber!
                                      .substring(1)
                                      .toString();

                                  if (firstName.isNotEmpty &&
                                      lastName.isNotEmpty &&
                                      // nickname.isNotEmpty &&
                                      passW.isNotEmpty &&
                                      // images.value.path.isNotEmpty &&
                                      confam.isNotEmpty) {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (context) {
                                        return Center(
                                          child: AlertDialog(
                                            backgroundColor:
                                                AppColors.appThemeColor,
                                            shadowColor:
                                                AppColors.appThemeColor,
                                            content: Container(
                                              padding: const EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  // const SpinKitWave(
                                                  //   color: AppColors.appThemeColor,
                                                  //   size: 30.0,
                                                  // ),

                                                  SizedBox(
                                                    height: 100,
                                                    width: 100,
                                                    child: RiveAnimation.asset(
                                                      'assets/images/preloader.riv',
                                                    ),
                                                  ),

                                                  SizedBox(height: 12),

                                                  Text(
                                                      'You are getting there...',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white))
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );

                                    await Future.delayed(
                                        const Duration(seconds: 2));

                                    // Navigator.pop(context);

                                    String imagePath = images.value.path;

                                    FormData formData = FormData.fromMap({
                                      // 'email': widget.email,
                                      'first_name': firstName,
                                      'last_name': lastName,
                                      'preferred_name': nickname,
                                      "phone": phonie,
                                      'email': emailController.text,
                                      'image': await MultipartFile.fromFile(
                                          imagePath,
                                          filename: 'image'),
                                    });

                                    // All fields are filled, attempt sign-up
                                    final signUpResult =
                                        await model.addNewTechnician(
                                      formData: formData,
                                    );

                                    // Check the result of sign-up
                                    if (signUpResult
                                        .successMessage.isNotEmpty) {
                                      // Sign-up successful, show success dialog
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) => MoticarDialog(
                                          buttonColor: AppColors.appThemeColor,
                                          textColor: AppColors.white,
                                          buttonText: "Continue",
                                          subtitle: signUpResult.successMessage,
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return const BottomHomePage();
                                            }));
                                          },
                                        ),
                                      );
                                    } else if (signUpResult
                                        .errorMessage.isNotEmpty) {
                                      // Sign-up failed, show error dialog
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return MoticarDialog(
                                            icon: const Icon(
                                                Icons.error_outline_sharp,
                                                color: AppColors.red,
                                                size: 50),
                                            title: '',
                                            subtitle: signUpResult.errorMessage,
                                            onTap: () {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            buttonColor: AppColors.red,
                                            textColor: AppColors.white,
                                            buttonText: "Dismiss",
                                          );
                                        },
                                      );
                                    }
                                  } else {
                                    // Show dialog if any required fields are empty
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return MoticarDialog(
                                          icon: const Icon(Icons.info_rounded,
                                              color: AppColors.appThemeColor,
                                              size: 50),
                                          title: '',
                                          subtitle:
                                              'All Fields are required to proceed',
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          buttonColor: AppColors.appThemeColor,
                                          textColor: AppColors.white,
                                          buttonText: "Dismiss",
                                        );
                                      },
                                    );
                                  }
                                }
                              },
                              child: const MoticarText(
                                fontColor: AppColors.appThemeColor,
                                text: 'Save',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),

                  //button
                ],
              ),
            ],
          ),

          //forgot details
        ),
      ),
    );
  }
}

import 'package:clean_calendar/clean_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moticar/widgets/eard_dialog.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../models/menu_items.dart';
import '../../network/dio_utils.dart';
import '../../providers/app_providers.dart';
import '../../services/hivekeys.dart';
import '../../services/localdatabase.dart';
import '../../utils/enums.dart';
import '../../widgets/colors.dart';
import '../../widgets/image_picker_bottom_sheet.dart';
import '../../widgets/menu_list_tile.dart';
import '../profile/change_pass.dart';

class MePage extends StatefulHookConsumerWidget {
  const MePage({super.key});

  @override
  ConsumerState<MePage> createState() => _MePageState();
}

class _MePageState extends ConsumerState<MePage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    final model = ref.read(profileProvider.notifier);
    var images = useState(XFile(''));
    final imagePicker = ref.read(imagePickerService);
    // final hasFp = ref.watch(fingerPrintProvider);

    List<AppMenuItem> menuItems = [
      AppMenuItem(
          title: 'Change Password',
          icon: 'assets/misc_moticar/key_me_.svg',
          action: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const ChangePassPage();
            }));
            // context.router.pushNamed('/home-nav/resetPin');
          }),
      AppMenuItem(
        title: 'Addresses',
        icon: 'assets/misc_moticar/compass_me_.svg',
        action: () {
          // context.router.pushNamed('/home-nav/changePin');
        },
      ),
      AppMenuItem(
        title: 'Email Subscriptions',
        icon: 'assets/misc_moticar/inbox_me_.svg',
        action: () {
          // context.router.pushNamed('/home-nav/changePassword');
        },
      ),
      // if (hasTierSystem)
      AppMenuItem(
        title: 'Rewards & Tokens',
        icon: 'assets/misc_moticar/gift_me_.svg',
        action: () {
          // context.router.pushNamed('/home-nav/accountInformation');
        },
      ),
      // if (hasFp)
      // AppMenuItem(
      //   title: 'Biometric Login',
      //   icon: 'assets/svgs/updates.svg',
      //   trailing: Row(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: [
      //       Transform.scale(
      //         scale: 0.6,
      //         child: CupertinoSwitch(
      //           value: state.hasEnabledBiometricLogin,
      //           onChanged: (value) {
      //             model.enableBiometricLogin(value);
      //           },
      //           activeColor: AppColors.appThemeColor,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),

      AppMenuItem(
          title: 'My Motor Technicians',
          icon: 'assets/misc_moticar/users_me_.svg',
          action: () {},
          trailing: const SizedBox()),

      AppMenuItem(
        title: 'Invite a friend',
        icon: 'assets/misc_moticar/coffee_me_.svg',
        action: () {
          // context.router.pushNamed('/home-nav/accountInformation');
        },
        trailing: const SizedBox(),
      ),

      AppMenuItem(
        title: 'Import from an existing account',
        icon: 'assets/misc_moticar/download_me_.svg',
        trailing: const SizedBox(),
        action: () {
          // context.router.pushNamed('/home-nav/accountInformation');
        },
      ),

      //
      AppMenuItem(
        title: 'Logout',
        icon: 'assets/misc_moticar/log-out_me_.svg',
        trailing: const SizedBox(),
        action: () {
          // context.router.pushNamed('/home-nav/accountInformation');
        },
      ),
    ];

    useEffect(
      () {
        ref.read(profileProvider.notifier).getMyProfile();
        return null;
      },
      const [],
    );
    return Scaffold(
      backgroundColor: const Color(0xffeef5f5),
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            //profile card
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xffece6b7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  state.getProfile.image != null &&
                                          state.getProfile.image!.isNotEmpty
                                      ? CircleAvatar(
                                          radius: 60,
                                          backgroundColor:
                                              const Color(0xffEAEAEA),
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(

                                              "${HiveStorage.get(
                                                    HiveKeys.image)}"
                                              
                                              // state
                                              //   .getProfile.image
                                              //   .toString(),
                                                
                                                ),
                                            radius: 55,
                                          ),
                                        )
                                      : const CircleAvatar(
                                          radius: 60,
                                          backgroundColor: Color(0xffEAEAEA),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white12,
                                            radius: 55,
                                            child: Icon(
                                              Icons.person,
                                              color: AppColors.appThemeColor,
                                              size: 50,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: MediaQuery.of(context).size.width * 0.20,
                              child: Container(
                                height: 35,
                                width: 35,
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.white,
                                ),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.appThemeColor,
                                  ),
                                  height: 33,
                                  width: 33,
                                  child: Center(
                                    child: state.loading == Loader.loading
                                        ? const SpinKitWaveSpinner(
                                            color: AppColors.appThemeColor,
                                            size: 20,
                                          )
                                        : ImagePickerBottomSheet(
                                            picker: imagePicker,
                                            imageList: images,
                                            onImageSelected: () async =>
                                                await model
                                                    .uploadProfilePic(
                                              files: images.value,
                                            )
                                                    .then((value) {
                                              if (value
                                                  .successMessage.isNotEmpty) {
                                                // showSuccess(
                                                //   text: value.successMessage,
                                                //   context: context,
                                                // );
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return MoticarDialog(
                                                          subtitle: value
                                                              .successMessage,
                                                          buttonColor: AppColors
                                                              .appThemeColor,
                                                          // icon: const Icon(
                                                          //   Icons.person,
                                                          //   size: 40,
                                                          //   color:
                                                          //       AppColors.appThemeColor,
                                                          // ),
                                                          onTap: () {});
                                                    });
                                                // model.fetchUserProfile();
                                              } else {
                                                handleError(
                                                  e: value.error ??
                                                      value.errorMessage,
                                                  context: context,
                                                );
                                              }
                                            }),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // SizedBox(width: 30,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // '${state.getProfile.firstName} ${state.getProfile.lastName}',
                              '${HiveStorage.get(HiveKeys.firstname)} ${HiveStorage.get(HiveKeys.lastname)}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppColors.appThemeColor,
                              ),
                            ),
                            Text(
                              // '${state.getProfile.preferredName}',
                              '${HiveStorage.get(HiveKeys.midname)}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: AppColors.appThemeColor,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  color: const Color(0xff29D7DE),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                // "User ID :\n${state.getProfile.uuid}",
                                'User ID: ${HiveStorage.get(HiveKeys.userId)}',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontFamily: "NeulisAlt",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: AppColors.appThemeColor,
                                ),
                              ),
                            ),
                          ],
                        ),

                         IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Color(0xff5E7A7C),
                          ),
                        )
                      ],
                    ),
                  ),

                  //subscription
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: const Color(0xfff8f6e7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset('assets/misc_moticar/package.svg'),
                            const Text(
                              "Current Subscription Plan Free",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: AppColors.appThemeColor,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              // ignore: prefer_const_constructors
                              icon: Row(
                                children: const [
                                  Text(
                                    "Upgrade",
                                    // textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "NeulisAlt",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Color(0xff00AEB5),
                                    ),
                                  ),

                                  SizedBox(
                                    width: 8,
                                  ),

                                  //
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 30,
                                    color: Color(0xff00AEB5),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  )
                ],
              ),
            ),

            //listtile

            const SizedBox(height: 10),

            Expanded(
              child: Container(
                color: const Color(0xffeef5f5),
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const Divider(thickness: 0.6, color: Color(0xff7BA0A3)),
                  itemCount: menuItems.length,
                  padding: const EdgeInsets.fromLTRB(3, 10, 3, 3),
                  itemBuilder: (context, index) {
                    return MenuTile(
                      item: menuItems[index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

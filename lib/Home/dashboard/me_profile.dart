import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moticar/Home/expense/add_technician.dart';
import 'package:moticar/Home/profile/invite_friend.dart';
import 'package:moticar/auth/login/login_email.dart';
import 'package:moticar/widgets/eard_dialog.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../models/expensesmodel.dart';
import '../../models/menu_items.dart';
import '../../network/dio_utils.dart';
import '../../providers/app_providers.dart';
import '../../services/hivekeys.dart';
import '../../services/localdatabase.dart';
import '../../utils/enums.dart';
import '../../widgets/colors.dart';
import '../../widgets/image_picker_bottom_sheet.dart';
import '../profile/change_pass.dart';
import '../profile/email_sub.dart';

class MePage extends StatefulHookConsumerWidget {
  const MePage({super.key});

  @override
  ConsumerState<MePage> createState() => _MePageState();
}

class _MePageState extends ConsumerState<MePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // ref.read(profileProvider.notifier).getExpenses();
      ref.read(profileProvider.notifier).getTechnicians();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    final model = ref.read(profileProvider.notifier);
    var images = useState(XFile(''));
    final imagePicker = ref.read(imagePickerService);
    List<GetTechies> myTechiez = state.techies;
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
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const EmailSubPage();
          }));
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
          trailing: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AddNewTechie();
                }));
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.add_rounded,
                    color: Color(0xff00AEB5),
                  ),
                  Text(
                    "Add",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "NeulisAlt",
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xff00AEB5),
                    ),
                  ),
                ],
              ))),

      AppMenuItem(
        title: 'Invite a friend',
        icon: 'assets/misc_moticar/coffee_me_.svg',
        action: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const InviteFriend();
          }));
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
        action: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: const Color(0xff002D36),
                title: const Text(
                  "Are you sure?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                content: const Text(
                  'This action would remove all the information you had previously entered',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff7AE6EB),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actions: [
                  TextButton(
                    style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(EdgeInsets.only(
                          left: 50, right: 50, top: 10, bottom: 10)),
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.appThemeColor),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const LoginPage();
                      }));
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ),

                  //no

                  TextButton(
                    style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(EdgeInsets.only(
                          left: 50, right: 50, top: 10, bottom: 10)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.lightGreen,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    ];

    // useEffect(
    //   () {
    //     ref.read(profileProvider.notifier).getMyProfile();
    //     return null;
    //   },
    //   const [],
    // );
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        ref.read(profileProvider.notifier).getMyProfile();
      },
      child: Scaffold(
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
                                                  "${HiveStorage.get(HiveKeys.image) ?? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"}"

                                                  // state
                                                  //   .getProfile.image
                                                  //   .toString() ?? HiveStorage.get(HiveKeys.image),
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
                                                if (value.successMessage
                                                    .isNotEmpty) {
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
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: const Color(0xfff8f6e7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                width: 8,
                              ),
                              SvgPicture.asset(
                                  'assets/misc_moticar/package.svg'),
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

              //Change Password
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //Edit Profile
                      // ListTile(
                      //   onTap: () {
                      //     Navigator.push(context,
                      //         MaterialPageRoute(builder: (context) {
                      //       return const EditProfilePage();
                      //     }));
                      //   },
                      //   leading: SvgPicture.asset(
                      //     "assets/svgs/edit.svg",
                      //     fit: BoxFit.scaleDown,
                      //   ),
                      //   title: const Text(
                      //     'Edit Profile',
                      //     style: TextStyle(
                      //       fontSize: 16,
                      //       color: AppColors.appThemeColor,
                      //       fontWeight: FontWeight.w400,
                      //     ),
                      //   ),
                      //   // ignore: prefer_if_null_operators
                      //   trailing: const Icon(
                      //     Icons.arrow_forward_ios,
                      //     color: Color(0xff7BA0A3),
                      //     size: 15,
                      //   ),
                      // ),

                      // const Padding(
                      //   padding: EdgeInsets.only(left: 15, right: 15.0, top: 1),
                      //   child: Divider(
                      //     thickness: 0.5,
                      //     color: Color(0xff7BA0A3),
                      //   ),
                      // ),

                      //change_password
                      ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const ChangePassPage();
                          }));
                        },
                        leading: SvgPicture.asset(
                          "assets/misc_moticar/key_me_.svg",
                          // height: 30,
                          // width: 30,
                          // color: AppColors.appThemeColor,
                          fit: BoxFit.scaleDown,
                        ),
                        title: const Text(
                          'Change Password',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.appThemeColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        // ignore: prefer_if_null_operators
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xff7BA0A3),
                          size: 15,
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.only(left: 15, right: 15.0, top: 1),
                        child: Divider(
                          thickness: 0.5,
                          color: Color(0xff7BA0A3),
                        ),
                      ),

                      //address
                      ListTile(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) {
                          //   return const ChangePassPage();
                          // }));
                        },
                        leading: SvgPicture.asset(
                          'assets/misc_moticar/compass_me_.svg',
                          // height: 30,
                          // width: 30,
                          // color: AppColors.appThemeColor,
                          fit: BoxFit.scaleDown,
                        ),
                        title: const Text(
                          'Addresses',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.appThemeColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        // ignore: prefer_if_null_operators
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xff7BA0A3),
                          size: 15,
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.only(left: 15, right: 15.0, top: 1),
                        child: Divider(
                          thickness: 0.5,
                          color: Color(0xff7BA0A3),
                        ),
                      ),

                      //email sub
                      ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const EmailSubPage();
                          }));
                        },
                        leading: SvgPicture.asset(
                          'assets/misc_moticar/inbox_me_.svg',
                          fit: BoxFit.scaleDown,
                        ),
                        title: const Text(
                          'Email Subscriptions',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.appThemeColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        // ignore: prefer_if_null_operators
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xff7BA0A3),
                          size: 15,
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.only(left: 15, right: 15.0, top: 1),
                        child: Divider(
                          thickness: 0.5,
                          color: Color(0xff7BA0A3),
                        ),
                      ),

                      //rewards & token

                      const SizedBox(
                        height: 8,
                      ),

                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  'assets/misc_moticar/gift_me_.svg',
                                  fit: BoxFit.scaleDown,
                                ),

                                const Text(
                                  'Rewards & Token',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),

                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 8, bottom: 8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffB8F2F4),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    '0 moticoins',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),

                                //
                                GestureDetector(
                                  onTap: () {},
                                  child: const Row(
                                    children: [
                                      Text(
                                        "See All",
                                        // textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "NeulisAlt",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          color: Color(0xff00AEB5),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 15,
                                        color: Color(0xff00AEB5),
                                      ),

                                      //
                                    ],
                                  ),
                                ),

                                //
                              ],
                            ),
                          ),
                          //rewards
                          const SizedBox(
                            height: 15,
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.11,
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  return const RewardsT(
                                    awardee: "Rookie Reever",
                                  );
                                }),
                          ),

                          const Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 15.0, top: 1),
                            child: Divider(
                              thickness: 0.5,
                              color: Color(0xff7BA0A3),
                            ),
                          ),
                        ],
                      ),

                      //my motor techies
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/misc_moticar/users_me_.svg',
                                      fit: BoxFit.scaleDown,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    const Text(
                                      'My Motor Technicians',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),

                                //
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const AddNewTechie();
                                    }));
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.add_sharp,
                                        size: 25,
                                        color: Color(0xff00AEB5),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        "Add",
                                        // textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "NeulisAlt",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          color: Color(0xff00AEB5),
                                        ),
                                      ),

                                      //
                                    ],
                                  ),
                                ),

                                //
                              ],
                            ),
                          ),
                          //rewards
                          const SizedBox(
                            height: 3,
                          ),

                          myTechiez.isNotEmpty
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.13,
                                  child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: myTechiez.length,
                                      itemBuilder: (context, index) {
                                        final newTech = myTechiez[index];
                                        return TechieT(
                                          imageUrl: newTech.image.toString() ??
                                              "https://www.shutterstock.com/image-vector/technician-icon-simple-silhouette-design-260nw-1489431878.jpg",
                                          techName:
                                              "${newTech.firstName} ${newTech.lastName}",
                                          phoneNo: "${newTech.phone}",
                                          techType: "${newTech.category}",
                                        );
                                      }),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const AddNewTechie();
                                    }));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25, top: 8, bottom: 8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xff29D7DE),
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    child: const Text(
                                      'Add Technician',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'NeulisAlt',
                                        color: AppColors.appThemeColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),

                          //expenditure
                          const SizedBox(
                            height: 15,
                          ),
                          //
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/bar-chart-2.svg'),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    const Text(
                                      "View Expenditure",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "NeulisAlt",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        color: Color(0xff00AEB5),
                                      ),
                                    ),

                                    //
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 15.0, top: 1),
                            child: Divider(
                              thickness: 0.5,
                              color: Color(0xff7BA0A3),
                            ),
                          ),
                        ],
                      ),

                      //invite friend
                      ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const InviteFriend();
                          }));
                        },
                        leading: SvgPicture.asset(
                          'assets/misc_moticar/coffee_me_.svg',
                          fit: BoxFit.scaleDown,
                        ),
                        title: const Text(
                          'Invite a friend',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.appThemeColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        // ignore: prefer_if_null_operators
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xff7BA0A3),
                          size: 15,
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.only(left: 15, right: 15.0, top: 1),
                        child: Divider(
                          thickness: 0.5,
                          color: Color(0xff7BA0A3),
                        ),
                      ),

                      //import
                      ListTile(
                        onTap: () {
                          //               Navigator.push(context, MaterialPageRoute(builder: (context) {
                          //   return const InviteFriend();
                          // }));
                        },
                        leading: SvgPicture.asset(
                          'assets/misc_moticar/download_me_.svg',
                          fit: BoxFit.scaleDown,
                        ),
                        title: const Text(
                          'Import from an existing account',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.appThemeColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        // ignore: prefer_if_null_operators
                        // trailing: const Icon(
                        //   Icons.arrow_forward_ios,
                        //   color: Color(0xff7BA0A3),
                        //   size: 15,
                        // ),
                      ),

                      const Padding(
                        padding: EdgeInsets.only(left: 15, right: 15.0, top: 1),
                        child: Divider(
                          thickness: 0.5,
                          color: Color(0xff7BA0A3),
                        ),
                      ),

                      //logout
                      ListTile(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: const Color(0xff002D36),
                                title: const Text(
                                  "Are you sure?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 19,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                // content: const Text(
                                //   'This action would remove all the information you had previously entered',
                                //   textAlign: TextAlign.center,
                                //   style: TextStyle(
                                //     color: Color(0xff7AE6EB),
                                //     fontSize: 12,
                                //     fontWeight: FontWeight.w400,
                                //   ),
                                // ),
                                actionsAlignment: MainAxisAlignment.spaceEvenly,
                                actions: [
                                  TextButton(
                                    style: ButtonStyle(
                                      //i want a borderside of color red
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32),
                                          side: const BorderSide(
                                            color: AppColors.red,
                                            width: 1,
                                          ),
                                        ),
                                      ),

                                      padding: const MaterialStatePropertyAll(
                                          EdgeInsets.only(
                                              left: 50,
                                              right: 50,
                                              top: 10,
                                              bottom: 10)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              AppColors.appThemeColor),
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return const LoginPage();
                                      }));
                                    },
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.red,
                                      ),
                                    ),
                                  ),

                                  //no

                                  TextButton(
                                    style: ButtonStyle(
                                      //i want a borderside of color red
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32),
                                          side: const BorderSide(
                                            color: Color(0xff00AEB5),
                                            width: 1,
                                          ),
                                        ),
                                      ),

                                      padding: const MaterialStatePropertyAll(
                                          EdgeInsets.only(
                                              left: 50,
                                              right: 50,
                                              top: 10,
                                              bottom: 10)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'No',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.lightGreen,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        leading: SvgPicture.asset(
                          'assets/misc_moticar/log-out_me_.svg',
                          fit: BoxFit.scaleDown,
                        ),
                        title: const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.appThemeColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        // ignore: prefer_if_null_operators
                        // trailing: const Icon(
                        //   Icons.arrow_forward_ios,
                        //   color: Color(0xff7BA0A3),
                        //   size: 15,
                        // ),
                      ),

                      const Padding(
                        padding: EdgeInsets.only(left: 15, right: 15.0, top: 1),
                        child: Divider(
                          thickness: 0.5,
                          color: Color(0xff7BA0A3),
                        ),
                      ),
                    ],
                  ),
                ),
              )

              // Expanded(
              //   child: Container(
              //     color: const Color(0xffeef5f5),
              //     child: ListView.separated(
              //       separatorBuilder: (context, index) =>
              //           const Divider(thickness: 0.6, color: Color(0xff7BA0A3)),
              //       itemCount: menuItems.length,
              //       padding: const EdgeInsets.fromLTRB(3, 10, 3, 3),
              //       itemBuilder: (context, index) {
              //         return MenuTile(
              //           item: menuItems[index],
              //         );
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class RewardsT extends StatelessWidget {
  const RewardsT({
    super.key,
    required this.awardee,
  });
  final String awardee;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset("assets/images/Star.svg"),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            awardee,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "NeulisAlt",
              fontWeight: FontWeight.w500,
              fontSize: 10,
              color: Color(0xff00343F),
            ),
          ),
        ),
      ],
    );
  }
}

class TechieT extends StatelessWidget {
  const TechieT({
    super.key,
    required this.imageUrl,
    required this.techName,
    required this.phoneNo,
    required this.techType,
  });

  final String imageUrl, techName, phoneNo, techType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 51, width: 60,
          // padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // color: Colors.white,
              border: Border.all(width: 0.5, color: Colors.black26),
              image: DecorationImage(
                  fit: BoxFit.contain, image: NetworkImage(imageUrl))),
          // child: Image.network(imageUrl),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 8, right: 8.0, bottom: 3, top: 3),
          child: Text(
            techName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "NeulisAlt",
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Color(0xff00343F),
            ),
          ),
        ),

        //
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8.0, bottom: 3),
          child: Text(
            phoneNo,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "NeulisAlt",
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Color(0xff006C70),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8.0, bottom: 3),
          child: Text(
            techType.toLowerCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "NeulisAlt",
              fontWeight: FontWeight.w600,
              fontSize: 8,
              color: Color(0xff00AEB5),
            ),
          ),
        ),
      ],
    );
  }
}

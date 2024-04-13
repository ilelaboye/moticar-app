// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moticar/auth/add_car2.dart';
import 'package:moticar/widgets/eard_dialog.dart';
import 'package:moticar/widgets/page_indicator.dart';
import 'package:rive/rive.dart';

// import '../../providers/app_providers.dart';
import '../../auth/car_list_all.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import 'all_car_parts.dart';
import 'all_car_parts2.dart';
import 'all_car_parts3.dart';
import 'all_car_parts4.dart';

class AddCarPart extends StatefulHookConsumerWidget {
  const AddCarPart({super.key});

  @override
  ConsumerState<AddCarPart> createState() => _AddCarPartState();
}

class _AddCarPartState extends ConsumerState<AddCarPart>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final carController = TextEditingController();

  late TabController _tabController;

  String? popular;
  bool isClicked = false;
  String selectedImage = '';
  String selectedCarName = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    carController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final state = ref.watch(profileProvider);
    // final model = ref.read(profileProvider.notifier);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xffEEF5F5),
        appBar: AppBar(
          title: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add Car part",
                style: TextStyle(
                  fontFamily: "NeulisAlt",
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "Select the part of the car you want to add",
                style: TextStyle(
                  fontFamily: "NeulisAlt",
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  color: AppColors.indieC,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          elevation: 1,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.appThemeColor,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // ignore: prefer_const_constructors
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              PageIndicator(
                                  currentPage: 1,
                                  indicatorColor: AppColors.indieC,
                                  inactiveIndicatorColor: Color(0xffD7E2E4),
                                  totalPages: 4),
                            ],
                          ),

                          const Center(
                            child: Text(
                              "Select from the category below",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "NeulisAlt",
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.appThemeColor),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: carController,
                              keyboardType: TextInputType.text,
                              onTapOutside: (event) {
                                // FocusScope.of(context)
                                //     .unfocus(); // Close the keyboard
                              },
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(
                                  fontFamily: "NeulisAlt",
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                hintText: 'Search',

                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: const Color(0xffC1C3C3),
                                        width: 0.5)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: AppColors.appThemeColor)),
                                filled: true,
                                fillColor: Colors.white,
                                // hintText: 'Enter your password',
                                suffixIcon: const Icon(
                                  Icons.search_rounded,
                                  color: Color(0xffC1C3C3),
                                ),
                                hintStyle: const TextStyle(
                                    fontFamily: "NeulisAlt",
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffC1C3C3),
                                    letterSpacing: 1.2,
                                    fontSize: 14),
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          //
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),

                      //tabs for all A-J K-P others

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 43,
                          // padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              // borderRadius: BorderRadius.circular(8),
                              // border: Border.all(
                              //     color: const Color(0xffEEEFF0), width: 1),
                              color: Colors.transparent),
                          child: TabBar(
                            controller: _tabController,
                            // controller: DefaultTabController.of(context),

                            indicatorColor: Colors.transparent,
                            dividerColor: Colors.transparent,
                            indicator: BoxDecoration(
                              color: const Color(0xff425658),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: AppColors.white,
                            labelStyle: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontWeight: FontWeight.w600,
                                fontSize: 10),
                            unselectedLabelColor: AppColors.appThemeColor,
                            tabs: const [
                              Tab(text: 'All'),
                              Tab(text: 'A-J'),
                              Tab(text: 'K-R'),
                              Tab(text: 'S-Z'),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 4,
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: TabBarView(
                          controller: _tabController,
                          children: const [
                            // All Cars
                            AllCarsParts(),
                            AllCarsParts2(),
                            AllCarsParts3(),
                            AllCarsParts4(),
                          ],
                        ),
                      ),

                      //
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.12,
                        child: Center(
                          child: Container(
                            // height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                color: Color(0xffEEF5F5),
                                // color: Colors.white,
                                border: Border(
                                    top: BorderSide(
                                        color: Color(0xffEEF5F5), width: 4))),
                            padding: const EdgeInsets.all(8),
                            child: MoticarLoginButton(
                              myColor: AppColors.indieC,
                              borderColor: AppColors.indieC,
                              onTap: () async {
                                if (selectedCarName.isNotEmpty &&
                                    selectedImage.isNotEmpty) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (context) {
                                      return Center(
                                        child: AlertDialog(
                                          backgroundColor:
                                              AppColors.appThemeColor,
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
                                                SizedBox(height: 8),
                                                Text('Processing, please wait.',
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

                                  await Future.delayed(
                                      const Duration(seconds: 3));

                                  Navigator.pop(context);

                                  // Navigator.push(context, MaterialPageRoute(
                                  //   builder: (context) {
                                  //     return AddCarPage2(
                                  //         imagePath: selectedImage,
                                  //         carName: selectedCarName);
                                  //   },
                                  // ));

                                  //
                                } else {
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return MoticarDialog(
                                        icon: const Icon(Icons.info_rounded,
                                            color: AppColors.appThemeColor,
                                            size: 50),
                                        title: '',
                                        subtitle:
                                            'Please select your car brand, before proceeding',
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
                              },
                              child: const MoticarText(
                                fontColor: AppColors.appThemeColor,
                                text: 'Continue',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //bottom
          ],
        ),
      ),
    );
  }
}

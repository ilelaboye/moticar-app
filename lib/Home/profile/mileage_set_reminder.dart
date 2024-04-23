// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moticar/services/hivekeys.dart';
import 'package:moticar/services/localdatabase.dart';
import 'package:rive/rive.dart';

import '../../auth/add_car.dart';
import '../../models/expensesmodel.dart';
import '../../providers/app_providers.dart';
import '../../utils/enums.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/bottom_sheet_service.dart';
import '../../widgets/colors.dart';
import '../../widgets/eard_loader.dart';
import '../dashboard/timeline.dart';
import 'my_cars.dart';
import 'new_mileage.dart';

class AddReminderPage extends StatefulHookConsumerWidget {
  const AddReminderPage({
    super.key,
  });

  @override
  ConsumerState<AddReminderPage> createState() => _AddReminderPageState();
}

class _AddReminderPageState extends ConsumerState<AddReminderPage> {
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // ref.read(profileProvider.notifier).getExpenses();
      ref.read(profileProvider.notifier).getMyCars();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.read(profileProvider);
    final model = ref.read(profileProvider.notifier);

    List<GetCarz> myCarz = state.getallCarz;

    //

    DateTime now = DateTime.now();
    DateTime endOfYear = DateTime(now.year + 1, 1, 1);
    int remainingDays = endOfYear.difference(now).inDays;

    return Scaffold(
      backgroundColor: AppColors.teal,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            width: MediaQuery.of(context).size.width,
            child: state.loading == Loader.loading
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MoticarLoader(size: 40),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      myCarz.isNotEmpty
                          ? Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                color: AppColors.teal,
                              ),
                              child: ListView.builder(
                                itemCount: myCarz.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final carz = myCarz[index];
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            await HiveStorage.put(
                                                HiveKeys.mileage, carz.mileage);
                                            showMoticarBottom(
                                              context: context,
                                              child: FractionallySizedBox(
                                                heightFactor: 0.89,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20.0),
                                                    topRight:
                                                        Radius.circular(20.0),
                                                  ),
                                                  child: MyCarInfoPage(
                                                    bodyStyle:
                                                        carz.category!.name,
                                                    cylinder:
                                                        carz.details!.cylinder,
                                                    segment:
                                                        carz.details!.segment,
                                                    fuelCapacity: carz
                                                        .details!.fuelCapacity,
                                                    driveType:
                                                        carz.details!.driveType,
                                                    acceleration: carz
                                                        .details!.acceleration,
                                                    topSpeed:
                                                        carz.details!.topSpeed,
                                                    tyreSize:
                                                        carz.details!.tyreSize,
                                                    id: carz.id,
                                                    year: carz.details!.year
                                                        .toString(),
                                                    plateNumber:
                                                        carz.plateNumber,
                                                    chasisNumber:
                                                        carz.chasisNumber,
                                                    engineNumber:
                                                        carz.engineNumber,
                                                    dateOfPurchase:
                                                        carz.dateOfPurchase,
                                                    vehicleLicense:
                                                        carz.vehicleLicense,
                                                    roadWorthiness:
                                                        carz.roadWorthiness,
                                                    thirdPartyInsurance: carz
                                                        .thirdPartyInsurance,
                                                    engine: carz.details!.engine
                                                        .toString(),
                                                    gearbox: carz
                                                        .details!.gearbox
                                                        .toString(),
                                                    car: carz.car.toString(),
                                                    model:
                                                        carz.model.toString(),
                                                    category: carz.category
                                                        .toString(),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(3),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4),
                                                topRight: Radius.circular(4),
                                                bottomLeft: Radius.circular(4),
                                                bottomRight: Radius.circular(4),
                                              ),
                                            ),
                                            child: Image.asset(
                                              'assets/images/car_ai.png',
                                              height: 45,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "${carz.car} ${carz.model}",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontFamily: "NeulisAlt",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 8,
                                                    right: 8,
                                                    top: 4,
                                                    bottom: 4,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xff00343f),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                  ),
                                                  child: Text(
                                                    "exp. $remainingDays days",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontFamily: "NeulisAlt",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13,
                                                      color: Color(0xff92BEC1),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              child: Text(
                                                "${carz.details!.engine} . ${carz.category} . ${carz.details!.gearbox}",
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  fontFamily: "NeulisAlt",
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Color(0xff7AE6EB),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8, bottom: 8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isVisible = !isVisible;
                                              });
                                            },
                                            child: isVisible
                                                ? const Icon(
                                                    Icons
                                                        .keyboard_arrow_up_rounded,
                                                    color: AppColors.textGrey,
                                                  )
                                                : const Icon(
                                                    Icons
                                                        .keyboard_arrow_down_sharp,
                                                    color: AppColors.textGrey,
                                                  ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8, bottom: 8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              _showMyNotification(context);
                                            },
                                            child: isVisible
                                                ? const SizedBox()
                                                : const Icon(
                                                    Icons
                                                        .notifications_none_sharp,
                                                    color: AppColors.white,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          : const SizedBox(
                              height: 150,
                              width: 150,
                              child: RiveAnimation.asset(
                                'assets/images/splashscreenanim.riv',
                              ),
                            ),
                      Visibility(
                        visible: isVisible,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: MoticarLoginButton(
                                      borderColor: const Color(0xff00AEB5),
                                      myColor: Colors.transparent,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Edit',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'NeulisAlt',
                                              color: Color(0xff00AEB5),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          SvgPicture.asset(
                                              'assets/svgs/new_edit.svg'),
                                        ],
                                      ),
                                      onTap: () {},
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: MoticarLoginButton(
                                      borderColor: const Color(0xff00AEB5),
                                      myColor: Colors.transparent,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Delete',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'NeulisAlt',
                                              color: Color(0xff00AEB5),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          SvgPicture.asset(
                                              'assets/svgs/delete.svg'),
                                        ],
                                      ),
                                      onTap: () {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: MoticarLoginButton(
                                borderColor: const Color(0xff29D7DE),
                                myColor: const Color(0xff29D7DE),
                                child: const Center(
                                  child: Text(
                                    'Add new Car',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'NeulisAlt',
                                      color: AppColors.appThemeColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const AddCarPage(
                                      isHome: true,
                                    );
                                  }));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),

          //

          //other half
          const Expanded(child: const NewMileage()),

          //
        ],
      ),
    );
  }

  //my Notifications
  void _showMyNotification(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height * 0.65,
      ),
      backgroundColor: const Color(0xff002D36),
      enableDrag: false,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     IconButton(
                //       icon: const Icon(Icons.close, color: Color(0xff101828)),
                //       onPressed: () {
                //         Navigator.pop(context);
                //       },
                //     ),
                //   ],
                // ),

                const SizedBox(height: 12),
                const Center(
                  child: Text(
                    'Notifications',
                    style: TextStyle(
                      fontFamily: "NeulisAlt",
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Add your terms and conditions here

                // const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xff00232A),
                      borderRadius: BorderRadius.circular(64),
                    ),
                    child: const Center(
                      child: Text(
                        '- Today -',
                        style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xff7BA0A3),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'You have not logged in since 7 days',
                            style: TextStyle(
                              fontFamily: "NeulisAlt",
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          SvgPicture.asset('assets/svgs/delete.svg',
                              height: 25),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Not like we are watching and monitoring you. We just discovered you haven’t had any activitity in the past 5 days.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    thickness: 1,
                    color: Color(0xff001A1F),
                  ),
                ),

                //list of categories
                const SizedBox(height: 5),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xff00232A),
                      borderRadius: BorderRadius.circular(64),
                    ),
                    child: const Center(
                      child: Text(
                        '- Yesterday -',
                        style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xff7BA0A3),
                        ),
                      ),
                    ),
                  ),
                ),

                // Add your terms and conditions content here
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'You have not logged in since 7 days',
                            style: TextStyle(
                              fontFamily: "NeulisAlt",
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          SvgPicture.asset('assets/svgs/delete.svg',
                              height: 25),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Not like we are watching and monitoring you. We just discovered you haven’t had any activitity in the past 5 days.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    thickness: 1,
                    color: Color(0xff001A1F),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // add here Jay
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:moticar/services/hivekeys.dart';
import 'package:moticar/services/localdatabase.dart';
import 'package:moticar/widgets/app_texts.dart';

import '../../models/expensesmodel.dart';
import '../../network/dio_utils.dart';
import '../../providers/app_providers.dart';
import '../../widgets/colors.dart';
import '../../widgets/eard_dialog.dart';
import '../bottom_bar.dart';

class MyCarInfoPage extends ConsumerStatefulWidget {
  const MyCarInfoPage({
    super.key,
    required this.id,
    required this.cylinder,
    required this.segment,
    required this.fuelCapacity,
    required this.driveType,
    required this.acceleration,
    required this.topSpeed,
    required this.tyreSize,
    required this.exp,
    // required this.carId,
    // required this.carModelId,
    // required this.engineId,
    // required this.gearboxId,
    required this.plateNumber,
    // required this.mileage,
    required this.chasisNumber,
    required this.engineNumber,
    required this.dateOfPurchase,
    required this.vehicleLicense,
    required this.roadWorthiness,
    required this.thirdPartyInsurance,
    // required this.hackneyPermit,
    // required this.ogHut,
    // required this.stateCarriagePermit,
    // required this.heavyDutyPermit,
    // required this.truckTrailerPermit,
    // required this.localGovtPermit,
    // required this.midYearPermit,
    // required this.createdAt,
    required this.bodyStyle,
    required this.year,
    required this.engine,
    required this.gearbox,
    required this.car,
    required this.model,
    required this.category,
  });
  final int? id;
  // final int? userId;
  // final int? carId;
  // final int? carModelId;
  // final int? engineId;
  // final int? gearboxId;
  final dynamic plateNumber;
  // final dynamic mileage;
  final dynamic chasisNumber;
  final dynamic engineNumber;
  final DateTime? dateOfPurchase;
  final dynamic vehicleLicense;
  final dynamic roadWorthiness;
  final dynamic thirdPartyInsurance;
  // final dynamic hackneyPermit;
  // final dynamic ogHut;
  // final dynamic stateCarriagePermit;
  // final dynamic heavyDutyPermit;
  // final dynamic truckTrailerPermit;
  // final dynamic localGovtPermit;
  // final dynamic midYearPermit;
  // final DateTime? createdAt;
  // final DateTime? updatedAt;
  final String engine,
      year,
      bodyStyle,
      cylinder,
      segment,
      fuelCapacity,
      driveType,
      acceleration,
      topSpeed,
      tyreSize;
  final String gearbox;
  final String car;
  final String model;
  final int exp;
  final String category;

  @override
  ConsumerState<MyCarInfoPage> createState() => _MyCarInfoPageState();
}

class _MyCarInfoPageState extends ConsumerState<MyCarInfoPage> {
  @override
  void initState() {
    super.initState();
  }

  final NumberFormat nairaFormat = NumberFormat.currency(
    symbol: 'N ', //₦
    // decimalDigits: 0,
    locale: 'en_NG',
  );
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime endOfYear = DateTime(now.year + 1, 1, 1);
    int remainingDays = endOfYear.difference(now).inDays;
    final state = ref.watch(profileProvider);
    final model = ref.read(profileProvider.notifier);

    var referral_code = HiveStorage.get(HiveKeys.referral);
    print('printing state');
    print(referral_code);
    return Scaffold(
      backgroundColor: const Color(0xff001A1F),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close,
                          size: 25, color: Colors.white)),
                ],
              ),

              const Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15),
                child: Text(
                  "Your car information",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "NeulisAlt",
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppColors.white,
                  ),
                ),
              ),

              //
              //image
              Padding(
                padding: const EdgeInsets.only(
                    top: 15.0, left: 50, right: 50, bottom: 15),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: getImageWidget(widget.car.toString()),
                ),
              ),

              //car model and plate number
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.car} ${widget.model} ${widget.year}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: "NeulisAlt",
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 4, bottom: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xffFF594B),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: const Text(
                            "new",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "NeulisAlt",
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  //

                  const SizedBox(height: 8),

                  //plate no
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.plateNumber ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: "NeulisAlt",
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color(0xff7AE6EB),
                        ),
                      ),
                      const SizedBox(width: 0),
                      widget.exp > 0
                          ? Container(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 4, bottom: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xff00343f),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Text(
                                "exp. ${widget.exp} days",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: "NeulisAlt",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Color(0xff92BEC1),
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 1,
                            )
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 60, right: 60),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xffF8E761),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "moticarID :",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "NeulisAlt",
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Color(0xff002D36),
                          ),
                        ),
                        Text(
                          referral_code,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "NeulisAlt",
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Color(0xff002D36),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Add your terms and conditions content here
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15.0),
                  child: Text(
                    "${widget.engine}.${widget.gearbox}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "NeulisAlt",
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Color(0xffF8F6E7),
                    ),
                  ),
                ),
              ),

              Center(
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Text(
                    "Date of Purchase: ${DateFormat.yMMMMEEEEd().format(widget.dateOfPurchase!.toLocal())}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "NeulisAlt",
                      fontWeight: FontWeight.w300,
                      fontSize: 13,
                      color: Color(0xffC1C3C3),
                    ),
                  ),
                ),
              ),

              //edit and delete
              Row(
                children: [
                  //delete
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: MoticarLoginButton(
                        borderColor: const Color(0xff00AEB5),
                        myColor: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Edit',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'NeulisAlt',
                                color: Color(0xff006C70),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            SvgPicture.asset('assets/svgs/new_edit.svg'),
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
                          mainAxisAlignment: MainAxisAlignment.center,
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
                            SvgPicture.asset('assets/svgs/delete.svg'),
                          ],
                        ),
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
                                      //i want a borderside of color red
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32),
                                          side: const BorderSide(
                                            color: AppColors.appThemeColor,
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
                                      model.deleteCar(formData: {
                                        "id": widget.id
                                      }).then((value) async {
                                        if (value.successMessage.isNotEmpty) {
                                          await showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) {
                                                return MoticarDialog(
                                                  subtitle:
                                                      value.successMessage,
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return const BottomHomePage();
                                                    }));
                                                    // context.router.push(const HomeRoute());
                                                  },
                                                );
                                              });
                                        } else {
                                          handleError(
                                            e: value.error ??
                                                value.errorMessage,
                                            context: context,
                                          );
                                        }
                                      });
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
                      ),
                    ),
                  ),
                ],
              ),

              //click button to reveal
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  child: isVisible
                      ? const Icon(Icons.keyboard_arrow_up_rounded,
                          color: AppColors.textGrey)
                      : const Icon(Icons.keyboard_arrow_down_rounded,
                          color: AppColors.textGrey),
                ),
              ),

              //car details
              Visibility(
                visible: isVisible,
                child: Column(
                  // main
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 4, bottom: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xff00343f),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 1.5,
                                color: AppColors.divider,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Car Details",
                              style: TextStyle(
                                  fontFamily: "NeulisAlt",
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textGrey,
                                  letterSpacing: 1.5,
                                  fontSize: 10),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1.5,
                                color: AppColors.divider,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //listTile of car details
                    Column(
                      children: [
                        ListTile(
                          title: const Text(
                            "Chasis Number",
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                          trailing: Text(
                            widget.chasisNumber ?? '',
                            style: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                        ),

                        //
                        ListTile(
                          title: const Text(
                            "Engine Number",
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                          trailing: Text(
                            widget.engineNumber ?? '',
                            style: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    //
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 4, bottom: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xff00343f),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 1.5,
                                color: AppColors.divider,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Car Papers - Expiry Dates",
                              style: TextStyle(
                                  fontFamily: "NeulisAlt",
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textGrey,
                                  letterSpacing: 1.5,
                                  fontSize: 10),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1.5,
                                color: AppColors.divider,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //
                    //listTile of car details
                    Column(
                      children: [
                        ListTile(
                          title: const Text(
                            "Date of Purchase",
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                          trailing: Text(
                            // widget.selectedDate,
                            // DateFormat.Hm().format(widget.dateOfPurchase!.toLocal()) ??
                            DateFormat.yMMMMEEEEd()
                                .format(widget.dateOfPurchase!.toLocal()),
                            style: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                        ),

                        //
                        ListTile(
                          title: const Text(
                            "Vehicle License",
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                          trailing: Text(
                            // DateFormat.Hm().format(widget.vehicleLicense!.toLocal()) ??
                            DateFormat.yMMMMEEEEd()
                                .format(widget.dateOfPurchase!.toLocal()),
                            style: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                        ),

                        //
                        ListTile(
                          title: const Text(
                            "Third Party Insurance",
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                          trailing: Text(
                            // DateFormat.Hm()
                            // .format(widget.thirdPartyInsurance!.toLocal()) ??
                            DateFormat.yMMMMEEEEd()
                                .format(widget.dateOfPurchase!.toLocal()),
                            style: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                        ),

                        //tinted

                        ListTile(
                          title: const Text(
                            "Tinted Permit",
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                          trailing: Text(
                            // DateFormat.Hm()
                            //     .format(widget.thirdPartyInsurance!.toLocal()) ??
                            DateFormat.yMMMMEEEEd()
                                .format(widget.dateOfPurchase!.toLocal()),
                            style: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    //more about your car
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 4, bottom: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xff00343f),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 1.5,
                                color: AppColors.divider,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Let’s tell you more about your car",
                              style: TextStyle(
                                  fontFamily: "NeulisAlt",
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textGrey,
                                  letterSpacing: 1.5,
                                  fontSize: 10),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1.5,
                                color: AppColors.divider,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //more info
                    Column(
                      children: [
                        ListTile(
                          title: const Text(
                            "Gear box",
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                          trailing: Text(
                            widget.gearbox,
                            style: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                        ),

                        //
                        ListTile(
                          title: const Text(
                            "Cylinder",
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                          trailing: Text(
                            widget.cylinder,
                            style: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                        ),

                        //
                        ListTile(
                          title: const Text(
                            "Body Style",
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                          trailing: Text(
                            widget.bodyStyle,
                            style: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                        ),

                        //tinted

                        ListTile(
                          title: const Text(
                            "Segment",
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                          trailing: Text(
                            widget.segment,
                            style: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                        ),

                        //drive type
                        ListTile(
                          title: const Text(
                            "Drive type",
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                          trailing: Text(
                            widget.driveType,
                            style: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                        ),

                        //fuel
                        ListTile(
                          title: const Text(
                            "Fuel Capacity",
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                          trailing: Text(
                            widget.fuelCapacity,
                            style: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                        ),

                        //tyre size
                        ListTile(
                          title: const Text(
                            "Tyre Size",
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                          trailing: Text(
                            widget.tyreSize == 'null' ? '' : widget.tyreSize,
                            style: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                        ),

                        //production years
                        ListTile(
                          title: const Text(
                            "Segment",
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                          trailing: Text(
                            widget.segment,
                            style: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                        ),

                        //
                        ListTile(
                          title: const Text(
                            "Top Speed",
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                          trailing: Text(
                            widget.topSpeed == 'null' ? '' : widget.topSpeed,
                            style: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                        ),

                        //aaceleration
                        ListTile(
                          title: const Text(
                            "Acceleration",
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                          trailing: Text(
                            widget.acceleration == 'null'
                                ? ''
                                : widget.acceleration,
                            style: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white,
                                letterSpacing: 1.5,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              //

              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageWidget(String category) {
    switch (category) {
      case 'Acura':
        return SvgPicture.asset('assets/carLogos/acura.svg');
      case 'Alfa-romeo':
        return SvgPicture.asset('assets/carLogos/alfa-romeo.svg');

      case 'Aro':
        return SvgPicture.asset('assets/carLogos/aro-png.svg');

      case 'Aston Martin':
        return SvgPicture.asset('assets/carLogos/aston-martin.svg');

      case 'Audi':
        return SvgPicture.asset('assets/carLogos/audi.svg');

      case 'Austin':
        return SvgPicture.asset('assets/carLogos/austin.svg');

      case 'Avia':
        return SvgPicture.asset('assets/carLogos/avia.svg');

      case 'Bentley':
        return SvgPicture.asset('assets/carLogos/bentley.svg');

      case 'BMW':
        return SvgPicture.asset('assets/carLogos/bmw.svg');

      case 'Brilliance':
        return SvgPicture.asset('assets/carLogos/brilliance.svg');

      case 'Bristol':
        return SvgPicture.asset('assets/carLogos/bristol-png.svg');

      case 'Bugatti':
        return SvgPicture.asset('assets/carLogos/bugatti.svg');

      case 'Buick':
        return SvgPicture.asset('assets/carLogos/buick.svg');

      case 'Cadillac':
        return SvgPicture.asset('assets/carLogos/cadillac.svg');

      case 'Chevrolet':
        return SvgPicture.asset('assets/carLogos/chevrolet.svg');

      case 'Citroen':
        return SvgPicture.asset('assets/carLogos/citroen.svg');

      case 'Cupra':
        return SvgPicture.asset('assets/carLogos/cupra.svg');

      case 'Mercedes':
        return SvgPicture.asset('assets/carLogos/mercedes.svg');
      // Add more cases for other categories if needed
      default:
        // Return a default image or null if no specific image is available
        return SvgPicture.asset("assets/carLogos/toyota.svg");
    }
  }
}

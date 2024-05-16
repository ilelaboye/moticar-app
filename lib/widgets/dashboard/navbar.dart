import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moticar/Home/profile/my_cars.dart';
import 'package:moticar/auth/add_car.dart';
import 'package:moticar/models/expensesmodel.dart';
import 'package:moticar/providers/app_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moticar/providers/car_provider.dart';
import 'package:moticar/utils/enums.dart';
import 'package:moticar/widgets/app_texts.dart';
import 'package:moticar/widgets/bottom_sheet_service.dart';
import 'package:moticar/widgets/colors.dart';
import 'package:rive/rive.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  bool loading = true;
  List<dynamic> myCars = [];
  String selectedCarID = "";
  bool isVisible = false;
  String _topModalData = "";

  void initState() {
    super.initState();
    getMyCars();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   ref.read(profileProvider.notifier).getMyCars();
    // });
  }

  Future<void> getMyCars() async {
    CarProvider provider = CarProvider();

    var res = await provider.getMyCars(context);
    if (res['status']) {
      print('page car');
      print(res['data']);
      myCars = res['data'];

      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        getMyCars();
      },
      child: Column(
        children: [
          Visibility(
            visible: !loading,
            child: Column(
              children: [
                if (myCars.length > 0)
                  // if (myCarz.isNotEmpty)
                  Container(
                    height: 80,
                    padding: const EdgeInsets.only(
                        top: 0, left: 10, right: 10, bottom: 0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.teal,
                    ),
                    child: ListView.builder(
                      // itemCount: myCarz.length,
                      itemCount: 1, // Only show 1 item if myCarz is not empty

                      itemBuilder: (BuildContext context, int index) {
                        final carz = myCars[index];
                        String myRenewal = carz['vehicle_license'] != null
                            ? carz['vehicle_license'].toString()
                            : '0';
                        print('my renew');
                        print(carz['vehicle_license']);
                        String daysDifferenceText = '';
                        int daysDifference = 0;
                        if (myRenewal != '0') {
                          myRenewal = myRenewal.replaceAll('/', '-');
                          print('my renew 33');
                          DateTime renewalDate = DateTime.parse(myRenewal);
                          Duration difference =
                              renewalDate.difference(DateTime.now());
                          daysDifference = difference.inDays;
                          daysDifferenceText = daysDifference < 1
                              ? ""
                              : "exp. $daysDifference days";
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showMoticarBottom(
                                    context: context,
                                    child: FractionallySizedBox(
                                      heightFactor: 0.89,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                        ),
                                        child: MyCarInfoPage(
                                          exp: daysDifferenceText.isNotEmpty
                                              ? daysDifference
                                              : 0,
                                          bodyStyle: carz['category']['name'],
                                          cylinder: carz['details']['cylinder'],
                                          segment: carz['details']['segment'],
                                          fuelCapacity: carz['details']
                                              ['fuel_capacity'],
                                          driveType: carz['details']
                                              ['drive_type'],
                                          acceleration: carz['details']
                                                  ['acceleration']
                                              .toString(),
                                          topSpeed: carz['details']['top_speed']
                                              .toString(),
                                          tyreSize: carz['details']['tyre_size']
                                              .toString(),
                                          id: carz['id'],
                                          plateNumber: carz['plate_number'],
                                          chasisNumber: carz['chasis_number'],
                                          engineNumber: carz['engine_number'],
                                          dateOfPurchase: DateTime.tryParse(
                                              carz['date_of_purchase']),
                                          vehicleLicense:
                                              carz['vehicle_license'],
                                          roadWorthiness:
                                              carz['road_worthiness'],
                                          thirdPartyInsurance:
                                              carz['third_party_insurance'],
                                          engine: carz['details']['engine']
                                              .toString(),
                                          gearbox: carz['details']['gearbox']
                                              .toString(),
                                          car: carz['car']['name'].toString(),
                                          model:
                                              carz['model']['name'].toString(),
                                          category: carz['category'].toString(),
                                          year: carz['details']['year']
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${carz['car']['name']} ${carz['model']['name']} ${carz['details']['year']}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: "NeulisAlt",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Visibility(
                                        visible: daysDifferenceText.isNotEmpty,
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 4,
                                            bottom: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xff00343f),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          child: Text(
                                            daysDifferenceText,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontFamily: "NeulisAlt",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                              color: Color(0xff92BEC1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      "${carz['details']['engine']} . ${carz['category']['name']} . ${carz['details']['gearbox']}",
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
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isVisible = !isVisible;
                                      selectedCarID = carz['id'].toString();
                                    });
                                  },
                                  child: isVisible
                                      ? const Icon(
                                          Icons.keyboard_arrow_up_rounded,
                                          color: AppColors.textGrey,
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            _showTopModal();
                                          },
                                          child: const Icon(
                                            Icons.keyboard_arrow_down_sharp,
                                            size: 35,
                                            color: AppColors.textGrey,
                                          ),
                                        ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _showMyNotification(context);
                                  },
                                  child: isVisible
                                      ? const SizedBox()
                                      : const Icon(
                                          Icons.notifications_none_sharp,
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
                else
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        const MoticarText(
                          text: 'No Cars Available',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          fontColor: AppColors.white,
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 0.0,
                          ),
                          child: SizedBox(
                            width: 150,
                            height: 40,
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
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Visibility(
              visible: loading,
              child: Column(
                // color: Colors.red,
                children: [
                  SizedBox(
                    height: 34,
                    // width: 120,
                    child: RiveAnimation.asset(
                      'assets/images/preloader.riv',
                    ),
                  ),
                  Text(
                    'Loading...',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Future<void> _showTopModal() async {
    final value = await showTopModalSheet<String?>(
      context,
      CarTopBar(
        myCars: myCars,
      ),
      backgroundColor: AppColors.teal,
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    );

    if (value != null) setState(() => _topModalData = value);
  }

  void _showMyNotification(
    BuildContext context,
  ) {
    // final RenderObject? renderBox = key.currentContext?.findRenderObject();
    // final componentPosition = renderBox?.constraints.isNormalized;
    // .localToGlobal(Offset.zero);

    // double sheetHeight =
    //     MediaQuery.of(context).size.height - 50;
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
}

class CarTopBar extends StatelessWidget {
  final List myCars;
  const CarTopBar({Key? key, required this.myCars}) : super(key: key);

  static const _values = ["CF Cruz Azul", "Monarcas FC"];

  @override
  Widget build(BuildContext context) {
    print('see ca');
    print(myCars);
    return SafeArea(
      child: Column(
        children: [
          ConstrainedBox(
            constraints: new BoxConstraints(
              minHeight: 0.0,
              maxHeight: MediaQuery.of(context).size.height * 0.25,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(color: AppColors.teal),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  // itemCount: myCarz.length,
                  itemCount:
                      myCars.length, // Only show 1 item if myCarz is not empty

                  itemBuilder: (BuildContext context, int index) {
                    final carz = myCars[index];
                    String myRenewal = carz['vehicle_license'] != null
                        ? carz['vehicle_license'].toString()
                        : '0';
                    print('my renew');
                    print(carz['vehicle_license']);
                    String daysDifferenceText = '';
                    int daysDifference = 0;
                    if (myRenewal != '0') {
                      myRenewal = myRenewal.replaceAll('/', '-');
                      print('my renew 33');
                      DateTime renewalDate = DateTime.parse(myRenewal);
                      Duration difference =
                          renewalDate.difference(DateTime.now());
                      daysDifference = difference.inDays;
                      daysDifferenceText =
                          daysDifference < 1 ? "" : "exp. $daysDifference days";
                    }

                    return GestureDetector(
                      onTap: () {
                        print('tapping ss');
                        print(carz);
                        showMoticarBottom(
                          context: context,
                          child: FractionallySizedBox(
                            heightFactor: 0.89,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                              child: MyCarInfoPage(
                                exp: daysDifferenceText.isNotEmpty
                                    ? daysDifference
                                    : 0,
                                bodyStyle: carz['category']['name'],
                                cylinder: carz['details']['cylinder'],
                                segment: carz['details']['segment'],
                                fuelCapacity:
                                    carz['details']['fuel_capacity'] ?? '',
                                driveType: carz['details']['drive_type'] ?? '',
                                acceleration:
                                    carz['details']['acceleration'].toString(),
                                topSpeed:
                                    carz['details']['top_speed'].toString(),
                                tyreSize:
                                    carz['details']['tyre_size'].toString(),
                                id: carz['id'],
                                plateNumber: carz['plate_number'],
                                chasisNumber: carz['chasis_number'],
                                engineNumber: carz['engine_number'],
                                dateOfPurchase:
                                    DateTime.tryParse(carz['date_of_purchase']),
                                vehicleLicense: carz['vehicle_license'],
                                roadWorthiness: carz['road_worthiness'],
                                thirdPartyInsurance:
                                    carz['third_party_insurance'],
                                engine: carz['details']['engine'].toString(),
                                gearbox: carz['details']['gearbox'].toString(),
                                car: carz['car']['name'].toString(),
                                model: carz['model']['name'].toString(),
                                category: carz['category'].toString(),
                                year: carz['details']['year'].toString(),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
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
                                    height: 50,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${carz['car']['name']} ${carz['model']['name']} ${carz['details']['year']}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontFamily: "NeulisAlt",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Visibility(
                                          visible:
                                              daysDifferenceText.isNotEmpty,
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              top: 4,
                                              bottom: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xff00343f),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            child: Text(
                                              daysDifferenceText,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontFamily: "NeulisAlt",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                                color: Color(0xff92BEC1),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: Text(
                                        "${carz['details']['engine']} . ${carz['category']['name']} . ${carz['details']['gearbox']}",
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
                              ],
                            ),
                            const SizedBox(width: 1),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8, bottom: 8.0),
                              child: GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  size: 35,
                                  color: AppColors.textGrey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: MoticarLoginButton(
              myColor: AppColors.indieC,
              borderColor: AppColors.indieC,
              height: 40,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AddCarPage(isHome: true);
                }));
              },
              child: const MoticarText(
                fontColor: AppColors.appThemeColor,
                text: 'Add Another Car',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

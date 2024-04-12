// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moticar/auth/add_car2.dart';
import 'package:moticar/models/newcars_model.dart';
import 'package:moticar/utils/validator.dart';
import 'package:moticar/widgets/eard_dialog.dart';
import 'package:moticar/widgets/eard_loader.dart';
import 'package:moticar/widgets/page_indicator.dart';
import 'package:rive/rive.dart';

// import '../../providers/app_providers.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import '../providers/app_providers.dart';
import '../utils/enums.dart';
import 'car_list_all.dart';

class AddCarPage extends StatefulHookConsumerWidget {
  const AddCarPage({super.key});

  @override
  ConsumerState<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends ConsumerState<AddCarPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final carController = TextEditingController();

  late TabController _tabController;

  String? selectCar;
  final List myCarList = [
    "TOKS - I just purchased this car as a tokunbo car",
    'NEW - This is a new car. Tear nylon.',
    "PREV - This is a car I have been using before",
    "SEC - This is a second hand car"
  ];

  String? popular;
  bool isClicked = false;

  String selectedCarName = '';
  String selectedID = '';
  List<Category> moticatz = [];
  List<Model> carmodelz = [];

  // String? withdraw;

  // String selectedAcctName = '';
  // String selectedAcctCode = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(profileProvider.notifier).getCars();
    });
  }

  @override
  void dispose() {
    carController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    final model = ref.read(profileProvider.notifier);
    // List<Category>? moticatz;
    // List<Model>? carmodelz;
    List<NewCarzModel> newCarz = state.getCars;

    // List<Category> getCategoriz = state.getCategories;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xffEEF5F5),
        appBar: AppBar(
          title: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add your car details",
                style: TextStyle(
                  fontFamily: "NeulisAlt",
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 1.2,
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "Add your car details",
                style: TextStyle(
                  fontFamily: "NeulisAlt",
                  fontSize: 13,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 1.2,
                  color: AppColors.indieC,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          elevation: 1,
          centerTitle: true,
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   icon: const Icon(
          //     Icons.arrow_back_ios_new_rounded,
          //     size: 20,
          //     color: Colors.white,
          //   ),
          // ),
          backgroundColor: AppColors.appThemeColor,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
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

                          const SizedBox(
                            height: 10,
                          ),

                          //
                          Container(
                            padding: const EdgeInsets.all(15),
                            // alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(20),
                                color: const Color(0xffECE6B7)),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                top: 8,
                                bottom: 8,
                              ),
                              child: Text(
                                "We promise not to share information about your vehicle with anyone. All information provided is to provide tailor made experience for you.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "NeulisAlt",
                                    fontSize: 12,
                                    fontStyle: FontStyle.normal,
                                    height: 1.2,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.appThemeColor),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          const Center(
                            child: Text(
                              "Select by brand",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "NeulisAlt",
                                  fontSize: 18,
                                  fontStyle: FontStyle.normal,
                                  height: 1.2,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.appThemeColor),
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 55,
                                  child: TextFormField(
                                    controller: carController,
                                    keyboardType: TextInputType.emailAddress,
                                    onTapOutside: (event) {
                                      FocusScope.of(context)
                                          .unfocus(); // Close the keyboard
                                    },
                                    textInputAction: TextInputAction.next,
                                    style: const TextStyle(
                                        fontFamily: "NeulisAlt",
                                        color: AppColors.textColor,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.2,
                                        fontSize: 16),
                                    validator: (value) =>
                                        FieldValidaor.validateEmptyfield(value!),
                                    onSaved: (value) {
                                      // email = value!;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: AppColors.red, width: 1.5),
                                      ),
                                      hintText: 'Search by car name or moticode',
                                
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
                                          fontWeight: FontWeight.w300,
                                          color: Color(0xffC1C3C3),
                                          fontSize: 13),
                                
                                      suffixIcon: const Icon(
                                        Icons.search_sharp,
                                        color: Color(0xffC1C3C3),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //

                          const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
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
                                  "Most Popular",
                                  style: TextStyle(
                                    fontFamily: "NeulisAlt",
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff202A2A),
                                    fontSize: 12,
                                  ),
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

                          const SizedBox(
                            height: 12,
                          ),

                          //most popular cars
                          Column(
                            children: [
                              if (state.loading != Loader.loading &&
                                  newCarz.isNotEmpty)
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: newCarz.length,
                                    itemBuilder: (context, index) {
                                      final moticar = newCarz[index];
                                      final categoriez = moticar.categories;

                                      // Check if categoriez is not empty and if index is within bounds
                                      if (categoriez.isNotEmpty &&
                                          index < categoriez.length) {
                                        final carModelz =
                                            categoriez[index].models;
                                        final carname = moticar.name;
                                        final carId = moticar.id;

                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              moticatz = categoriez;
                                              carmodelz = carModelz;
                                              selectedCarName = carname;
                                            });

                                            print(
                                                'my $moticatz $selectedCarName');
                                            print(
                                                'Length of categoriez: ${categoriez.length}');
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: popular == moticar.name
                                                      ? AppColors.lightGreen
                                                      : const Color(0xfff0f5f5),
                                                  width: 1,
                                                ),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.black45,
                                                    blurRadius: 0.1,
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/carLogos/toyota.svg",
                                                      ),
                                                      const SizedBox(width: 8),
                                                      popular == moticar.name
                                                          ? MoticarText(
                                                              text:
                                                                  moticar.name,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontColor:
                                                                  AppColors
                                                                      .green,
                                                            )
                                                          : MoticarText(
                                                              text:
                                                                  moticar.name,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontColor:
                                                                  const Color(
                                                                      0xff495353),
                                                            ),
                                                    ],
                                                  ),
                                                  Radio(
                                                    toggleable: true,
                                                    value: moticar.name,
                                                    activeColor:
                                                        AppColors.lightGreen,
                                                    groupValue: popular,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        popular =
                                                            value.toString();
                                                        moticatz = categoriez;
                                                        carmodelz = carModelz;
                                                        selectedCarName =
                                                            carname;

                                                        selectedID = moticar.id
                                                            .toString();
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        // Handle the case where categoriez is empty or index is out of bounds
                                        return SizedBox.shrink();
                                      }
                                    },
                                  ),
                                )
                              else if (state.loading == Loader.loading)
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MoticarLoader(
                                      size: 40,
                                    )
                                  ],
                                )
                              else
                                const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 30),
                                      MoticarText(
                                        text: 'No Cars Available',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        fontColor: AppColors.textColor,
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),

                      //

                      const Padding(
                        padding: EdgeInsets.only(
                            left: 12.0, right: 12, top: 3, bottom: 3),
                        child: Row(
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
                              "Others",
                              style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff202A2A),
                                fontSize: 12,
                              ),
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

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: TabBarView(
                          controller: _tabController,
                          children: const [
                            // All Cars
                            AllCarsPage(),
                            AllCarsPage(),
                            AllCarsPage(),
                            AllCarsPage(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //bottom
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Container(
                  // height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      // color: Color(0xffEEF5F5),
                      color: Colors.white,
                      border: Border(
                          top: BorderSide(color: Color(0xffEEF5F5), width: 4))),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8, left: 8, right: 8, top: 8),
                        child: DropdownButtonFormField(
                            icon: const Icon(Icons.keyboard_arrow_down_sharp),
                            // dropdownColor: AppColors.appThemeColor,
                            //  style: TextStyle(
                            //   color: AppColors.red,
                            // ),
                            decoration: const InputDecoration(
                              hintText: 'Select Car Status',
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
                                    color: AppColors.appThemeColor, width: 1.5),
                              ),
                            ),
                            items: myCarList
                                .map<DropdownMenuItem<String>>(
                                    (value) => DropdownMenuItem<String>(
                                        value: value.toString(),
                                        child: Text(
                                          value.toString(),
                                          style: const TextStyle(
                                              fontFamily: "NeulisAlt",
                                              color: AppColors.appThemeColor,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.2,
                                              fontSize: 12),
                                        )))
                                .toList(),
                            value: selectCar,
                            onChanged: (value) {
                              setState(() {
                                selectCar = value!;

                                // showModalBottomSheet(
                                //   context: context,
                                //   backgroundColor: Colors.white,
                                //   isScrollControlled: true,
                                //   builder: (context) => CarStatusBottomSheet(
                                //       selectCar!), // Pass the selected car status to the bottom sheet
                                // );
                              });
                            }),
                      ),

                      const SizedBox(height: 8),

                      //create an account
                      MoticarLoginButton(
                        myColor: AppColors.indieC,
                        borderColor: AppColors.indieC,
                        onTap: () async {
                          final String carStatus = selectCar.toString();
                          if (selectedCarName.isNotEmpty &&
                              carStatus.isNotEmpty) {
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
                                        borderRadius: BorderRadius.circular(10),
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

                            await Future.delayed(const Duration(seconds: 3));

                            Navigator.pop(context);

                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return AddCarPage2(
                                    carID: selectedID,
                                    // imagePath: selectedImage,
                                    carmodelz: carmodelz,
                                    moticatz: moticatz,
                                    carName: selectedCarName);
                              },
                            ));

                            //
                          } else {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return MoticarDialog(
                                  icon: const Icon(Icons.info_rounded,
                                      color: AppColors.appThemeColor, size: 50),
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarStatusBottomSheet extends StatelessWidget {
  final String selectCar;

  CarStatusBottomSheet(this.selectCar);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Car Status: $selectCar",
                style: const TextStyle(
                  fontFamily: "NeulisAlt",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              // Add additional content here
            ],
          ),
        ),
      ),
    );
  }
}

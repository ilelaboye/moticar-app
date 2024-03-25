import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moticar/auth/add_car2.dart';
import 'package:moticar/utils/validator.dart';
import 'package:moticar/widgets/page_indicator.dart';

import '../../providers/app_providers.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import 'car_list_all.dart';

class AddCarPage extends StatefulHookConsumerWidget {
  const AddCarPage({super.key});

  @override
  ConsumerState<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends ConsumerState<AddCarPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final carController = TextEditingController();

  String? selectCar;
  final List myCarList = [
    "TOKS - I just purchased this car as a tokunbo car",
    'NEW - This is a new car. Tear nylon.',
    "PREV - This is a car I have been using before",
    "SEC - This is a second hand car"
  ];

  String? popular;
  bool isClicked = false;
  String selectedImage = '';
  String selectedCarName = '';

  @override
  void initState() {
    super.initState();
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
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                flex: 4,
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
                            padding: const EdgeInsets.all(8),
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
                                TextFormField(
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
                                        letterSpacing: 1.2,
                                        fontSize: 14),

                                    suffixIcon: const Icon(
                                      Icons.search_sharp,
                                      color: Color(0xffC1C3C3),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

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
                                    letterSpacing: 1.5,
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

                          //stay signed in

                          const SizedBox(
                            height: 12,
                          ),

                          //most popular cars
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: popular == 'toyota'
                                      ? AppColors.lightGreen
                                      : const Color(0xfff0f5f5),
                                  width: 1,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black45, blurRadius: 0.1),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/carLogos/toyota.svg'),
                                      const SizedBox(width: 8),
                                      popular == 'toyota'
                                          ? const MoticarText(
                                              text: 'Toyota',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              fontColor: AppColors.green,
                                            )
                                          : const MoticarText(
                                              text: 'Toyota',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontColor: Color(0xff495353),
                                            ),
                                    ],
                                  ),
                                  Radio(
                                    toggleable: true,
                                    value: 'toyota',
                                    activeColor: AppColors.lightGreen,
                                    groupValue: popular,
                                    onChanged: (value) {
                                      setState(() {
                                        popular = value.toString();
                                           selectedImage =
                                            'assets/carLogos/toyota.svg';
                                        selectedCarName = 'Toyota';
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //kia
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: popular == 'kia'
                                      ? AppColors.lightGreen
                                      : const Color(0xfff0f5f5),
                                  width: 1,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black45, blurRadius: 0.1),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/carLogos/kia.svg'),
                                      const SizedBox(width: 8),
                                      popular == 'kia'
                                          ? const MoticarText(
                                              text: 'Kia',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              fontColor: AppColors.green,
                                            )
                                          : const MoticarText(
                                              text: 'Kia',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontColor: Color(0xff495353),
                                            ),
                                    ],
                                  ),
                                  Radio(
                                    toggleable: true,
                                    value: 'kia',
                                    activeColor: AppColors.lightGreen,
                                    groupValue: popular,
                                    onChanged: (value) {
                                      setState(() {
                                        popular = value.toString();
                                           selectedImage =
                                            'assets/carLogos/kia.svg';
                                        selectedCarName = 'Kia';
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //
                          // benzo
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: popular == 'benzo'
                                      ? AppColors.lightGreen
                                      : const Color(0xfff0f5f5),
                                  width: 1,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black45, blurRadius: 0.1),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/carLogos/mercedes.svg'),
                                      const SizedBox(width: 8),
                                      popular == 'benzo'
                                          ? const MoticarText(
                                              text: 'Mercedez Benz',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              fontColor: AppColors.green,
                                            )
                                          : const MoticarText(
                                              text: 'Mercedez Benz',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontColor: Color(0xff495353),
                                            ),
                                    ],
                                  ),
                                  Radio(
                                    toggleable: true,
                                    value: 'benzo',
                                    activeColor: AppColors.lightGreen,
                                    groupValue: popular,
                                    onChanged: (value) {
                                      setState(() {
                                        popular = value.toString();
                                           selectedImage =
                                            'assets/carLogos/mercedes.svg';
                                        selectedCarName = 'Mercedez Benz';
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //Nissan
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: popular == 'nissan'
                                      ? AppColors.lightGreen
                                      : const Color(0xfff0f5f5),
                                  width: 1,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black45, blurRadius: 0.1),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/carLogos/nissan.svg'),
                                      const SizedBox(width: 8),
                                      popular == 'nissan'
                                          ? const MoticarText(
                                              text: 'Nissan',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              fontColor: AppColors.green,
                                            )
                                          : const MoticarText(
                                              text: 'Nissan',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontColor: Color(0xff495353),
                                            ),
                                    ],
                                  ),
                                  Radio(
                                    toggleable: true,
                                    value: 'nissan',
                                    activeColor: AppColors.lightGreen,
                                    groupValue: popular,
                                    onChanged: (value) {
                                      setState(() {
                                        popular = value.toString();
                                           selectedImage =
                                            'assets/carLogos/nissan.svg';
                                        selectedCarName = 'Nissan';
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //peugeot
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: popular == 'honda'
                                      ? AppColors.lightGreen
                                      : const Color(0xfff0f5f5),
                                  width: 1,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black45, blurRadius: 0.1),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/carLogos/honda.svg'),
                                      const SizedBox(width: 8),
                                      popular == 'honda'
                                          ? const MoticarText(
                                              text: 'Honda',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              fontColor: AppColors.green,
                                            )
                                          : const MoticarText(
                                              text: 'Honda',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontColor: Color(0xff495353),
                                            ),
                                    ],
                                  ),
                                  Radio(
                                    toggleable: true,
                                    value: 'honda',
                                    activeColor: AppColors.lightGreen,
                                    groupValue: popular,
                                    onChanged: (value) {
                                      setState(() {
                                        popular = value.toString();

                                        //
                                        selectedImage  = 'assets/carLogos/honda.svg';
                                        selectedCarName = 'Honda';
                                      });

                                        
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //
                          const SizedBox(
                            height: 8,
                          ),
                        ],
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
                              "Others",
                              style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff202A2A),
                                letterSpacing: 1.5,
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
                            // controller: _tabController,
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
                        height: 12,
                      ),

                      const SizedBox(
                        height: 300,
                        child: Expanded(
                          child: TabBarView(
                            children: [
                              // All Cars
                              AllCarsPage(),
                              AllCarsPage(),
                              AllCarsPage(),
                              AllCarsPage(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //bottom
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Color(0xffEEF5F5),
                      border: Border(
                          top: BorderSide(color: Color(0xffEEF5F5), width: 4))),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: 8, left: 3, right: 3),
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

                      //create an account
                      MoticarLoginButton(
                        myColor: AppColors.indieC,
                        borderColor: AppColors.indieC,
                        onTap: () {
                          if(selectedCarName.isNotEmpty && selectedImage.isNotEmpty){

                             Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return AddCarPage2(
                                  imagePath: selectedImage, carName: selectedCarName);
                            },
                          ));
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
            ],
          ),
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

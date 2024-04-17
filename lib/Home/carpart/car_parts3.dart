// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moticar/widgets/page_indicator.dart';
import 'package:rive/rive.dart';

// import '../../providers/app_providers.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/colors.dart';
import '../../widgets/eard_dialog.dart';
import '../expense/add_expense.dart';
import '../expense/add_expense_final.dart';

class AddCarPart3 extends StatefulHookConsumerWidget {
  const AddCarPart3({
    super.key,
    required this.carParts,
    required this.partImage,
    required this.partCategory,
    required this.productName,
    required this.brand,
    required this.quantity,
    required this.condition,
    required this.description,
    required this.amount,
    required this.measurements,
  });

  final String carParts,
      partImage,
      partCategory,
      productName,
      brand,
      condition,
      description,
      amount,
      measurements;

  final int quantity;

  @override
  ConsumerState<AddCarPart3> createState() => _AddCarPart3State();
}

class _AddCarPart3State extends ConsumerState<AddCarPart3> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final state = ref.watch(profileProvider);
    // final model = ref.read(profileProvider.notifier);
    return Scaffold(
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
                      children: const [
                        Row(
                          children: [
                            PageIndicator(
                                currentPage: 4,
                                indicatorColor: AppColors.indieC,
                                inactiveIndicatorColor: Color(0xffD7E2E4),
                                totalPages: 4),
                          ],
                        ),
                        Center(
                          child: Text(
                            "This is what we got from you",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "NeulisAlt",
                                fontSize: 20,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                color: AppColors.appThemeColor),
                          ),
                        ),

                        // ${}
                        SizedBox(height: 20),
                      ],
                    ),

                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 40,
                                // width: 135,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: const Color(0xff7AE6EB),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Row(
                                  children: [
                                    //add image
                                    SvgPicture.asset(widget.partImage),
                                    const SizedBox(width: 8),

                                    MoticarText(
                                        text: widget.partCategory,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        fontColor: AppColors.textColor),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                height: 40,
                                // width: 135,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: const Color(0xffF4E67E),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Center(
                                  child: MoticarText(
                                      text: widget.carParts,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      fontColor: const Color(0xff006C70)),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 15,
                          ),

//condition
                          GestureDetector(
                            onTap: () {
                              // ignore: avoid_print
                              print(widget.condition);
                            },
                            child: Container(
                              height: 35,
                              width: 120,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: const Color(0xff425658),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: MoticarText(
                                    text: widget.condition,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    fontColor: Colors.white),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          MoticarText(
                              text: widget.brand,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontColor: const Color(0xff002D36)),

                          // #00343F

                          const SizedBox(
                            height: 15,
                          ),

                          //
                          Text(
                            // widget.description,
                            widget.productName,
                            style: const TextStyle(
                                fontFamily: "NeulisAlt",
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff00343F)),
                          ),

                          // MoticarText(
                          //     text: widget.description,
                          //     fontSize: 20,
                          //     fontWeight: FontWeight.w500,
                          //     fontColor: const Color(0xff00343F)),

                          const SizedBox(
                            height: 15,
                          ),

                          //amount
                          Row(
                            children: [
                              Text(
                                "N${widget.amount}",
                                style: const TextStyle(
                                    fontFamily: "Neulis",
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff00343F)),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                height: 30,
                                width: 40,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: const Color(0xffECE6B7),
                                    borderRadius: BorderRadius.circular(32)),
                                child: Center(
                                  child: MoticarText(
                                      text: "x${widget.quantity}",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontColor: const Color(0xff293536)),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          //measurement
                          Container(
                            height: 40,
                            width: 90,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: const Color(0xff425658),
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: MoticarText(
                                  text: widget.measurements,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  fontColor: Colors.white),
                            ),
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          //product
                          // MoticarText(
                          //     text: widget.productName,
                          //     fontSize: 14,
                          //     fontWeight: FontWeight.w500,
                          //     fontColor: const Color(0xff002D36)),

                          // //descript
                          // const SizedBox(
                          //   height: 6,
                          // ),

                          //
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 8.0, right: 8),
                          //   child: MoticarText(
                          //       text: widget.description,
                          //       fontSize: 14,
                          //       fontWeight: FontWeight.w400,
                          //       fontColor: const Color(0xff006C70)),
                          // ),

                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, right: 8),
                            child: Text(
                              // widget.description,
                              widget.description,
                              style: const TextStyle(
                                  fontFamily: "NeulisAlt",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff006C70)),
                            ),
                          ),

                          //
                          const SizedBox(
                            height: 15,
                          ),

                          //listview for product

                          SizedBox(
                            height: 150,
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 10.0,
                                      mainAxisSpacing: 10.0,
                                      childAspectRatio: 1),
                              itemCount: widget.quantity,
                              itemBuilder: (context, index) {
                                return Image.asset("assets/images/litre.png");
                              },
                            ),
                          ),

                          // Text(widget.quantity),
                        ],
                      ),
                    ),

                    //
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.10,
                    //   child: Center(
                    //     child: Container(
                    //       // height: MediaQuery.of(context).size.height * 0.4,
                    //       width: MediaQuery.of(context).size.width,
                    //       decoration:   BoxDecoration(
                    //           color: Colors.white,
                    //           // color: Colors.white,
                    //           borderRadius: BorderRadius.circular(10),
                    //           border: const Border(
                    //               top: BorderSide(
                    //                   color: Color(0xffEEF5F5), width: 4))),
                    //       padding: const EdgeInsets.all(8),
                    //       child: MoticarLoginButton(
                    //         myColor: AppColors.indieC,
                    //         borderColor: AppColors.indieC,
                    //         onTap: () async {
                    //             showDialog(
                    //               context: context,
                    //               barrierDismissible: true,
                    //               builder: (context) {
                    //                 return Center(
                    //                   child: AlertDialog(
                    //                     backgroundColor:
                    //                         AppColors.appThemeColor,
                    //                     shadowColor: AppColors.appThemeColor,
                    //                     content: Container(
                    //                       padding: const EdgeInsets.all(20),
                    //                       decoration: BoxDecoration(
                    //                         borderRadius:
                    //                             BorderRadius.circular(10),
                    //                       ),
                    //                       child: const Column(
                    //                         mainAxisSize: MainAxisSize.min,
                    //                         children: [
                    //                           // const SpinKitWave(
                    //                           //   color: AppColors.appThemeColor,
                    //                           //   size: 30.0,
                    //                           // ),

                    //                           SizedBox(
                    //                             height: 100,
                    //                             width: 100,
                    //                             child: RiveAnimation.asset(
                    //                               'assets/images/preloader.riv',
                    //                             ),
                    //                           ),
                    //                           SizedBox(height: 8),
                    //                           Text('Processing, please wait.',
                    //                               textAlign: TextAlign.center,
                    //                               style: TextStyle(
                    //                                   color: Colors.white))
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 );
                    //               },
                    //             );

                    //             await Future.delayed(
                    //                 const Duration(seconds: 3));

                    //             Navigator.pop(context);

                    //             // Navigator.push(context, MaterialPageRoute(
                    //             //   builder: (context) {
                    //             //     return AddCarPage2(
                    //             //         imagePath: selectedImage,
                    //             //         carName: selectedCarName);
                    //             //   },
                    //             // ));

                    //             //
                    //         },
                    //         child: const MoticarText(
                    //           fontColor: AppColors.appThemeColor,
                    //           text: 'Done',
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.w700,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),

          //bottom
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Color(0xffEEF5F5),
                        // color: Colors.white,
                        border: Border(
                            top: BorderSide(
                                color: Color(0xffEEF5F5),
                                width: 4,
                                style: BorderStyle.solid))),
                    padding: const EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30),
                      child: MoticarLoginButton(
                        myColor: AppColors.indieC,
                        borderColor: AppColors.indieC,
                        onTap: () async {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return AddExpensesFinalPage(
                                  imagePath: widget.partImage,
                                  quantity: widget.quantity.toString(),
                                  measure: widget.measurements,
                                  conditionz: widget.condition,
                                  brand: widget.brand,
                                  productName: widget.productName,
                                  carParts: widget.carParts,
                                  amountz: widget.amount);
                            },
                          ));
                        },
                        child: const MoticarText(
                          fontColor: AppColors.appThemeColor,
                          text: 'Done',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

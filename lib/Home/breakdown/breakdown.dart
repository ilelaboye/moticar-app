import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:moticar/widgets/app_texts.dart';

import '../../models/expensesmodel.dart';
import '../../widgets/colors.dart';

class BreakDownPage extends StatefulWidget {
  const BreakDownPage(
      {super.key,
      required this.imagePath,
      required this.category,
      required this.amount,
      required this.paymode,
      required this.title,
      required this.description,
      required this.carparts});
  final String imagePath, category, amount, paymode, title, description;
  final List<Carpart> carparts;

  @override
  State<BreakDownPage> createState() => _BreakDownPageState();
}

class _BreakDownPageState extends State<BreakDownPage> {
  final NumberFormat nairaFormat = NumberFormat.currency(
    symbol: 'N ', //₦
    // decimalDigits: 0,
    locale: 'en_NG',
  );
  @override
  Widget build(BuildContext context) {
    String newAmount = widget.amount.replaceAll(",", '');
    return Scaffold(
      backgroundColor: const Color(0xffB8F2F4),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: getImageColor(widget.category.toString()),
                            // borderRadius: BorderRadius.circular(32)
                          ),
                          child: getImageWidget(
                            widget.category.toString(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(widget.category.toString()),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close_rounded))
                  ],
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //amount and mode of payment
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.amount,
                        style: const TextStyle(
                          fontFamily: "NeulisAlt",
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: AppColors.appThemeColor,
                        ),
                      ),

                      const SizedBox(
                        width: 8,
                      ),

                      //
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            // shape: BoxShape.circle,
                            color: AppColors.appThemeColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            widget.paymode,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: "NeulisAlt",
                              fontSize: 12,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  //title
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontFamily: "NeulisAlt",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.appThemeColor,
                    ),
                  ),

                  //description
                  Text(
                    widget.description,
                    style: const TextStyle(
                      fontFamily: "NeulisAlt",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff495353),
                    ),
                  ),
                ],
              ),

              //
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xff7AE6EB),
                    borderRadius: BorderRadius.circular(64),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                        child: Divider(
                          thickness: 1.5,
                          color: AppColors.divider,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Cost Incured',
                        style: TextStyle(
                          fontFamily: "NeulisAlt",
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Color(0xff00232A),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        width: 50,
                        child: Divider(
                          thickness: 1.5,
                          color: AppColors.divider,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //costs  list

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.26,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: widget.carparts.length,
                  itemBuilder: (context, index) {
                    final mycarparts = widget.carparts[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              getCarParts(mycarparts.category.toString()),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 6, top: 2, bottom: 2, right: 6),
                                decoration: BoxDecoration(
                                    color: AppColors.yellow,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Text(
                                  '${mycarparts.quantity}',
                                  style: const TextStyle(
                                    fontFamily: "NeulisAlt",
                                    // color: Color(0xff002D36),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.appThemeColor,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(mycarparts.productName.toString(),
                                  style: const TextStyle(
                                      fontFamily: "NeulisAlt",
                                      color: Color(0xff002D36),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                              //
                              Text(
                                mycarparts.category.toString(),
                                style: const TextStyle(
                                    fontFamily: "NeulisAlt",
                                    color: Color(0xffC1C3C3),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),

                          //
                          Row(
                            children: [
                              Text(
                                nairaFormat
                                    .format(double.parse(mycarparts.total)),
                                style: const TextStyle(
                                    fontFamily: "Neulis",
                                    color: Color(0xff006C70),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              PopupMenuButton(
                                surfaceTintColor: Colors.white,
                                shadowColor: const Color(0xffC1C3C3),
                                // color: const Color(0xffC1C3C3),
                                itemBuilder: (BuildContext context) => [
                                  PopupMenuItem(
                                    value: 'edit',
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/svgs/edit.svg'),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        const Text('Edit'),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'strike_off',
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/svgs/strike.svg'),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        const Text('Strike off'),
                                      ],
                                    ),
                                  ),
                                ],
                                onSelected: (String value) {
                                  if (value == 'edit') {
                                    // Handle edit action
                                  } else if (value == 'strike_off') {
                                    // Handle strike off action
                                  }
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),

              // sum total
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(2),
                            topRight: Radius.circular(2)),
                        color: Color(0xff92BEC1),
                        // breakdown.imageColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total :',
                            style: TextStyle(
                              fontFamily: "NeulisAlt",
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color(0xff00232A),
                            ),
                          ),
                          Text(
                            'N ${calculateTotalExpense(
                              widget.carparts,
                            )}',
                            style: const TextStyle(
                              fontFamily: "NeulisAlt",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.appThemeColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //total
                    Container(
                      padding: const EdgeInsets.only(
                          top: 20, left: 12, right: 12, bottom: 20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4)),
                        color: AppColors.appThemeColor,
                        // breakdown.imageColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Sum Total of Expenses:',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: "NeulisAlt",
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color(0xff7AE6EB),
                            ),
                          ),
                          Text(
                            // widget.amount,
                            'N ${calculateTotalExpense(widget.carparts)}',
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontFamily: "NeulisAlt",
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //divider
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(
                  thickness: 0.8,
                  color: Color(0xff5E7A7C),
                  // indent: 20,
                ),
              ),

              //strike
              Row(
                children: [
                  //delete
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: MoticarLoginButton(
                        borderColor: const Color(0xff006C70),
                        myColor: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/svgs/strike.svg'),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Strike Off',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'NeulisAlt',
                                color: Color(0xff006C70),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
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
                        borderColor: const Color(0xff29D7DE),
                        myColor: const Color(0xff29D7DE),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svgs/new_edit.svg',
                              color: AppColors.appThemeColor,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Edit',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'NeulisAlt',
                                color: AppColors.appThemeColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  int calculateTotalExpense(List<Carpart> expenses) {
    int total = 0;
    for (var expense in expenses) {
      total += double.parse(expense.total).toInt();
    }
    return total;
  }

  Color getImageColor(String category) {
    switch (category) {
      case 'Body works':
        return AppColors.anotherYellow; // Set color for bodywork category
      case 'Engine':
        return AppColors.diaColor; // Set color for engine category
      case 'Servicing':
        return const Color(0xff006C70);
      case 'Keywork':
        return AppColors.yellow;
      case 'Balancing':
      case 'Car Wash':
        return const Color(0xff00AEB5);
      case 'Dues':
        return const Color(0xff00AEB5);

      case 'Electronics':
        return const Color(0xff00AEB5);
      case 'Fuel':
        return const Color(0xffB8F2F4);
      case 'Hydraulics':
        return const Color(0xff00AEB5);
      case 'Alignment':
        return const Color(0xff29D7DE);

      case 'Tyre':
        return AppColors.textGrey;
      default:
        return AppColors
            .skipColor; // Default color if no specific color is available
    }
  }

  //images based on category
  Widget getImageWidget(String category) {
    switch (category) {
      case 'Body works':
        return SvgPicture.asset(
          'assets/expenseCatIcons/bodywork.svg',
        );
      case 'Engine':
        return SvgPicture.asset('assets/expenseCatIcons/engine.svg');

      case 'Tyre Guage':
        return SvgPicture.asset('assets/expenseCatIcons/tyreGuage.svg');

      case 'Balancing':
        return SvgPicture.asset('assets/expenseCatIcons/balancing.svg');

      case 'Car Wash':
        return SvgPicture.asset('assets/expenseCatIcons/carWash.svg');

      case 'Dues':
        return SvgPicture.asset('assets/expenseCatIcons/dues.svg');

      case 'Electronics':
        return SvgPicture.asset('assets/expenseCatIcons/electronics.svg');

      case 'Fuel':
        return SvgPicture.asset('assets/expenseCatIcons/fuel.svg');

      case 'Hydraulics':
        return SvgPicture.asset('assets/expenseCatIcons/hydraulic.svg');

      case 'Keywork':
        return SvgPicture.asset('assets/expenseCatIcons/keywork.svg');

      case 'Mechanical':
        return SvgPicture.asset('assets/expenseCatIcons/mechanicalWork.svg');

      case 'Misc':
        return SvgPicture.asset('assets/expenseCatIcons/misc.svg');

      case 'Parking':
        return SvgPicture.asset('assets/expenseCatIcons/parking.svg');

      case 'Penalty':
        return SvgPicture.asset('assets/expenseCatIcons/penalty.svg');

      case 'Radiator':
        return SvgPicture.asset('assets/expenseCatIcons/radiator.svg');

      case 'Servicing':
        return SvgPicture.asset('assets/expenseCatIcons/servicing.svg');

      case 'Tow':
        return SvgPicture.asset('assets/expenseCatIcons/tow.svg');

      case 'Tyre guage':
        return SvgPicture.asset('assets/expenseCatIcons/tyreGuage.svg');
      // Add more cases for other categories if needed
      default:
        // Return a default image or null if no specific image is available
        return SvgPicture.asset("assets/expenseCatIcons/alignment.svg");
    }
  }

//carpart images
  Widget getCarParts(String category) {
    switch (category) {
      case 'Brake pad':
        return SvgPicture.asset(
          'assets/carPartsIcons/brakes.svg',
        );

      case 'Tyre':
        return SvgPicture.asset(
          'assets/carPartsIcons/tyres.svg',
        );
      //
      case 'Air Conditioning':
        return SvgPicture.asset(
          'assets/carPartsIcons/Air Conditioning.svg',
        );
      case 'Auto Car Care':
        return SvgPicture.asset(
            'assets/carPartsIcons/autodetailingCarCare.svg');

      case 'Bearing':
        return SvgPicture.asset('assets/carPartsIcons/bearings.svg');

      case 'Belts Chains':
        return SvgPicture.asset('assets/carPartsIcons/BeltsChainsRollers.svg');

      case 'Body':
        return SvgPicture.asset('assets/carPartsIcons/body.svg');

      case 'Brakes':
        return SvgPicture.asset('assets/carPartsIcons/brakes.svg');

      case 'Car Accessories':
        return SvgPicture.asset('assets/carPartsIcons/carAccessories.svg');

      case 'Clutch':
        return SvgPicture.asset('assets/carPartsIcons/clutch.svg');

      case 'Damping':
        return SvgPicture.asset('assets/carPartsIcons/Damping.svg');

      case 'Drive Shaft':
        return SvgPicture.asset('assets/carPartsIcons/driveShaftCVJoint.svg');

      case 'Electrics':
        return SvgPicture.asset('assets/carPartsIcons/electrics.svg');

      case 'Engine oil':
        return SvgPicture.asset('assets/carPartsIcons/engine.svg');

      // case 'Engine':
      // return SvgPicture.asset('assets/carPartsIcons/engine.svg');

      case 'Engine Cooling System':
        return SvgPicture.asset('assets/carPartsIcons/EngineCoolingSystem.svg');

      case 'Exhaust':
        return SvgPicture.asset('assets/carPartsIcons/exhaust.svg');

      case 'Fastners':
        return SvgPicture.asset('assets/carPartsIcons/fastners.svg');

      case 'Filters':
        return SvgPicture.asset('assets/carPartsIcons/filters.svg');

      // case 'Engine Cooling System':
      //   return SvgPicture.asset('assets/carPartsIcons/fuelSupplySystem.svg');

      case 'Gasket':
        return SvgPicture.asset('assets/carPartsIcons/gasket.svg');

      //ignition
      case 'Ignition':
        return SvgPicture.asset(
            'assets/carPartsIcons/ignitionPreheatingSystem.svg');

      //interior
      case 'Interior':
        return SvgPicture.asset(
            'assets/carPartsIcons/ignitionPreheatingSystem.svg');

      //light
      case 'Lighting':
        return SvgPicture.asset('assets/carPartsIcons/lighting.svg');

      // Add more cases for other categories if needed
      default:
        // Return a default image or null if no specific image is available
        return SvgPicture.asset("assets/carPartsIcons/body.svg");
    }
  }
}

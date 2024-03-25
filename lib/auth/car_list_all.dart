import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllCarsPage extends StatefulWidget {
  const AllCarsPage({super.key});

  @override
  State<AllCarsPage> createState() => _AllCarsPageState();
}

class _AllCarsPageState extends State<AllCarsPage> {
  // Placeholder data for cars, you can replace it with your actual data
  List<String> cars = [
    'Audi',
    'Benz',
    'Aston Martin',
    'Fiat',
    'Dacia',
    'Chevrolet',
    'Ford',
    'BMW',
    'Bentley',
    'Bugatti',
  ];

  // String carImage = 'assets/carLogos/gordon.svg';

  List<String> carImage = [
    'assets/carLogos/audi.svg',
    'assets/carLogos/mercedes.svg',
    'assets/carLogos/aston-martin.svg',
    'assets/carLogos/fiat.svg',
    'assets/carLogos/dacia.svg',
    "assets/carLogos/chevrolet.svg",
    "assets/carLogos/ford.svg",
    "assets/carLogos/bmw.svg",
    'assets/carLogos/bentley.svg',
    "assets/carLogos/bugatti.svg",
    'assets/carLogos/gordon.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 2.5, // Adjust as needed
        ),
        itemCount: cars.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 50,
            child: Card(
              elevation: 2,
              surfaceTintColor: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    carImage[index],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    cars[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: "NeulisAlt",
                        color: Color(0xff495353),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

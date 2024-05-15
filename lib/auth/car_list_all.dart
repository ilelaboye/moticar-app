import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moticar/providers/car_provider.dart';
import 'package:moticar/utils/constants.dart';
import 'package:moticar/widgets/flushbar.dart';

import '../services/hivekeys.dart';
import '../services/localdatabase.dart';

class AllCarsPage extends StatefulWidget {
  List<dynamic> carsData;
  String letters;
  AllCarsPage({super.key, required this.carsData, required this.letters});

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
    "Gordon",
    "Geely",
  ];

  // String carImage = 'assets/carLogos/gordon.svg';

  List<dynamic> carsData = [];
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
    "assets/carLogos/geely.svg"
  ];

  @override
  void initState() {
    filterCar();
    super.initState();
  }

  filterCar() {
    if (widget.letters == 'all') {
      carsData = widget.carsData;
    } else {
      List<String> arr = widget.letters.split(',');
      print('list arr ${widget.letters}');
      List<dynamic> filtered = [];
      for (int i = 0; i < arr.length; i++) {
        var c = widget.carsData
            .where((element) => element['name'][0] == arr[i])
            .toList();

        if (c.isNotEmpty) {
          filtered.addAll(c);
        }
      }
      print('aft fil');
      print(filtered);
      carsData = filtered;
    }
  }

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
        // itemCount: cars.length,
        shrinkWrap: true,
        itemCount: carsData.length,

        itemBuilder: (BuildContext context, int index) {
          final car = carsData[index];
          final carName = car["name"];
          final carIcon = car["icon"];
          final carId = car['id'];
          return SizedBox(
            height: 50,
            child: Card(
              elevation: 2,
              surfaceTintColor: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, top: 8, bottom: 8),
                    child: Image.network(
                      carIcon,
                      width: 30,
                      height: 30,
                      errorBuilder: (context, error, stackTrace) =>
                          SvgPicture.network(
                        carIcon,
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    carName,
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

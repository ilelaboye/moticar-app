import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../services/hivekeys.dart';
import '../services/localdatabase.dart';

class AllCarsPage extends StatefulWidget {
  const AllCarsPage({super.key});

  @override
  State<AllCarsPage> createState() => _AllCarsPageState();
}

class _AllCarsPageState extends State<AllCarsPage> {
  Future<void> fetchData() async {
    final String token = HiveStorage.get(HiveKeys.token);
    String apiUrl = 'https://moticar.ngvoices.ng/api/v1/get-cars';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json', // Adjust content type if needed
      },
    );

    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      final List<dynamic> data = parsedResponse['data'];
      final List<Map<String, dynamic>> carDataList =
          data.cast<Map<String, dynamic>>();

      setState(() {
        carsData = carDataList;
        // selectedStates = List<bool>.filled(carsData.length, false);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<Map<String, dynamic>> carsData = [];

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
                  // SvgPicture.asset(
                  //   carImage[index],
                  // ),
                  Image.network(
                    carIcon,
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(width: 8),
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

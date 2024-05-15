import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:moticar/models/expensesmodel.dart';
import 'package:moticar/network/dio.dart';
import 'package:moticar/utils/constants.dart';

class CarProvider with ChangeNotifier {
  late DioClient req;
  late List<Map<String, dynamic>> myCars;

  CarProvider() {
    req = DioClient(Dio());
  }

  Future<Map<String, dynamic>> getCars(BuildContext context) async {
    print('get all cars click');
    Map<String, dynamic> res = await req.get(context, "get-cars");
    if (res['status']) {
      return {'status': true, 'data': res['data']};
    } else {
      return {'status': false, 'data': res['message']};
    }
  }

  Future<Map<String, dynamic>> getMyCars(BuildContext context) async {
    Map<String, dynamic> res = await req.get(context, "get-my-cars");
    if (res['status']) {
      print('get my cars click');
      print(res['data']['data']);
      return {'status': true, 'data': res['data']['data'] as List<dynamic>};
    } else {
      return {'status': false, 'data': res['message']};
    }
  }
}

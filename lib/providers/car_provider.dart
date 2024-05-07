import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:moticar/network/dio.dart';
import 'package:moticar/utils/constants.dart';

class CarProvider with ChangeNotifier {
  late DioClient req;

  CarProvider() {
    req = DioClient(Dio());
  }
}

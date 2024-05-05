import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:moticar/network/dio.dart';
import 'package:moticar/utils/constants.dart';

class CarProvider with ChangeNotifier {
  late DioClient req;

  CarProvider() {
    req = DioClient(Dio(), Constant.baseUrl);
  }

  Future<Map<String, dynamic>> forgotPassword(
    BuildContext context,
    String email,
  ) async {
    Response res = await req.post(context, "auth/forgot-password", data: {
      "email": email,
    });
    return {'status': true, 'data': res.data};
  }

  Future<Map<String, dynamic>> verifyResetToken(
      BuildContext context, String email, String token) async {
    Response res = await req.post(context, "auth/verify-forgot-password-token",
        data: {"email": email, "token": token});
    return {'status': true, 'data': res.data};
  }

  //add expense

  Future<Map<String, dynamic>> addNewExpense(
      BuildContext context, String email, String token) async {
    Response res = await req.post(context, "auth/verify-forgot-password-token",
        data: {"email": email, "token": token});
    return {'status': true, 'data': res.data};
  }
}

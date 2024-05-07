import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:moticar/network/dio.dart';
import 'package:moticar/utils/constants.dart';

class Authentication with ChangeNotifier {
  late DioClient req;

  Authentication() {
    req = DioClient(Dio());
  }

  Future<Map<String, dynamic>> register1(
      BuildContext context, String email, String phone) async {
    print('signup 1 click');
    Map<String, dynamic> res = await req.post(context, "auth/register-email",
        data: {"email": email, "phone": phone});
    if (res['status']) {
      return {'status': true, 'data': res['data']};
    } else {
      return {'status': false, 'message': res['message']};
    }
  }

  Future<Map<String, dynamic>> getOnboardingScreen(
    BuildContext context,
  ) async {
    Map<String, dynamic> res =
        await req.get(context, "auth/get-onboarding-screens");

    if (res['status']) {
      return {'status': true, 'data': res['data']['data']};
    } else {
      return {'status': true, 'data': res['message']};
    }
  }

  Future<Map<String, dynamic>> forgotPassword(
    BuildContext context,
    String email,
  ) async {
    print('forgot click');
    Map<String, dynamic> res =
        await req.post(context, "auth/forgot-password", data: {
      "email": email,
    });
    if (res['status']) {
      return {'status': true, 'data': res['data']};
    } else {
      return {'status': true, 'data': res['message']};
    }
  }

  Future<Map<String, dynamic>> verifyResetToken(
      BuildContext context, String email, String token) async {
    print('reset click');

    Map<String, dynamic> res = await req.post(
        context, "auth/verify-forgot-password-token",
        data: {"email": email, "token": token});
    print('reset click ress');
    print(res);
    if (res['status']) {
      // print('yes from');
      return {'status': true, 'data': res['data']};
    } else {
      return {'status': false, 'data': res['message']};
    }
  }
}

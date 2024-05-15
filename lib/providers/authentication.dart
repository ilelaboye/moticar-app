import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:moticar/models/onboarding.dart';
import 'package:moticar/network/dio.dart';
import 'package:moticar/services/hivekeys.dart';
import 'package:moticar/services/localdatabase.dart';
import 'package:moticar/utils/constants.dart';

class Authentication with ChangeNotifier {
  late DioClient req;

  Authentication() {
    req = DioClient(Dio());
  }

  static Future<void> setUser(Map user) async {
    await HiveStorage.put(HiveKeys.user, user);
  }

  static Future<Map> getUser() async {
    var user = await HiveStorage.get(HiveKeys.user);
    return user;
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
      return {'status': false, 'data': res['message']};
    }
  }

  Future<Map<String, dynamic>> resetPassword(
      BuildContext context, String password) async {
    print('reset psw click');
    Map<String, dynamic> res = await req.post(context, "reset-password", data: {
      "new_password": password,
    });
    if (res['status']) {
      return {'status': true, 'data': res['data']};
    } else {
      return {'status': false, 'data': res['message']};
    }
  }

  Future<Map<String, dynamic>> changePassword(
      BuildContext context, String password, String new_password) async {
    print('forgot click');
    Map<String, dynamic> res = await req.post(context, "change-password",
        data: {"old_password": password, "new_password": new_password});
    if (res['status']) {
      return {'status': true, 'data': res['data']};
    } else {
      return {'status': false, 'data': res['message']};
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
      return {'status': false, 'data': res['message']};
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

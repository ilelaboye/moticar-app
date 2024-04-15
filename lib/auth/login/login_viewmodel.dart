// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../network/dio_utils.dart';
import '../../providers/app_providers.dart';
import '../../services/hivekeys.dart';
import '../../services/local_authentication/local_auth.dart';
import '../../services/localdatabase.dart';
import '../../utils/enums.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  final Ref _ref;
  LoginViewModel(this._ref) : super(LoginState());

  Future<ApiResponse> login({required Map<String, dynamic> formData}) async {
    state = state.copyWith(
      loadStatus: Loader.loading,
    );

    final String? existingUser = await HiveStorage.get(HiveKeys.phonenumber);

    try {
      final response = await _ref
          .read(serviceProvider)
          .post(formData: formData, path: 'auth/login');

      var body = response.data;
      if (response.statusCode == 200) {
        // await HiveStorage.put(HiveKeys.userId, body['data']['_id']);
        await HiveStorage.put(HiveKeys.token, body['data']['token']);
        // await HiveStorage.put(HiveKeys.phonenumber, formData["phonenumber"]);
        await HiveStorage.put(HiveKeys.firstname, body['data']["first_name"]);
        await HiveStorage.put(HiveKeys.lastname, body['data']["last_name"]);
        await HiveStorage.put(HiveKeys.midname, body['data']["preferred_name"]);
        await HiveStorage.put(HiveKeys.userId, body['data']["uuid"]);
        await HiveStorage.put(HiveKeys.image, body['data']["image"]);
        //
        await HiveStorage.put(HiveKeys.currency, body['data']["currency"]);

        //referral
        await HiveStorage.put(HiveKeys.referral, body['data']["referral_code"]);

        await HiveStorage.put(HiveKeys.userPassword, formData["password"]);
        await HiveStorage.put(HiveKeys.hasLoggedIn, true);

        if (existingUser == null) {
          await HiveStorage.put(HiveKeys.phonenumber, formData["email"]);
          // await HiveStorage.put(HiveKeys.deviceId, body['data']['device_id']);
        }

        state = state.copyWith(
          loadStatus: Loader.loaded,
          // id: body['data']['_id'],
          // role: body['data']['roleName']
        );
        return ApiResponse(
          successMessage: body["message"] ?? "Success",
        );
      } else {
        state = state.copyWith(
          loadStatus: Loader.error,
        );
        return ApiResponse(
          errorMessage: body["message"] ?? "Login Failed",
        );
      }
    } on DioError catch (e) {
      // if (e.type == DioErrorType.response ||
      //     e.type == DioErrorType.receiveTimeout ||
      //     e.type == DioErrorType.connectTimeout ||
      //     e.type == DioErrorType.other) {
      //   // Handle no internet connection or connection error here
      //   return ApiResponse(
      //     errorMessage: e.response!.data['message'],
      //   );
      //   // "Check your data connection / Connection error");
      // } else {
      //   // Handle other DioErrors
      //   return ApiResponse(
      //     errorMessage: e.response!.data['message'],
      //   );
      // }

      // 07080204007
      // Dhaniel@ije2

      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.response ||
          e.type == DioErrorType.other) {
        state = state.copyWith(loadStatus: Loader.error);
        return ApiResponse(
            errorMessage: e.response?.data["message"] ??
                "Poor network connection. Please try again");
      } else {
        state = state.copyWith(loadStatus: Loader.error);
        return ApiResponse(
            errorMessage:
                e.response?.data["message"] ?? "Something unexpected happened");
      }
    } catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      return ApiResponse(errorMessage: "Something unexpected happened");
    }
  }

  Future<ApiResponse> loginManager(
      {required Map<String, dynamic> formData}) async {
    state = state.copyWith(
      loadStatus: Loader.loading,
    );

    final String? existingUser = await HiveStorage.get(
      HiveKeys.userEmail,
    );

    try {
      final response = await _ref
          .read(serviceProvider)
          .post(formData: formData, path: 'auth/login/');

      var body = response.data;
      if (response.statusCode == 200 &&
          // response.data != null &&
          response.data['status'] == true) {
        // await HiveStorage.put(HiveKeys.userId, body['data']['_id']);
        await HiveStorage.put(HiveKeys.token, body['token']);
        await HiveStorage.put(HiveKeys.userEmail, formData["email"]);
        await HiveStorage.put(HiveKeys.userPassword, formData["password"]);
        await HiveStorage.put(HiveKeys.hasLoggedIn, true);

        if (existingUser == null) {
          await HiveStorage.put(HiveKeys.userEmail, formData["email"]);
        }

        state = state.copyWith(
          loadStatus: Loader.loaded,
          // id: body['data']['_id'],
        );
        return ApiResponse(
          successMessage: body["message"],
        );
      } else {
        state = state.copyWith(
          loadStatus: Loader.error,
        );

        return ApiResponse(
          errorMessage: body["message"],
        );
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.response ||
          e.type == DioErrorType.other) {
        state = state.copyWith(loadStatus: Loader.error);
        return ApiResponse(
            errorMessage: e.response?.data["message"] ??
                "Poor network connection. Please try again");
      } else {
        state = state.copyWith(loadStatus: Loader.error);
        return ApiResponse(
            errorMessage:
                e.response?.data["message"] ?? "Something unexpected happened");
      }
    } catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      return ApiResponse(
        errorMessage: "Error connecting, Please try again",
      );
    }
  }

  Future<ApiResponse> loginWithBioMetric() async {
    final isAuthenticated = await LocalAuthApi.authenticate();
    if (isAuthenticated) {
      //  String input = emailController.text.trim();

      final response = await login(formData: {
        // "email": HiveStorage.get(HiveKeys.userEmail),
        "phonenumber": HiveStorage.get(HiveKeys.phonenumber),
        "password": HiveStorage.get(HiveKeys.userPassword),
        // "device_id": HiveStorage.get(
        //   HiveKeys.deviceId,
        // )
      });
      if (response.successMessage.isNotEmpty) {
        return ApiResponse(successMessage: 'Login Successful');
      } else {
        return ApiResponse(errorMessage: 'Login not successful');
      }
    } else {
      return ApiResponse();
    }
  }

  Future<ApiResponse> phoneChanged({
    required Map<String, dynamic> formData,
  }) async {
    state = state.copyWith(
      loadStatus: Loader.loading,
    );
    try {
      final response = await _ref.read(serviceProvider).postWithToken(
            formData: formData,
            path: "auth/reset/device",
          );
      var body = response.data;
      if (response.statusCode == 200) {
        state = state.copyWith(
          loadStatus: Loader.loaded,
        );
        return ApiResponse(
          successMessage: body["message"],
        );
      } else {
        state = state.copyWith(
          loadStatus: Loader.error,
        );
        return ApiResponse(
          errorMessage: body["message"],
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      if (e.response != null &&
          e.response!.data['message'] != null &&
          e.response!.data['message'] is String &&
          e.response!.data['message'].isNotEmpty) {
        return ApiResponse(
          errorMessage: e.response!.data['message'],
        );
      }

      return ApiResponse(
        errorMessage: e.response?.data['message'],
      );
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      rethrow;
    }
  }
}

class LoginState {
  Loader loadStatus;
  // DataModel? newprofileModel;
  String? id;
  String? role;

  LoginState({this.loadStatus = Loader.idle, this.role, this.id});

  LoginState copyWith({
    Loader? loadStatus,
    // DataModel? newprofileModel,
    String? id,
    String? role,
  }) {
    return LoginState(
        loadStatus: loadStatus ?? this.loadStatus,
        id: id ?? this.id,
        role: role ?? this.role);
  }
}

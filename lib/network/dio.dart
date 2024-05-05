import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:moticar/utils/constants.dart';
import 'package:moticar/widgets/flushbar.dart';

class DioClient extends ChangeNotifier {
  final Dio _dio;
  final String? token;
  String baseUrl = Constant.baseUrl;

  DioClient(this._dio, this.baseUrl, {this.token}) {
    _dio
      ..options.baseUrl = baseUrl ?? ""
      ..options.connectTimeout = Constant.connectionTimeout
      ..options.receiveTimeout = Constant.receiveTimeout
      ..options.responseType = ResponseType.json
      ..options.headers = {
        "Accept": "*/*",
        "Content-Type": "application/json",
        "Authorization": "Basic $token",
      };
  }

  Future<Response> get(context, String url,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
      dynamic method}) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: {"Authorization": "Basic $token"}),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      // showTopSnackBar(
      //   Overlay.of(context),
      //   CustomSnackBar.error(
      //     message: errorMessage,
      //   ),
      // );
      Alert.showNotificationError(
        message: errorMessage,
        context: context,
        notificationType: 1,
      );
      throw errorMessage;
    }
  }

  Future<Response> post(context, String url,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      callback}) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: {
          // "Authorization": "Bearer $token"
          "Content-Type": "application/json",
          "Accept": "application/json"
        }),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      // showTopSnackBar(
      //   Overlay.of(context),
      //   CustomSnackBar.error(
      //     message: errorMessage,
      //   ),
      // );

      Alert.showNotificationError(
        message: errorMessage,
        context: context,
        notificationType: 1,
      );

      throw errorMessage;
    }
  }
}

class DioExceptions implements Exception {
  String message = '';

  DioExceptions.fromDioError(DioError dioError) {
    EasyLoading.dismiss();
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with server";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with server";
        break;
      case DioErrorType.response:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with server";
        break;
      case DioErrorType.other:
        if (dioError.message!.contains("SocketException")) {
          message = 'No Internet Connection';
          break;
        }
        message = "Unexpected error occurred";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        if (error["message"].toString().isNotEmpty) {
          return error["message"];
        }
        //display the first error
        return error['errors'].values.first[0];
      case 401:
        return error['message'];
      case 403:
        return error['message'];
      case 404:
        return error['message'];
      case 409:
        return error['message'];
      case 422:
        return error["errors"].values.first[0];
      case 500:
        var error2 = jsonDecode(error);

        if (error2.containsKey('message')) {
          return error2['message'];
        } else {
          return "Error, Please try again";
        }

      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}

// ignore_for_file: override_on_non_overriding_member

import 'dart:developer';
import 'dart:io';

// import 'package:dio/adapter.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../services/hivekeys.dart';
import '../services/localdatabase.dart';
import 'moticar_network.dart';


// //up endpoint
String baseUrl = 'https://moticar.ttninternational.org/api/v1/';

 

class AgencyBackEnd implements AgencyNetwork {
  late final Dio _dio;

  AgencyBackEnd(this._dio) {
    _dio.options.baseUrl = baseUrl;

    // ignore: deprecated_member_use
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<Response> put({
    required Map<String, dynamic> formData,
    required String path,
  }) async {
    String? token = HiveStorage.get(HiveKeys.token);
    try {
      final data = await _dio.put(
        path,
        data: formData,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': "Bearer $token"
        }),
      );
      log(data.toString());
      return data;
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode! >= 500) {
        e.response!.data = {
          'message': 'Problem contacting server. Please try again later'
        };
        rethrow;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<Response> get({
    required String path,
  }) async {
    try {
      final response = await _dio.get(
        path,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
        ),
      );
      log(response.toString());
      return response;
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode! >= 500) {
        e.response!.data = {
          'message': 'Problem contacting server. Please try again later'
        };
        rethrow;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<Response> getWithToken({
    required String path,
    Map<String, dynamic>? formData,
  }) async {
    String? token = HiveStorage.get(HiveKeys.token);
    try {
      final response = await _dio.get(
        path,
        queryParameters: formData,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );
      // log(response.toString());
      return response;
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode! >= 500) {
        e.response!.data = {
          'message': 'Problem contacting server. Please try again later'
        };
        rethrow;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<void> logout() async {}

  @override
  Future<Response> post(
      {required Map<String, dynamic> formData, required String path}) async {
    try {
      final response = await _dio.post(
        path,
        data: formData,
         options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization': "Bearer $token"
        }),
      );
      return response;
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode! >= 500) {
        e.response!.data = {
          'message': 'Problem contacting server. Please try again later'
        };
        rethrow;
      } else {
        rethrow;
      }
    }
  }

    

     @override
  Future<Response> newpost(
      {required FormData formData, required String path}) async {
    try {
      final response = await _dio.post(
        path,
        data: formData,
         options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization': "Bearer $token"
        }),
      );
      return response;
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode! >= 500) {
        e.response!.data = {
          'message': 'Problem contacting server. Please try again later'
        };
        rethrow;
      } else {
        rethrow;
      }
    }
  }


  @override
  Future putMultipart({
    required Map<String, String> formData,
    required String path,
    required String pathName,
    required XFile files,
    //String? pathName2,
  }) async {
    String token = HiveStorage.get(HiveKeys.token);
    var request = http.MultipartRequest("PUT", Uri.parse("$baseUrl$path"));
    request.fields.addAll(formData);
    request.headers.addAll(
      {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    request.files.add(await http.MultipartFile.fromPath(pathName, files.path));
    http.Response resp = await http.Response.fromStream(await request.send());
    log(resp.toString());
    return resp;
  }

  @override
   Future postMultipart(
      {required Map<String, String> formData,
      required String path,
      required String pathName,
      required XFile files}) async {
    String token = HiveStorage.get(HiveKeys.token);
    var request = http.MultipartRequest("POST", Uri.parse("$baseUrl$path"));
    request.fields.addAll(formData);
    request.headers.addAll(
      {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    request.files.add(await http.MultipartFile.fromPath(pathName, files.path));
    http.Response resp = await http.Response.fromStream(await request.send());
    log(resp.toString());
    return resp;
  }

  @override
  Future postPic(
      {
      // required Map<String, String> formData,
      required String path,
      required String pathName,
      required XFile files}) async {
    String token = HiveStorage.get(HiveKeys.token);
    var request = http.MultipartRequest("POST", Uri.parse("$baseUrl$path"));
    // request.fields.addAll(formData);
    request.headers.addAll(
      {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    request.files.add(await http.MultipartFile.fromPath(pathName, files.path));
    http.Response resp = await http.Response.fromStream(await request.send());
    log(resp.toString());
    return resp;
  }

  @override
  Future<Response> postWithToken(
      {Map<String, dynamic>? formData,
      Map<String, dynamic>? queryParameters,
      required String path}) async {
    String? token = HiveStorage.get(HiveKeys.token);

    try {
      final data = await _dio.post(
        path,
        data: formData,
        queryParameters: queryParameters,
        options: Options(headers: {
          'Content-Type': 'application/json',
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        }),
      );
      log(data.toString());
      return data;
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode! >= 500) {
        e.response!.data = {
          'message': 'Problem contacting server. Please try again later'
        };
        rethrow;
      } else {
        rethrow;
      }
    }
  }

   @override
  Future<Response> postMyToken(
      {Map<String, dynamic>? formData,
      Map<String, dynamic>? queryParameters,
      required String path,
      required String token,
      }) async {
    // String? token = HiveStorage.get(HiveKeys.token);

    try {
      final data = await _dio.post(
        path,
        data: formData,
        queryParameters: queryParameters,
        options: Options(headers: {
          'Content-Type': 'application/json',
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        }),
      );
      log(data.toString());
      return data;
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode! >= 500) {
        e.response!.data = {
          'message': 'Problem contacting server. Please try again later'
        };
        rethrow;
      } else {
        rethrow;
      }
    }
  }

  //   @override
  //     Future<Response> getUserProfile({String? authToken, dynamic id}) async {
  //   try {
  //     final response = await _dio.post(
  //       "bankone/",
  //       data: ApiRequest(
  //           method: "GET",
  //           url: baseUrl +
  //               "Account/GetAccountsByCustomerId/2?authtoken=$authToken&customerId=$id",
  //           payload: {}).toJson(),
  //       options: Options(
  //         headers: {
  //           "Accept": "application/json",
  //           "Content-Type": "application/json",
  //         },
  //       ),
  //     );
  //     log(response.toString());
  //     return response;
  //   } on DioError catch (e) {
  //     if (e.response != null && e.response!.statusCode! >= 500) {
  //       e.response!.data = {
  //         'message': 'Problem contacting server. Please try again later'
  //       };
  //       rethrow;
  //     } else {
  //       rethrow;
  //     }
  //   }
  // }
}

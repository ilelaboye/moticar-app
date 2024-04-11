import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

abstract class AgencyNetwork {
  Future<Response> postWithToken(
      {required Map<String, dynamic> formData, required String path});

  Future<Response> post(
      {required Map<String, dynamic> formData, required String path});
    
  Future<Response> getWithToken({required String path});
  Future<Response> get({required String path});
  Future<void> logout();
  Future postMultipart({
    required Map<String, String> formData,
    required String path,
    required String pathName,
    required XFile files,
  });  
}

// ignore_for_file: unnecessary_null_comparison


import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../providers/app_providers.dart';
import '../../network/dio_utils.dart';
import '../../utils/enums.dart';

class RegisterViewmodel extends StateNotifier<RegisterState> {
  RegisterViewmodel(this._reader)
      : super(
          RegisterState(
              // bvnDetails: BvnDetails.fromJson({}),
              // findToken: FindToken.fromJson({}), states: [],
              ),
        );

  final Ref _reader;

  Future<ApiResponse> signUp1({
    required Map<String, dynamic> formData,
  }) async {
    // state = state.copyWith(
    //   loadStatus: Loader.loading,
    // );
    try {
      final response = await _reader.read(serviceProvider).post(
            formData: formData,
            path: "auth/register-email",
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
      return ApiResponse(
        errorMessage:
            e.response?.data['message'] ?? e.response?.data['errors']['email'],
        //  e.response!.data['message'],
      );
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      rethrow;
    }
  }

  //first sign up
  Future<ApiResponse> signUp({
    required FormData formData,
    // required XFile image,
  }) async {
    // state = state.copyWith(
    //   loadStatus: Loader.loading,
    // );
    try {
      final response = await _reader.read(serviceProvider).newpost(
            formData: formData,
            path: "auth/register",
            // pathName: 'profile_image',
            // files: image,
          );
      // var body = json.decode(response.body);
      // if (body != null) {
      if (response.statusCode == 200) {
        state = state.copyWith(
            loadStatus: Loader.loaded, token: response.data['data']['token']);
        return ApiResponse(
          successMessage: response.data["message"] ?? "Success",
        );
      } else {
        state = state.copyWith(
          loadStatus: Loader.error,
        );
        return ApiResponse(
          errorMessage: response.data["message"] ?? "Unknown error",
        );
      }
      // }
      // else {
      //   state = state.copyWith(
      //     loadStatus: Loader.error,
      //   );
      //   return ApiResponse(errorMessage: "Response body is null");
      // }
    } on DioError catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      if (e.response != null && e.response!.data != null) {
        return ApiResponse(
          errorMessage: e.response!.data['message'] ?? "Unknown error",
        );
      } else {
        return ApiResponse(errorMessage: "Connection error, please try again.");
      }
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      return ApiResponse(errorMessage: "Connection error, please try again.");
    }
  }


  //add_technician
  Future<ApiResponse> addNewTechnician({
    required FormData formData,
    // required XFile image,
  }) async {
    // state = state.copyWith(
    //   loadStatus: Loader.loading,
    // );
    try {
      final response = await _reader.read(serviceProvider).newpost(
            formData: formData,
            path: "add-technician",
            // pathName: 'profile_image',
            // files: image,
          );
      // var body = json.decode(response.body);
      // if (body != null) {
      if (response.statusCode == 200) {
        state = state.copyWith(
            loadStatus: Loader.loaded, token: response.data['data']['token']);
        return ApiResponse(
          successMessage: response.data["message"] ?? "Success",
        );
      } else {
        state = state.copyWith(
          loadStatus: Loader.error,
        );
        return ApiResponse(
          errorMessage: response.data["message"] ?? "Unknown error",
        );
      }
      // }
      // else {
      //   state = state.copyWith(
      //     loadStatus: Loader.error,
      //   );
      //   return ApiResponse(errorMessage: "Response body is null");
      // }
    } on DioError catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      if (e.response != null && e.response!.data != null) {
        return ApiResponse(
          errorMessage: e.response!.data['message'] ?? "Unknown error",
        );
      } else {
        return ApiResponse(errorMessage: "Connection error, please try again.");
      }
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      return ApiResponse(errorMessage: "Connection error, please try again.");
    }
  }

  //final signup
  Future<ApiResponse> signUpFinal({
    required Map<String, dynamic> formData,
    required String token,
  }) async {
    // state = state.copyWith(
    //   loadStatus: Loader.loading,
    // );
    try {
      final response = await _reader.read(serviceProvider).postMyToken(
            formData: formData,
            path: "update-profile",
            token: token,
            // pathName: 'profile_image',
            // files: image,
          );
      // var body = json.decode(response.body);
      // if (body != null) {
      if (response.statusCode == 200) {
        state = state.copyWith(
          loadStatus: Loader.loaded,
          // token: response.data['data']['token']
        );
        return ApiResponse(
          successMessage: response.data["message"] ?? "Success",
        );
      } else {
        state = state.copyWith(
          loadStatus: Loader.error,
        );
        return ApiResponse(
          errorMessage: response.data["message"] ?? "Unknown error",
        );
      }
      // }
      // else {
      //   state = state.copyWith(
      //     loadStatus: Loader.error,
      //   );
      //   return ApiResponse(errorMessage: "Response body is null");
      // }
    } on DioError catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      if (e.response != null && e.response!.data != null) {
        return ApiResponse(
          errorMessage: e.response!.data['message'] ?? "Unknown error",
        );
      } else {
        return ApiResponse(errorMessage: "Connection error, please try again.");
      }
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      return ApiResponse(errorMessage: "Connection error, please try again.");
    }
  }

  ApiResponse _handleImageError(DioError e) {
    if (e.response != null && e.response!.statusCode == 413) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      return ApiResponse(
        errorMessage: "Please use an image with a lesser MB size",
      );
    } else {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      return ApiResponse(
        error: e,
      );
    }
  }

  Future<ApiResponse> verifyEmail({
    required Map<String, dynamic> formData,
  }) async {
    state = state.copyWith(
      loadStatus: Loader.loading,
    );
    // formData.addAll({"bank_id": bankId});
    try {
      final response = await _reader.read(serviceProvider).post(
            formData: formData,
            path: "auth/verify-email",
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

  Future<ApiResponse> resetGenPass({
    required Map<String, dynamic> formData,
  }) async {
    // state = state.copyWith(
    //   loadStatus: Loader.loading,
    // );
    try {
      final response = await _reader.read(serviceProvider).post(
            formData: formData,
            path: "auth/resend-token",
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

      if (e.response != null && e.response!.data['message'] is String) {
        return ApiResponse(
          errorMessage: e.response!.data['message'] as String,
        );
      }
      return ApiResponse(
        errorMessage: e.response!.data['message'] as String,
      );
      // if (e.response != null &&
      //     e.response!.data['message']) {
      //   return ApiResponse(
      //     errorMessage: e.response!.data['message'],
      //   );
      // }
      // return ApiResponse(
      //   errorMessage: e.response?.data['message'],
      // );
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      rethrow;
    }
  }

  Future<ApiResponse> forgotPasswordNew({
    required Map<String, dynamic> formData,
  }) async {
    state = state.copyWith(
      loadStatus: Loader.loading,
    );
    // formData.addAll({"bank_id": bankId});
    try {
      final response = await _reader.read(serviceProvider).post(
            formData: formData,
            path: "auth/forgotpassword/mobile",
          );
      var body = response.data;
      if (response.statusCode == 200 && response.data['status'] == true) {
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
      if (e.response != null && e.response!.data['message'] is String) {
        return ApiResponse(
          errorMessage: e.response!.data['message'] as String,
        );
      }
      return ApiResponse(
        errorMessage: e.response!.data['message'] as String,
      );
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      rethrow;
    }
  }

  Future<ApiResponse> resetPassWordMobile({
    required Map<String, dynamic> formData,
  }) async {
    state = state.copyWith(
      loadStatus: Loader.loading,
    );
    // formData.addAll({"bank_id": bankId});
    try {
      final response = await _reader.read(serviceProvider).post(
            formData: formData,
            path: "auth/resetpassword/mobile",
          );
      var body = response.data;
      if (response.statusCode == 200 && response.data['status'] == true) {
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
      if (e.response != null && e.response!.data['message'] is String) {
        return ApiResponse(
          errorMessage: e.response!.data['message'] as String,
        );
      }
      return ApiResponse(
        errorMessage: e.response!.data['message'] as String,
      );
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      rethrow;
    }
  }

  Future<ApiResponse> getOTP({
    required Map<String, dynamic> formData,
  }) async {
    state = state.copyWith(
      loadStatus: Loader.loading,
    );
    // formData.addAll({"bank_id": bankId});
    try {
      final response = await _reader.read(serviceProvider).post(
          formData: formData,
          // path: "account/signup-otp/",
          path: 'auth/changepassword');
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
      return ApiResponse(
        error: e,
      );
    } catch (e) {
      state = state.copyWith(
        loadStatus: Loader.error,
      );
      rethrow;
    }
  }

//

//

  void _errorHandler(DioError e) {
    if (e.response != null && e.response!.statusCode == 400) {
      state = state.copyWith(loadStatus: Loader.loaded);
    } else {
      state = state.copyWith(loadStatus: Loader.error);
    }
  }

  // Future<ApiResponse> fetchStates() async {
  //   // Replace the API endpoint with the actual one
  //   final response =
  //       await http.get(Uri.parse('https://example.com/api/states'));

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     setState(() {
  //       states = List<String>.from(data['states']);
  //       lgas = Map<String, List<String>>.from(data['lgas']);
  //       regions = Map<String, String>.from(data['regions']);

  //       selectedState = states[0]; // Set the first state as default
  //       selectedLGA = lgas[selectedState]![
  //           0]; // Set the first LGA of the selected state as default
  //       selectedRegion = regions[selectedState]!;
  //     });
  //   } else {
  //     // Handle API error
  //     print('Failed to fetch states. Status code: ${response.statusCode}');
  //   }
  // }
}

class RegisterState {
  Loader loadStatus;
//  final List<Map<String, String>> states;
  final String? token;

  RegisterState({
    this.loadStatus = Loader.idle,
    // required this.states,
    this.token,
  });

  RegisterState copyWith({
    Loader? loadStatus,
    // List<Map<String, String>>? states,
    String? token,
  }) {
    return RegisterState(
      loadStatus: loadStatus ?? this.loadStatus,
      token: token ?? this.token,
      //  states: states ?? this.states
    );
  }
}

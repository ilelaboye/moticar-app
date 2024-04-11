// ignore_for_file: deprecated_member_use

import 'dart:convert';

// import 'package:dio/dio.dart';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/localdatabase.dart';
import '../network/dio_utils.dart';
import '../providers/app_providers.dart';
import '../services/hivekeys.dart';
import '../utils/enums.dart';
import 'expensesmodel.dart';
import 'newcars_model.dart';

class ProfileViewModel extends StateNotifier<ProfileState> {
  ProfileViewModel(this._reader)
      : super(ProfileState(
          // accountz: Account.fromJson({}),
          getProfile: GetProfileModel.fromJson({}),
          hasEnabledBiometricLogin:
              HiveStorage.get(HiveKeys.hasEnabledBiometricLogin) ?? false,
          hasEnabledBiometricTrasactions:
              HiveStorage.get(HiveKeys.hasEnabledBiometricTransacitons) ??
                  false,
          stayLoggedIn: HiveStorage.get(HiveKeys.stayLoggedIn) ?? false,
          // userProfile: UserProfile.fromJson({}),
          // user: UserProfile.fromJson({}),
          // dataBalance: DataBalance.fromJson({}),
        ));

  final Ref _reader;

  Future<ApiResponse> changePassword(
      {required Map<String, dynamic> formData}) async {
    try {
      state = state.copyWith(
        loading: Loader.loading,
      );
      final response = await _reader.read(serviceProvider).postWithToken(
            formData: formData,
            path: 'change-password',
          );
      if (response.statusCode == 200) {
        state = state.copyWith(loading: Loader.loaded);
        return ApiResponse(
          successMessage:
              response.data['message'] ?? 'Password reset successful',
        );
      } else {
        state = state.copyWith(loading: Loader.error);
        return ApiResponse(
          errorMessage: response.data['message'] ?? "Failed",
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);
      return ApiResponse(
        error: e.response!.data['message'] ??
            e.response!.data['detail'] ??
            "Error",
      );
    } catch (e) {
      state = state.copyWith(loading: Loader.error);
      rethrow;
    }
  }

  //  final List<dynamic> responseData = response.data;

  //       // Map response data to GetExpenses objects
  //       final List<GetExpenses> newexpense =
  //           responseData.map((json) => GetExpenses.fromJson(json)).toList();

  //       // Update state with new expenses
  //       state = state.copyWith(loading: Loader.loaded, getexpenses: newexpense);

  // /expenses
  Future<ApiResponse> getExpenses() async {
    try {
      state = state.copyWith(
        loading: Loader.loading,
      );
      final response = await _reader.read(newService).getWithToken(
            // formData: formData,
            path: 'get-expenses',
          );
      if (response.statusCode == 200) {
        final responseData = response.data['data']; // Access the "data" key
        print(responseData);
        // Check if responseData is empty
        if (responseData.isEmpty) {
          // Update state with empty list
          state = state.copyWith(loading: Loader.loaded, getexpenses: []);
          return ApiResponse(
            successMessage: 'No expenses available',
          );
        }
        // Map response data to GetExpenses objects
        final List<GetExpenses> newExpense = (responseData as List<dynamic>)
            .map((json) => GetExpenses.fromJson(json))
            .toList();

        // Update state with new expenses
        state = state.copyWith(loading: Loader.loaded, getexpenses: newExpense);
        return ApiResponse(
          successMessage: 'Success',
        );
      } else {
        state = state.copyWith(loading: Loader.error);
        return ApiResponse(
          errorMessage: response.data['message'] ?? "Error",
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);
      return ApiResponse(
        error: e.response!.data['message'] ??
            e.response!.data['detail'] ??
            "Error",
      );
    } catch (e) {
      state = state.copyWith(loading: Loader.error);
      rethrow;
    }
  }

  //technicians
  Future<ApiResponse> getTechnicians() async {
    try {
      state = state.copyWith(
        loading: Loader.loading,
      );
      final response = await _reader.read(newService).getWithToken(
            // formData: formData,
            path: 'get-technicians',
          );
      if (response.statusCode == 200) {
        final responseData = response.data['data']; // Access the "data" key
        print(responseData);
        // Check if responseData is empty
        if (responseData.isEmpty) {
          // Update state with empty list
          state = state.copyWith(loading: Loader.loaded, getexpenses: []);
          return ApiResponse(
            successMessage: 'No Technicians available',
          );
        }
        // Map response data to GetExpenses objects
        final List<GetTechies> newTechies = (responseData as List<dynamic>)
            .map((json) => GetTechies.fromJson(json))
            .toList();

        // Update state with new expenses
        state = state.copyWith(loading: Loader.loaded, techies: newTechies);
        return ApiResponse(
          successMessage: 'Success',
        );
      } else {
        state = state.copyWith(loading: Loader.error);
        return ApiResponse(
          errorMessage: response.data['message'] ?? "Error",
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);
      return ApiResponse(
        error: e.response!.data['message'] ??
            e.response!.data['detail'] ??
            "Error",
      );
    } catch (e) {
      state = state.copyWith(loading: Loader.error);
      rethrow;
    }
  }

  //getCars
  Future<ApiResponse> getMyCars() async {
    try {
      state = state.copyWith(
        loading: Loader.loading,
      );
      final response = await _reader.read(newService).getWithToken(
            // formData: formData,
            path: 'get-my-cars',
          );
      if (response.statusCode == 200) {
        final responseData = response.data['data']; // Access the "data" key
        print(responseData);
        // Check if responseData is empty
        if (responseData.isEmpty) {
          // Update state with empty list
          state = state.copyWith(loading: Loader.loaded, getexpenses: []);
          return ApiResponse(
            successMessage: 'No Cars available',
          );
        }
        // Map response data to GetExpenses objects
        final List<GetCarz> newCarz = (responseData as List<dynamic>)
            .map((json) => GetCarz.fromJson(json))
            .toList();

        // Update state with new expenses
        state = state.copyWith(loading: Loader.loaded, getallCarz: newCarz);
        return ApiResponse(
          successMessage: 'Success',
        );
      } else {
        state = state.copyWith(loading: Loader.error);
        return ApiResponse(
          errorMessage: response.data['message'] ?? "Error",
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);
      return ApiResponse(
        error: e.response!.data['message'] ??
            e.response!.data['detail'] ??
            "Error",
      );
    } catch (e) {
      state = state.copyWith(loading: Loader.error);
      rethrow;
    }
  }

  //getAvailablecarz
  Future<ApiResponse> getCars() async {
    try {
      state = state.copyWith(
        loading: Loader.loading,
      );
      final response = await _reader.read(newService).getWithToken(
            // formData: formData,
            path: 'get-cars',
          );
      if (response.statusCode == 200) {
        final responseData = response.data['data']; // Access the "data" key
        print(responseData);
        // Check if responseData is empty
        if (responseData.isEmpty) {
          // Update state with empty list
          state = state.copyWith(loading: Loader.loaded, getexpenses: []);
          return ApiResponse(
            successMessage: 'No Cars available',
          );
        }
        // Map response data to GetExpenses objects
        final List<NewCarzModel> getCars = (responseData as List<dynamic>)
            .map((json) => NewCarzModel.fromJson(json))
            .toList();

        // Update state with new expenses
        state = state.copyWith(loading: Loader.loaded, getCars: getCars);
        return ApiResponse(
          successMessage: 'Success',
        );
      } else {
        state = state.copyWith(loading: Loader.error);
        return ApiResponse(
          errorMessage: response.data['message'] ?? "Error",
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);
      return ApiResponse(
        error: e.response!.data['message'] ??
            e.response!.data['detail'] ??
            "Error",
      );
    } catch (e) {
      state = state.copyWith(loading: Loader.error);
      rethrow;
    }
  }

//uploadz
  Future<ApiResponse> uploadProfilePic({required XFile files}) async {
    try {
      state = state.copyWith(
        loading: Loader.loading,
      );
      final response = await _reader.read(serviceProvider).postMultipart(
            path: "api/changeimage/",
            formData: {},
            pathName: 'image',
            files: files,
          );
      var body = json.decode(response.body);
      if (response.statusCode == 200) {
        state = state.copyWith(
          loading: Loader.loaded,
        );
        return ApiResponse(
          successMessage: "Image Uploaded Successfully",
        );
      } else {
        state = state.copyWith(
          loading: Loader.error,
        );
        return ApiResponse(
          errorMessage: body["message"],
        );
      }
    } catch (e) {
      state = state.copyWith(
        loading: Loader.error,
      );
      return ApiResponse(
        errorMessage: "unable to update image please check the image selected ",
      );
    }
  }

  void enableBiometricLogin(bool value) async {
    state = state.copyWith(
        hasEnabledBiometricLogin: !state.hasEnabledBiometricLogin);
    await HiveStorage.put(HiveKeys.hasEnabledBiometricLogin, value);
  }

  Future<ApiResponse> getMyProfile() async {
    try {
      // state = state.copyWith(
      //   loading: Loader.loading,
      // );
      final response = await _reader.read(newService).getWithToken(
            // formData: formData,
            path: 'get-profile',
          );
      if (response.statusCode == 200) {
        final responseData = response.data['data']; // Access the "data" key
        print(responseData);
        // Check if responseData is empty
        if (responseData.isEmpty) {
          // Update state with empty list
          state = state.copyWith(loading: Loader.loaded, getexpenses: []);
          return ApiResponse(
            successMessage: 'No Profile available',
          );
        }
        // Map response data to GetExpenses objects
        var userProfile = GetProfileModel.fromJson(response.data['data']);

        // Update state with new expenses
        state = state.copyWith(loading: Loader.loaded, getProfile: userProfile);
        return ApiResponse(
          successMessage: 'Success',
        );
      } else {
        state = state.copyWith(loading: Loader.error);
        return ApiResponse(
          errorMessage: response.data['message'] ?? "Error",
        );
      }
    } on DioError catch (e) {
      state = state.copyWith(loading: Loader.error);
      return ApiResponse(
        error: e.response!.data['message'] ??
            e.response!.data['detail'] ??
            "Error",
      );
    } catch (e) {
      // state = state.copyWith(loading: Loader.error);
      rethrow;
    }
  }

  // Future<ApiResponse> resetPin({
  //   required String otp,
  //   required String newPin,
  //   required String confirmPin,
  // }) async {
  //   try {
  //     state = state.copyWith(
  //       loading: Loader.loading,
  //     );
  //     final response = await _reader.read(networkProvider).postWithToken(
  //         path: "account/reset-pin/",
  //         formData: {
  //           "otp": otp,
  //           "new_pin": newPin,
  //           "confirm_new_pin": confirmPin
  //         });
  //     if (response.statusCode == 200) {
  //       state = state.copyWith(
  //         loading: Loader.loaded,
  //       );
  //       await HiveStorage.put(HiveKeys.transactionPin, newPin);
  //       return ApiResponse(
  //         successMessage: "Pin reset successfully",
  //       );
  //     } else {
  //       state = state.copyWith(
  //         loading: Loader.error,
  //       );
  //       return ApiResponse(
  //         errorMessage: response.data["detail"],
  //       );
  //     }
  //   } on DioError catch (e) {
  //     state = state.copyWith(
  //       loading: Loader.error,
  //     );
  //     return ApiResponse(
  //       error: e,
  //     );
  //   } catch (e) {
  //     state = state.copyWith(
  //       loading: Loader.error,
  //     );
  //     rethrow;
  //   }
  // }

  ///Takes old and new passwords and sends via api for password change.
  ///returns custom ApiResponse Object

  // Future<ApiResponse> changePassword({
  //   required Map<String, Map<String, String>> formData,
  // }) async {
  //   try {
  //     state = state.copyWith(
  //       loading: Loader.loading,
  //     );
  //     final response = await _reader.read(serviceProvider).patch(
  //           formData: formData,
  //           path: 'api/changepassword/',
  //         );
  //     if (response.statusCode == 200) {
  //       state = state.copyWith(loading: Loader.loaded);
  //       return ApiResponse(
  //         successMessage: 'Password reset successful',
  //       );
  //     } else {
  //       state = state.copyWith(loading: Loader.error);
  //       return ApiResponse(
  //         errorMessage: response.data['message'],
  //       );
  //     }
  //   } on DioError catch (e) {
  //     state = state.copyWith(loading: Loader.error);
  //     return ApiResponse(
  //       error: e,
  //     );
  //   } catch (e) {
  //     state = state.copyWith(loading: Loader.error);
  //     rethrow;
  //   }
  // }

  //

  // Future<ApiResponse> changePin({
  //   required String oldPin,
  //   required String newPin,
  //   required String confirmPin,
  // }) async {
  //   try {
  //     state = state.copyWith(
  //       loading: Loader.loading,
  //     );
  //     final response = await _reader
  //         .read(networkProvider)
  //         .postWithToken(path: "account/change-pin/", formData: {
  //       "old_pin": oldPin,
  //       "new_pin": newPin,
  //       "confirm_pin": confirmPin,
  //     });
  //     if (response.statusCode == 200) {
  //       state = state.copyWith(
  //         loading: Loader.loaded,
  //       );
  //       await HiveStorage.put(
  //         HiveKeys.transactionPin,
  //         confirmPin,
  //       );
  //       return ApiResponse(
  //         successMessage: "Pin reset successfully",
  //       );
  //     } else {
  //       state = state.copyWith(
  //         loading: Loader.error,
  //       );
  //       return ApiResponse(
  //         errorMessage: response.data["detail"],
  //       );
  //     }
  //   } on DioError catch (e) {
  //     state = state.copyWith(
  //       loading: Loader.error,
  //     );
  //     return ApiResponse(
  //       error: e,
  //     );
  //   } catch (e) {
  //     state = state.copyWith(
  //       loading: Loader.error,
  //     );
  //     rethrow;
  //   }
  // }

  // Future<ApiResponse> sendResetOtp({
  //   required String email,
  //   required String type,
  // }) async {
  //   try {
  //     state = state.copyWith(
  //       loading: Loader.loading,
  //     );
  //     final response = await _reader
  //         .read(networkProvider)
  //         .postWithToken(path: "account/reset-otp/", formData: {
  //       "phone_number": email,
  //       "reset_type": type,
  //     });
  //     if (response.statusCode == 200) {
  //       state = state.copyWith(
  //         loading: Loader.loaded,
  //         // otpResponse: OtpResponseModel.fromJson(response.data),
  //       );
  //       return ApiResponse(
  //         successMessage: response.data["detail"],
  //       );
  //     } else {
  //       state = state.copyWith(
  //         loading: Loader.error,
  //       );
  //       return ApiResponse(
  //         errorMessage: response.data["detail"],
  //       );
  //     }
  //   } on DioError catch (e) {
  //     state = state.copyWith(
  //       loading: Loader.error,
  //     );
  //     return ApiResponse(
  //       error: e,
  //     );
  //   } catch (e) {
  //     state = state.copyWith(
  //       loading: Loader.error,
  //     );
  //     rethrow;
  //   }
  // }

  // //image upload
  // Future<ApiResponse> uploadProfilePic({required XFile files}) async {
  //   try {
  //     state = state.copyWith(
  //       loading: Loader.loading,
  //     );
  //     final response = await _reader.read(serviceProvider).postMultipart(
  //           path: "api/changeimage/",
  //           formData: {},
  //           pathName: 'image',
  //           files: files,
  //         );
  //     var body = json.decode(response.body);
  //     if (response.statusCode == 200) {
  //       state = state.copyWith(
  //         loading: Loader.loaded,
  //       );
  //       return ApiResponse(
  //         successMessage: "Image Uploaded Successfully",
  //       );
  //     } else {
  //       state = state.copyWith(
  //         loading: Loader.error,
  //       );
  //       return ApiResponse(
  //         errorMessage: body["message"],
  //       );
  //     }
  //   } catch (e) {
  //     state = state.copyWith(
  //       loading: Loader.error,
  //     );
  //     return ApiResponse(
  //       errorMessage: "unable to update image please check the image selected ",
  //     );
  //   }
  // }

  //stayLogged
  void stayLoggedIN(bool value) async {
    state = state.copyWith(stayLoggedIn: !state.stayLoggedIn);
    await HiveStorage.put(HiveKeys.stayLoggedIn, value);
  }

//
  // Future<ApiResponse> enableBiometricTransactions(
  //     Map<String, dynamic> formData) async {
  //   state = state.copyWith(
  //     loading: Loader.loading,
  //   );

  //   try {
  //     String pin = _reader.read(pinProvider).join();
  //     final res = await _reader
  //         .read(verifyPinProvider.notifier)
  //         .veryfiyTransactionPin(pin: pin);
  //     if (res == true) {
  //       await HiveStorage.put(
  //         HiveKeys.hasEnabledBiometricTransacitons,
  //         formData['enabled'],
  //       );

  //       await HiveStorage.put(
  //         HiveKeys.transactionPin,
  //         pin,
  //       );

  //       state = state.copyWith(
  //         hasEnabledBiometricTrasactions: !state.hasEnabledBiometricTrasactions,
  //         loading: Loader.loaded,
  //       );
  //       return ApiResponse(
  //         successMessage:
  //             "Biometric transactions ${formData['enabled'] ? 'enabled' : 'disabled'}",
  //       );
  //     } else if (res == false) {
  //       state = state.copyWith(
  //         loading: Loader.loaded,
  //       );
  //       return ApiResponse(
  //         errorMessage: res,
  //       );
  //     } else {
  //       state = state.copyWith(
  //         loading: Loader.loaded,
  //       );
  //       return ApiResponse(
  //         error: res,
  //       );
  //     }
  //   } on DioError catch (e) {
  //     state = state.copyWith(
  //       loading: Loader.error,
  //     );
  //     return ApiResponse(
  //       error: e,
  //     );
  //   } catch (e) {
  //     state = state.copyWith(
  //       loading: Loader.loaded,
  //     );
  //     return ApiResponse(
  //       errorMessage: "Incorrect PIN",
  //     );
  //   }
  // }
}

class ProfileState {
  final Loader loading;
  final bool stayLoggedIn;
  final bool hasEnabledBiometricLogin;
  final bool hasEnabledBiometricTrasactions;
  final List<GetExpenses> getexpenses;
  final List<GetTechies> techies;
  final List<GetCarz> getallCarz;
  final List<NewCarzModel> getCars;
  final GetProfileModel getProfile;
  // final List<Account> accountz;
  // final List<ProductTypeModel> productList;
  // OtpResponseModel? otpResponse;
  // final BankFlexUser? bankFlexUser;

  ProfileState({
    this.loading = Loader.idle,
    this.getexpenses = const [],
    this.techies = const [],
    this.getallCarz = const [],
    this.getCars =const[],
    required this.getProfile,
    required this.stayLoggedIn,
    required this.hasEnabledBiometricLogin,
    required this.hasEnabledBiometricTrasactions,
    // required this.user,
    // this.otpResponse,
    // this.bankFlexUser,
  });

  ProfileState copyWith({
    Loader? loading,
    List<GetExpenses>? getexpenses,
    GetProfileModel? getProfile,
    List<GetTechies>? techies,
    List<GetCarz>? getallCarz,
    List<NewCarzModel>? getCars,
    // UserProfile? userProfile,
    // DataBalance? dataBalance,
    // AccountManager? accountManager,
    bool? hasEnabledBiometricLogin,
    bool? hasEnabledBiometricTrasactions,
    bool? stayLoggedIn,
    // UserProfile? user,
    // OtpResponseModel? otpResponse,
  }) {
    return ProfileState(
      getexpenses: getexpenses ?? this.getexpenses,
      techies: techies ?? this.techies,
      getallCarz: getallCarz ?? this.getallCarz,
      loading: loading ?? this.loading,
      stayLoggedIn: stayLoggedIn ?? this.stayLoggedIn,
      hasEnabledBiometricLogin:
          hasEnabledBiometricLogin ?? this.hasEnabledBiometricLogin,
      hasEnabledBiometricTrasactions:
          hasEnabledBiometricTrasactions ?? this.hasEnabledBiometricTrasactions,
      getProfile: getProfile ?? this.getProfile,
      getCars: getCars ?? this.getCars,
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'dart:convert';

// import 'package:dio/dio.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../services/localdatabase.dart';
import '../network/dio_utils.dart';
import '../services/hivekeys.dart';
import '../utils/enums.dart';

class ProfileViewModel extends StateNotifier<ProfileState> {
  ProfileViewModel(this._reader)
      : super(ProfileState(
          // accountz: Account.fromJson({}),
          // getProfile: GetProfileModel.fromJson({}),
          hasEnabledBiometricLogin:
              HiveStorage.get(HiveKeys.hasEnabledBiometricLogin) ?? false,
          hasEnabledBiometricTrasactions:
              HiveStorage.get(HiveKeys.hasEnabledBiometricTransacitons) ??
                  false,
                stayLoggedIn : HiveStorage.get(HiveKeys.stayLoggedIn) ?? false,
          // userProfile: UserProfile.fromJson({}),
          // user: UserProfile.fromJson({}),
          // dataBalance: DataBalance.fromJson({}),
        ));

  final Ref _reader;

  // /auth/me
  // Future<ApiResponse> getMeProfile() async {
  //   try {
  //     final response = await _reader.read(serviceProvider).postWithToken(
  //       formData: {},
  //       path: "/api/web/auth/me",
  //     );
  //     var body = response.data;
  //     if (response.statusCode == 200) {
  //       final userProfile = GetProfileModel.fromJson(body);

  //       final acctDetails =
  //           body['accounts'] as List<dynamic>; // Explicit casting
  //       List<Account> bettings =
  //           acctDetails.map((json) => Account.fromJson(json)).toList();

  //       state = state.copyWith(
  //         loading: Loader.loaded,
  //         getProfile: userProfile,
  //         accountz: bettings,
  //       );
  //       return ApiResponse(
  //         successMessage: body["status"] ?? 'Success',
  //       );
  //     } else {
  //       state = state.copyWith(
  //         loading: Loader.error,
  //       );
  //       return ApiResponse(
  //         errorMessage: body['status'] ?? 'Cannot find profile',
  //       );
  //     }
  //   } on DioError catch (e) {
  //     state = state.copyWith(
  //       loading: Loader.error,
  //     );
  //     return ApiResponse(
  //       errorMessage: e.response?.data['status'] ?? "Error",
  //     );
  //   } catch (e) {
  //     state = state.copyWith(
  //       loading: Loader.error,
  //     );
  //     rethrow;
  //   }
  // }

   

  // Future<ApiResponse> updateProfile(
  //     {required Map<String, dynamic> formData}) async {
  //   try {
  //     final response = await _reader
  //         .read(serviceProvider)
  //         .put(path: 'api/profile/', formData: formData);
  //     if (response.statusCode == 200) {
  //       await HiveStorage.put(HiveKeys.user, response.data);
  //       // var userProfile = UserProfile.fromJson(response.data['data']['user']);

  //       state = state.copyWith(
  //         loading: Loader.loaded,
  //         // userProfile: userProfile,
  //       );
  //       return ApiResponse(
  //         successMessage: "Profile updated successfully",
  //       );
  //     } else {
  //       state = state.copyWith(
  //         loading: Loader.error,
  //       );
  //       return ApiResponse(
  //         errorMessage: response.data["message"],
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
  //     return ApiResponse(
  //         errorMessage: 'An error occurred while processing request');
  //     //rethrow;
  //   }
  // }



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

  void enableBiometricLogin(bool value) async {
    state = state.copyWith(
        hasEnabledBiometricLogin: !state.hasEnabledBiometricLogin);
    await HiveStorage.put(HiveKeys.hasEnabledBiometricLogin, value);
  }

  //stayLogged
  void stayLoggedIN(bool value) async {
    state = state.copyWith(
        stayLoggedIn: !state.stayLoggedIn);
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
  // final GetProfileModel getProfile;
  // final List<Account> accountz;
  // final List<ProductTypeModel> productList;
  // OtpResponseModel? otpResponse;
  // final BankFlexUser? bankFlexUser;

  ProfileState({
    this.loading = Loader.idle,
    // required this.userProfile,
    required this.stayLoggedIn,
    required this.hasEnabledBiometricLogin,
    required this.hasEnabledBiometricTrasactions,
    // required this.user,
    // this.otpResponse,
    // this.bankFlexUser,
  });

  ProfileState copyWith({
    Loader? loading,
    // final GetProfileModel? getProfile,
    // final List<Account>? accountz,
    // final List<ProductTypeModel>? productList,
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
      // productList: productList ?? this.productList,
      // accountz: accountz ?? this.accountz,
      // getProfile: getProfile ?? this.getProfile,
      loading: loading ?? this.loading,
      stayLoggedIn: stayLoggedIn ?? this.stayLoggedIn,
      hasEnabledBiometricLogin:
          hasEnabledBiometricLogin ?? this.hasEnabledBiometricLogin,
      hasEnabledBiometricTrasactions:
          hasEnabledBiometricTrasactions ?? this.hasEnabledBiometricTrasactions,
      // user: user ?? this.user,
      // otpResponse: otpResponse ?? this.otpResponse,
    );
  }
}

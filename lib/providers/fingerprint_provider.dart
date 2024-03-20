// // ignore_for_file: deprecated_member_use

// import 'package:dio/dio.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import '../services/local_authentication/local_auth.dart';
// import '../utils/enums.dart';
// import 'app_providers.dart';

// class FingerPrint extends StateNotifier<bool> {
//   FingerPrint() : super(false);

//   void getFingerPrint() async {
//     final res = await LocalAuthApi.getBiometrics();
//     if (res.isNotEmpty) {
//       state = true;
//     } else {
//       state = false;
//     }
//   }
// }

// class VerifyPinProvider extends StateNotifier<VerifyPinState> {
//   VerifyPinProvider(this._reader) : super(VerifyPinState());

//   final Ref _reader;

//   Future veryfiyTransactionPin({required String pin}) async {
//     state = state.copyWith(loading: Loader.loading);
//     try {
//       final res = await _reader.read(serviceProvider).postWithToken(formData: {
//         'Pin': pin.toString(),
//       }, path: "account/confirm-transaction-pin/");

//       if (res.statusCode == 200) {
//         state = state.copyWith(loading: Loader.loaded);
//         return true;
//       } else {
//         state = state.copyWith(loading: Loader.error);
//         return res.data["detail"];
//       }
//     } on DioError catch (e) {
//       state = state.copyWith(loading: Loader.error);
//       if (e.response != null &&
//           e.response!.statusCode == 400 &&
//           e.response!.data["detail"] == "Transaction Pin Does Not Match") {
//         return false;
//       }
//       return e;
//     }
//   }
// }

// class VerifyPinState {
//   final Loader loading;

//   VerifyPinState({this.loading = Loader.idle});

//   VerifyPinState copyWith({Loader? loading}) {
//     return VerifyPinState(loading: loading ?? this.loading);
//   }
// }

// ignore_for_file: unused_import

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';
  
import '../auth/login/login_viewmodel.dart';
import '../auth/signup/register_viewmodel.dart';
import '../models/profile_viewmodel.dart';
import '../network/moticar_backend.dart';
import '../network/new_back.dart';
import '../services/imagepicker.dart';
import 'fingerprint_provider.dart';

//This file stores all providers that will be used throughout the app.
//This includes all PROVIDERS and STATENOTIFIERPROVIDERS
//PROVIDERS will be used to register services for proper DEPENDENCY INJECTION
//STATENOTIFIERPROVIDERS will be used to register viewmodels

//SERVICE PROVIDERS
final serviceProvider = Provider((_) => AgencyBackEnd(Dio()));
final newService = Provider((_) => NewAgencyBackEnd(Dio()));

///
// final imagePickerService = Provider((ref) => AgencyImagePicker(ImagePicker()));

///
// This PinProvider saves the PIN code typed in by the user once a user
//wants to initiate a transaction and this is disposed immediately the user
///Leaves the screen
///To use it simply call _reader(pinProvider) to access the value.
final pinProvider = StateProvider.autoDispose<List>((ref) => []);

final imagePickerService = Provider((ref) => MoticarImagePicker(ImagePicker()));

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginState>(
        (ref) => LoginViewModel(ref));

final registerViewmodelProvider =
    StateNotifierProvider<RegisterViewmodel, RegisterState>(
        (ref) => RegisterViewmodel(ref));


/////
// final fingerPrintProvider =
//     StateNotifierProvider<FingerPrint, bool>((ref) => FingerPrint());
// final verifyPinProvider =
//     StateNotifierProvider<VerifyPinProvider, VerifyPinState>(
//         (ref) => VerifyPinProvider(ref));

///
// final formatterProvider = Provider((ref) => CitFormatter());

///
// final showWallet =
// StateNotifierProvider<WalletProvider, bool>((ref) => WalletProvider());

///
///STATENOTIFIERPROVIDERS
///
///
// final registerViewmodelProvider =
//     StateNotifierProvider<RegisterViewmodel, RegisterState>(
//         (ref) => RegisterViewmodel(ref));


// final openAccountModelProvider =
//     StateNotifierProvider<OpenAccountViewModel, OpenAccountState>(
//         (ref) => OpenAccountViewModel(ref.read));

final profileProvider = StateNotifierProvider<ProfileViewModel, ProfileState>(
    (ref) => ProfileViewModel(ref));

// final addMoneyViewModelProvider =
//     StateNotifierProvider<AddMoneyViewModel, AddMoneyState>(
//         (ref) => AddMoneyViewModel());

// final airtimeBillProvider =
//     StateNotifierProvider<AirtimeViewModel, AirtimeState>(
//         (ref) => AirtimeViewModel(ref));
 

// final transfersViewmodelprovider =
//     StateNotifierProvider.autoDispose<TransfersViewModel, TransfersState>(
//         ((ref) => TransfersViewModel(ref)));

final isDarkModeEnabledProvider = StateProvider((ref) => false);


// final forgotPasswordViewModelProvider =
//     StateNotifierProvider<ForgotPasswordViewModel, ForgotPasswordState>(
//         ((ref) => ForgotPasswordViewModel(ref)));
 

// final supportScreenViewModelProvider =
//     StateNotifierProvider<SupportScreenViewModel, SupportScreenState>(
//         (ref) => SupportScreenViewModel(ref));

// /////
// ///



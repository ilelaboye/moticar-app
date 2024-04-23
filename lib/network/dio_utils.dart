// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../widgets/flushbar.dart';

void handleError({
  required e,
  required BuildContext context,
}) {
  if (e.runtimeType == String) {
    if ((e as String).contains('<!DOCTYPE html>') || e.contains('<html')) {
      Alert.showNotificationError(
        message: 'Problem connecting to server. Please try again',
        notificationType: 1,
        context: context,
      );
    } else {
      Alert.showNotificationError(
        message: e,
        notificationType: 1,
        context: context,
      );
    }
  } else {
    switch (e.type) {
      case DioErrorType.cancel:
        Alert.showNotificationError(
          message: "Request to server was cancelled",
          notificationType: 1,
          context: context,
        );
        break;
      case DioErrorType.connectTimeout:
        Alert.showNotificationError(
          message: "Your request timed out, please try again",
          notificationType: 1,
          context: context,
        );

        break;
      case DioErrorType.receiveTimeout:
        Alert.showNotificationError(
          message: "Your request timed out, please try again",
          notificationType: 1,
          context: context,
        );
        break;
      case DioErrorType.response:
        Alert.showNotificationError(
          message: e.response!.data.runtimeType == String
              ? "${e.response != null && e.response!.data.isNotEmpty ? e.response!.data : "Something went wrong, please try again"}"
              : e.response!.data["detail"],
          notificationType: 1,
          context: context,
        );

        break;
      case DioErrorType.sendTimeout:
        Alert.showNotificationError(
          message: e.message,
          notificationType: 1,
          context: context,
        );
        break;
      case DioErrorType.other:
        Alert.showNotificationError(
          message:
              'Please check your internet connection',
          notificationType: 1,
          context: context,
        );

        break;
    }
  }
}

void showSuccess({
  required String text,
  required BuildContext context,
}) {
  Alert.showNotification(
    message: text,
    context: context,
  );
}

void showError({
  required String text,
  required BuildContext context,
}) {
  Alert.showNotificationError(
    message: text,
    context: context,
    notificationType: 1,
  );
}

class ApiResponse {
  final String successMessage;
  final String errorMessage;
  final DioError? error;
  final String responseMessage;

  ApiResponse({
    this.errorMessage = 'Error connecting, Please try again',
    this.successMessage = '',
    this.error,
    this.responseMessage = '',
  });
}

void handleBankOneError({
  required e,
  required BuildContext context,
  Duration? duration,
}) {
  if (e.runtimeType == String) {
    Alert.showNotification(
      message: e,
      notificationType: 1,
      context: context,
      duration: duration,
    );
  } else {
    switch (e.type) {
      case DioErrorType.cancel:
        Alert.showNotification(
          message: "Request to server was cancelled",
          notificationType: 1,
          context: context,
        );
        break;
      case DioErrorType.connectTimeout:
        Alert.showNotification(
          message: "Your request timed out, please try again",
          notificationType: 1,
          context: context,
        );

        break;
      case DioErrorType.receiveTimeout:
        Alert.showNotification(
          message: "Your request timed out, please try again",
          notificationType: 1,
          context: context,
        );
        break;
      case DioErrorType.response:
        Alert.showNotification(
          message: e.response!.data.runtimeType != List
              ? "Something went wrong, please try again"
              : e.response!.data.first["error-Message"],
          notificationType: 1,
          context: context,
        );

        break;
      case DioErrorType.sendTimeout:
        Alert.showNotification(
          message: e.message,
          notificationType: 1,
          context: context,
        );
        break;
      case DioErrorType.other:
        Alert.showNotification(
          message: 'Please check your internet connection',
          notificationType: 1,
          context: context,
        );

        break;
    }
  }
}

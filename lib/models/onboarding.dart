import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class IOnboarding {
  final Map<String, dynamic> text;
  final List<dynamic> images;

  const IOnboarding({required this.text, required this.images});

  factory IOnboarding.fromMap(Map<String, dynamic> data) => IOnboarding(
        text: data['text'] as Map<String, dynamic>,
        images: data['images'] as List<dynamic>,
      );

  // Parses the string and returns the resulting Json object as [IOnboarding].
  factory IOnboarding.fromJson(String data) {
    return IOnboarding.fromMap(json.decode(data) as Map<String, dynamic>);
  }
}

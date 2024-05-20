import 'package:flutter/material.dart';

enum LanguageType { ENGLISH }

const String ENGLISH = 'en';
const String ASSETS_PATH_LOCALISATION = "assets/lang";
const Locale ENGLISH_LOCAL = Locale("en");

const List<Locale> supportedLocales = [
  ENGLISH_LOCAL,
];

extension LanguageTypeExtension on LanguageType {
  String getValue() {
        return ENGLISH;
  }
}

extension LanguageTypeLocalExtension on LanguageType {
  Locale getLocal() {
   return ENGLISH_LOCAL;
  }
}


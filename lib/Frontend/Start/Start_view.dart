// ignore_for_file: file_names

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings().defaultError),
      ),
      body: Center(
  child: ThemeSwitcher.withTheme(
    builder: (context, switcher, theme) {
      return MaterialApp(
        
        theme: ThemeData.light(),
    );
    },
  ),
),
    );
  }
}

class AppStrings {
  String defaultError = 'defaultError'.tr();
  String noInternetError = 'noInternetError'.tr();
}

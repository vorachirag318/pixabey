import 'package:flutter/material.dart';
import 'package:pixabay/core/constant/app_colors.dart';

class AppTheme {
  static final ThemeData defTheme = ThemeData(
    scaffoldBackgroundColor: AppColor.kScaffoldColor,
    textTheme: const TextTheme(
      bodyText2: TextStyle(color: Colors.white, fontSize: 18),
    ),
  );
}

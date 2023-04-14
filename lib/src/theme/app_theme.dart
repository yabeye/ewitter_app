import 'package:flutter/material.dart';
import 'package:ewitter_app/src/theme/pallet.dart';

class AppTheme {
  static ThemeData theme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: KPallet.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: KPallet.backgroundColor,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: KPallet.primaryColor,
    ),
  );
}

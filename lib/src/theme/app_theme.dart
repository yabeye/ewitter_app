import 'package:flutter/material.dart';
import 'package:ewitter_app/src/theme/pallet.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

// Constants
// FontSizes
const int heading1Size = 32;
const int heading2Size = 22;
const int heading3Size = 18;

const int body1Size = 16;
const int body2Size = 14;
const int body3Size = 12;

class AppTheme {
  static ThemeData theme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: KPallet.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: KPallet.backgroundColor,
      elevation: 0,
    ),
    primaryColor: KPallet.primaryColor,
    colorScheme: const ColorScheme.dark()
        .copyWith(
          primary: KPallet.primaryColor,
          secondary: KPallet.secondaryColor,
        )
        .copyWith(secondary: KPallet.primaryColor),
    textTheme: GoogleFonts.montserratTextTheme(
      const TextTheme(
        displaySmall: TextStyle(color: KPallet.primaryColor),
        headlineMedium: TextStyle(color: KPallet.primaryColor),
        headlineSmall: TextStyle(color: KPallet.primaryColor),
        titleLarge: TextStyle(color: KPallet.primaryColor),
        bodyLarge: TextStyle(color: KPallet.whiteColor),
        bodyMedium: TextStyle(color: KPallet.whiteColor),
        titleMedium: TextStyle(color: KPallet.whiteColor),
        titleSmall: TextStyle(color: KPallet.whiteColor),
        bodySmall: TextStyle(color: KPallet.whiteColor),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: KPallet.primaryColor,
    ),
  );
}

InputDecoration inputDecoration(BuildContext context,
    {Widget? prefixIcon, String? labelText, double? borderRadius}) {
  return InputDecoration(
    contentPadding:
        const EdgeInsets.only(left: 12, bottom: 10, top: 10, right: 10),
    labelText: labelText,
    labelStyle: secondaryTextStyle(),
    alignLabelWithHint: true,
    prefixIcon: prefixIcon,
    errorMaxLines: 2,
    errorStyle: primaryTextStyle(color: Colors.red, size: 12),
    filled: true,
    fillColor: KPallet.backgroundColor,
  );
}

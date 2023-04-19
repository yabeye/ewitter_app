import 'package:flutter/material.dart';
import 'package:ewitter_app/src/common/theme/pallet.dart';
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
    scaffoldBackgroundColor: KPalette.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: KPalette.backgroundColor,
      elevation: 0,
    ),
    primaryColor: KPalette.primaryColor,
    colorScheme: const ColorScheme.dark()
        .copyWith(
          primary: KPalette.primaryColor,
          secondary: KPalette.secondaryColor,
        )
        .copyWith(secondary: KPalette.primaryColor),
    textTheme: GoogleFonts.montserratTextTheme(
      const TextTheme(
        displaySmall: TextStyle(color: KPalette.primaryColor),
        headlineMedium: TextStyle(color: KPalette.primaryColor),
        headlineSmall: TextStyle(color: KPalette.primaryColor),
        titleLarge: TextStyle(color: KPalette.primaryColor),
        bodyLarge: TextStyle(color: KPalette.whiteColor),
        bodyMedium: TextStyle(color: KPalette.whiteColor),
        titleMedium: TextStyle(color: KPalette.whiteColor),
        titleSmall: TextStyle(color: KPalette.whiteColor),
        bodySmall: TextStyle(color: KPalette.whiteColor),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: KPalette.primaryColor,
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
    fillColor: KPalette.backgroundColor,
  );
}

import 'package:flutter/material.dart';
import 'package:focus_client/focus_client.dart';
import 'package:focus_flutter/app/layout.dart';
import 'package:google_fonts/google_fonts.dart';

/// Focus theme.
ThemeData generateTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: Colors.black,
    surface: Colors.black,
    primary: Colors.white,
    secondary: AppColors.blackSilver,
  );
  return ThemeData(
    useMaterial3: true,
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: GoogleFonts.robotoTextTheme().apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
      decorationColor: AppColors.white,
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.white,
      textColor: AppColors.white,
    ),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      colorScheme: colorScheme,
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        animationDuration: Duration.zero,
        elevation: const WidgetStatePropertyAll(0.0),
        splashFactory: NoSplash.splashFactory,
        shadowColor: const WidgetStatePropertyAll(AppColors.transparent),
        side: const WidgetStatePropertyAll(BorderSide(color: AppColors.white, width: 2.0)),
        shape: const WidgetStatePropertyAll(RoundedRectangleBorder()),
        backgroundColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.white;
          }
          return AppColors.black;
        }),
        foregroundColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.black;
          }
          return AppColors.white;
        }),
      ),
    ),
    colorScheme: colorScheme,
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: allPadding8,
      border: outlineInputBorder,
      focusedBorder: focusedOutlineInputBorder,
      enabledBorder: outlineInputBorder,
      hintStyle: TextStyle(
        color: Colors.white38,
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionHandleColor: Colors.white,
      selectionColor: Colors.white12,
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
      // textStyle: TextStyle(color: Colors.white),
      inputDecorationTheme: InputDecorationTheme(
        iconColor: AppColors.white,
        suffixIconColor: AppColors.white,
      ),
      menuStyle: MenuStyle(
        elevation: WidgetStatePropertyAll(0.0),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            side: BorderSide(color: AppColors.white, width: 2.0),
          ),
        ),
        maximumSize: WidgetStatePropertyAll(Size.fromWidth(200.0)),
        backgroundColor: WidgetStatePropertyAll(AppColors.black),
        alignment: Alignment.bottomLeft,
      ),
    ),
    splashColor: Colors.transparent,
  );
}

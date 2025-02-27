import 'package:invoshop/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DarkTheme {
  ThemeData darkTheme(context) => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: DarkThemeColor.backgroundColor,
        colorScheme: const ColorScheme(
          primary: DarkThemeColor.primaryColor,
          primaryContainer: DarkThemeColor.primaryVariantColor,
          secondary: DarkThemeColor.secondaryColor,
          secondaryContainer: DarkThemeColor.secondaryVariantColor,
          surface: DarkThemeColor.surfaceColor,
          error: DarkThemeColor.errorColor,
          onPrimary: DarkThemeColor.onPrimaryColor,
          onSecondary: DarkThemeColor.onSecondaryColor,
          onSurface: DarkThemeColor.onSurfaceColor,
          onError: DarkThemeColor.onErrorColor,
          brightness: Brightness.dark,
        ),
      );
}

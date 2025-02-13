import 'package:ai_store/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightTheme {
  ThemeData lightTheme(context) => ThemeData(
      colorSchemeSeed: AppColors.groceryPrimary,
      textTheme: GoogleFonts.poppinsTextTheme(),
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.groceryWhite,
      inputDecorationTheme: _buildInputDecorationTheme());

  InputDecorationTheme _buildInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.groceryWhite,
      border: _buildInputBorderStyle(),
      enabledBorder: _buildInputBorderStyle(),
      focusedBorder: _buildInputBorderStyle(),
      prefixIconColor: AppColors.grocerySubTitle,
      errorBorder: _buildErrorInputBorderStyle(),
      focusedErrorBorder: _buildErrorInputBorderStyle(),
      hintStyle: const TextStyle(
        color: AppColors.grocerySubTitle,
        fontSize: 12,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
    );
  }

  OutlineInputBorder _buildErrorInputBorderStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(
        color: AppColors.errorColor,
      ),
    );
  }

  OutlineInputBorder _buildInputBorderStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(
        color: AppColors.groceryBorder,
      ),
    );
  }
}

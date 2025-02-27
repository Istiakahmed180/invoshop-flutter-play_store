import 'package:invoshop/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final bool isPasswordVisible;
  final IconData? prefixIcon;
  final Function()? togglePasswordVisibility;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const CommonTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.prefixIcon,
    this.togglePasswordVisibility,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextSelectionTheme(
      data: TextSelectionThemeData(
        cursorColor: AppColors.grocerySubTitle.withOpacity(0.5),
        selectionColor: AppColors.grocerySubTitle.withOpacity(0.2),
        selectionHandleColor: AppColors.grocerySubTitle.withOpacity(0.5),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword && !isPasswordVisible,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.groceryWhite,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: const BorderSide(
              color: AppColors.groceryBorder,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: const BorderSide(
              color: AppColors.groceryBorder,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: const BorderSide(
              color: AppColors.groceryBorder,
              width: 1,
            ),
          ),
          hintStyle: const TextStyle(
            color: AppColors.grocerySubTitle,
            fontSize: 14,
          ),
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: AppColors.grocerySubTitle,
                  size: 20,
                )
              : null,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.grocerySubTitle,
                    size: 20,
                  ),
                  onPressed: togglePasswordVisibility,
                )
              : null,
          contentPadding:
              EdgeInsets.symmetric(vertical: 13.h, horizontal: 16.w),
        ),
        style: const TextStyle(
          color: AppColors.grocerySubTitle,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

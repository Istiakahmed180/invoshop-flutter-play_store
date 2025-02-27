import 'package:flutter/material.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final int maxLines;
  final ValueChanged<String?>? onSaved;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.maxLines = 1,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.grocerySubTitle.withOpacity(0.5),
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
      ),
      style: const TextStyle(
        color: AppColors.grocerySubTitle,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      maxLines: maxLines,
      onSaved: onSaved,
    );
  }
}

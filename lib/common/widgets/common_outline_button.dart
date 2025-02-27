import 'package:invoshop/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOutlinedButton extends StatelessWidget {
  final Color borderColor;
  final String buttonText;
  final double verticalPadding;
  final double horizontalPadding;
  final double buttonTextSize;
  final Color buttonTextColor;
  final double buttonBorderRadius;
  final VoidCallback onPressed;

  const CustomOutlinedButton({
    super.key,
    this.borderColor = AppColors.groceryBorder,
    required this.buttonText,
    this.buttonTextSize = 14,
    this.buttonTextColor = AppColors.groceryTitle,
    this.horizontalPadding = 8,
    this.verticalPadding = 0,
    this.buttonBorderRadius = 4,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding.h, horizontal: horizontalPadding.w),
        side: BorderSide(color: borderColor),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonBorderRadius.r)),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(
          color: buttonTextColor,
          fontSize: buttonTextSize,
        ),
      ),
    );
  }
}

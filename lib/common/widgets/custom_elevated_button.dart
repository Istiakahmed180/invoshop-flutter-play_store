import 'package:ai_store/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final String buttonName;
  final void Function()? onPressed;
  final Color buttonColor;
  final double buttonBorderRadius;
  final double buttonTextSize;
  final Color buttonTextColor;
  final double verticalPadding;
  final double horizontalPadding;

  const CustomElevatedButton(
      {super.key,
      required this.buttonName,
      this.onPressed,
      this.buttonColor = AppColors.groceryPrimary,
      this.buttonBorderRadius = 4,
      this.buttonTextSize = 14,
      this.buttonTextColor = AppColors.groceryWhite,
      this.horizontalPadding = 8,
      this.verticalPadding = 0});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
                vertical: verticalPadding.h, horizontal: horizontalPadding.w),
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(buttonBorderRadius.r))),
        onPressed: onPressed,
        child: Text(buttonName,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: buttonTextColor,
              fontSize: buttonTextSize,
            )));
  }
}

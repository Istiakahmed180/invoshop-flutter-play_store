import 'package:ai_store/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLabelText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final bool isRequired;

  const CustomLabelText({
    super.key,
    required this.text,
    this.fontSize = 12,
    this.color = AppColors.onSecondaryColor,
    this.fontWeight = FontWeight.w600,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize.sp,
          color: color,
          fontWeight: fontWeight,
        ),
        children: isRequired
            ? [
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: AppColors.grocerySecondary,
                    fontSize: fontSize.sp,
                    fontWeight: fontWeight,
                  ),
                ),
              ]
            : [],
      ),
    );
  }
}

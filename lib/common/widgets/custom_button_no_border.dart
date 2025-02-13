import 'package:ai_store/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButtonNoBorder extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const CustomButtonNoBorder({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.groceryTitle,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

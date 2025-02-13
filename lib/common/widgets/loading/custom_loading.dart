import 'package:ai_store/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key, this.withOpacity = 0.3});
  final double? withOpacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.onSecondaryColor.withOpacity(withOpacity!),
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.groceryPrimary,
          strokeWidth: 3,
          backgroundColor: AppColors.grocerySecondary,
        ),
      ),
    );
  }
}

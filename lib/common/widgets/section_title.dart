import 'package:ai_store/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.groceryTitle,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

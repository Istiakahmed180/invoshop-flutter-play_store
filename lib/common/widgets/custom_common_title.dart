import 'package:invoshop/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTitleText extends StatelessWidget {
  final String title;
  final double titleFontSize;
  final Color color;

  const CustomTitleText({
    super.key,
    required this.title,
    this.titleFontSize = 14.0,
    this.color = AppColors.groceryTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: titleFontSize,
        fontWeight: FontWeight.bold,
        color: color,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

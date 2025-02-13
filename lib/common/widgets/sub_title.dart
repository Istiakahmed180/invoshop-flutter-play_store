import 'package:ai_store/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubTitle extends StatelessWidget {
  final String title;

  const SubTitle({
    super.key,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 12.sp,
        color: AppColors.grocerySubTitle,
      ),
    );
  }
}

import 'package:invoshop/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomExitConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final String cancelText;
  final String confirmText;

  const CustomExitConfirmationDialog({
    super.key,
    this.title = 'Exit Application?',
    this.content = 'Are you sure you want to exit the application?',
    this.cancelText = 'No',
    this.confirmText = 'Yes',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0.5,
      backgroundColor: AppColors.groceryWhite,
      contentPadding: REdgeInsets.all(16),
      titlePadding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      actionsPadding: EdgeInsets.symmetric(horizontal: 10.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            cancelText,
            style: const TextStyle(color: AppColors.groceryPrimary),
          ),
        ),
        TextButton(
          onPressed: () => SystemNavigator.pop(),
          child: Text(
            confirmText,
            style: const TextStyle(color: AppColors.groceryPrimary),
          ),
        ),
      ],
    );
  }
}

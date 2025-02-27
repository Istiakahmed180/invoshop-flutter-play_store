import 'package:invoshop/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarName;

  const CustomAppBar({super.key, required this.appBarName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.groceryPrimary,
      elevation: 2,
      centerTitle: true,
      title: Align(
        alignment: Alignment.topLeft,
        child: Text(
          appBarName,
          style: const TextStyle(
              color: AppColors.groceryWhite,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
      leading: IconButton(
        color: AppColors.groceryWhite,
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

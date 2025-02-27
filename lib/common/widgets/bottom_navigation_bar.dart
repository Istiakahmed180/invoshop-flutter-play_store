import 'package:invoshop/common/controller/bottom_navigation_controller.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget bottomNav() {
  final BottomNavigationController controller =
      Get.put(BottomNavigationController());

  return Container(
    decoration: const BoxDecoration(
      color: AppColors.groceryBody,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.groceryBorder,
          blurRadius: 10,
          offset: Offset(0, -5),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.selectedIndex.value,
            onTap: controller.onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_rounded),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Shop',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            selectedItemColor: AppColors.groceryPrimary,
            unselectedItemColor: AppColors.grocerySubTitle,
            showUnselectedLabels: true,
          )),
    ),
  );
}

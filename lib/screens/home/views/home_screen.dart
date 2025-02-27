import 'package:invoshop/common/controller/bottom_navigation_controller.dart';
import 'package:invoshop/common/drawer/custom_drawer.dart';
import 'package:invoshop/common/widgets/alert_dialog/custom_exit_confirmation_dialog.dart';
import 'package:invoshop/common/widgets/bottom_navigation_bar.dart';
import 'package:invoshop/screens/category/views/category_screen.dart';
import 'package:invoshop/screens/home/views/components/home_container.dart';
import 'package:invoshop/screens/products/controller/product_controller.dart';
import 'package:invoshop/screens/products/views/products_screen.dart';
import 'package:invoshop/screens/profile/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late BottomNavigationController bottomNavigationController;
  late ProductController productController;

  @override
  void initState() {
    super.initState();
    bottomNavigationController =
        Get.put(BottomNavigationController(), permanent: true);
    productController = Get.put(ProductController(), permanent: true);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool _, __) async {
        _showExitConfirmationDialog(context);
      },
      child: Scaffold(
        drawer: const AppDrawer(),
        body: Obx(() {
          if (bottomNavigationController.selectedIndex.value != 2) {
            productController.resetFilters();
          }
          switch (bottomNavigationController.selectedIndex.value) {
            case 1:
              return const CategoryScreen();
            case 2:
              return const ProductsScreen();
            case 3:
              return const ProfileScreen();
            default:
              return const HomeContainer();
          }
        }),
        bottomNavigationBar: bottomNav(),
      ),
    );
  }

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => const CustomExitConfirmationDialog(),
    ).then((value) => value ?? false);
  }
}

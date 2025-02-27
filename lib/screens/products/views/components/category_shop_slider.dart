import 'package:invoshop/common/controller/categories_controller.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/products/controller/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryShopSlider extends StatelessWidget {
  final ProductsController productsController;
  final int selectedIndex;
  final Function(int) onCategorySelected;

  const CategoryShopSlider({
    super.key,
    required this.selectedIndex,
    required this.onCategorySelected,
    required this.productsController,
  });

  @override
  Widget build(BuildContext context) {
    final CategoriesController categoriesController =
        Get.put(CategoriesController());

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildCategoryItem(
            label: 'All',
            isSelected: selectedIndex == 0,
            onTap: () {
              onCategorySelected(0);
              productsController.getAllProducts();
            },
          ),
          ...categoriesController.categoriesList.asMap().entries.map((entry) {
            final int index = entry.key;
            final category = entry.value;
            return _buildCategoryItem(
              label: category.title!,
              isSelected: selectedIndex == index + 1,
              onTap: () {
                onCategorySelected(index + 1);
                categoriesController.categoryID.value = category.id!;
                productsController.getCategoryIdByProducts(
                  categoryID: categoriesController.categoryID.toString(),
                );
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCategoryItem({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.groceryPrimary : AppColors.groceryWhite,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.groceryPrimary, width: 1),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.groceryPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

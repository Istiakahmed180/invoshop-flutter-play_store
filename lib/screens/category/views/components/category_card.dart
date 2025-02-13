import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/screens/products/controller/product_controller.dart';
import 'package:ai_store/screens/products/views/filtered_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoryCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String productCount;
  final String categoryID;

  const CategoryCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.productCount,
    required this.categoryID,
  });

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () {
        productController.selectedCategory.value = title;
        Get.to(() => FilteredProductsScreen(
              categoryID: categoryID,
              categoryTitle: title,
              requestType: "Category",
            ));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.groceryBodyTwo,
            child: Padding(
              padding: REdgeInsets.all(10),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/gif/loading.gif',
                image: imagePath,
                imageErrorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image,
                  color: AppColors.groceryRatingGray,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.groceryTitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/home/controller/category_id_by_products_controller.dart';
import 'package:invoshop/screens/home/model/products_model.dart';
import 'package:invoshop/screens/products/views/components/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductFilterGrid extends StatelessWidget {
  final CategoryIdByProductsController controller;

  const ProductFilterGrid({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = (screenWidth - 36) / 2;
    const double cardHeight = 250;
    final double aspectRatio = cardWidth / cardHeight;
    return Obx(() {
      return controller.categoryIdByProductsList.isNotEmpty
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: aspectRatio,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.categoryIdByProductsList.length,
              itemBuilder: (context, index) {
                final ProductsData product =
                    controller.categoryIdByProductsList[index];
                return ProductCard(product: product);
              },
            )
          : const Center(
              child: Text(
                'No products available',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.groceryRatingGray,
                ),
              ),
            );
    });
  }
}

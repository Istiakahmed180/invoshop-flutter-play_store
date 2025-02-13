import 'package:ai_store/common/widgets/loading/custom_loading.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/screens/home/model/products_model.dart';
import 'package:ai_store/screens/products/controller/products_controller.dart';
import 'package:ai_store/screens/products/views/components/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductGrid extends StatelessWidget {
  final ProductsController productsController;

  const ProductGrid({
    super.key,
    required this.productsController,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = (screenWidth - 36) / 2;
    const double cardHeight = 250;
    final double aspectRatio = cardWidth / cardHeight;

    return Obx(() {
      if (productsController.isProductsLoading.value) {
        return const CustomLoading(
          withOpacity: 0.0,
        );
      }
      return productsController.filteredProductList.isNotEmpty
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: aspectRatio,
              ),
              itemCount: productsController.filteredProductList.length,
              itemBuilder: (context, index) {
                final ProductsData product =
                    productsController.filteredProductList[index];
                return ProductCard(product: product);
              },
            )
          : Center(
              child: Text(
                'No Product Available',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.grocerySubTitle,
                ),
              ),
            );
    });
  }
}

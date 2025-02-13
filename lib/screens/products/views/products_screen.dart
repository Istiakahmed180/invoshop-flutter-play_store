import 'package:ai_store/common/controller/wish_cart_list_controller.dart';
import 'package:ai_store/common/widgets/loading/custom_loading.dart';
import 'package:ai_store/screens/products/controller/products_controller.dart';
import 'package:ai_store/screens/products/views/components/category_shop_slider.dart';
import 'package:ai_store/screens/products/views/components/product_grid.dart';
import 'package:ai_store/screens/products/views/components/products_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductsController productsController = Get.put(ProductsController());
  final WishListAndCartListController wishListAndCartListController =
      Get.put(WishListAndCartListController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          children: [
            ProductsHeader(
              productsController: productsController,
              wishListAndCartListController: wishListAndCartListController,
            ),
            const SizedBox(height: 16),
            Obx(() => productsController.isLoading.value
                ? const Expanded(child: CustomLoading(withOpacity: 0.0))
                : Expanded(
                    child: Column(
                      children: [
                        CategoryShopSlider(
                          productsController: productsController,
                          selectedIndex: productsController.selectedIndex.value,
                          onCategorySelected:
                              productsController.onCategorySelected,
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Obx(() =>
                              productsController.isProductsLoading.value
                                  ? const CustomLoading(withOpacity: 0.0)
                                  : ProductGrid(
                                      productsController: productsController)),
                        ),
                      ],
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}

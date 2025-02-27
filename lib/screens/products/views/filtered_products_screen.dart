import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/screens/home/controller/category_id_by_products_controller.dart';
import 'package:invoshop/screens/products/views/components/product_filter_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FilteredProductsScreen extends StatefulWidget {
  const FilteredProductsScreen(
      {super.key,
      required this.categoryTitle,
      this.categoryID,
      this.brandID,
      required this.requestType});

  final String categoryTitle;
  final String? categoryID;
  final String? brandID;
  final String requestType;

  @override
  FilteredProductsScreenState createState() => FilteredProductsScreenState();
}

class FilteredProductsScreenState extends State<FilteredProductsScreen> {
  final CategoryIdByProductsController controller =
      Get.put(CategoryIdByProductsController());

  @override
  void initState() {
    super.initState();
    controller.getCategoryIdByProducts(
        categoryID: widget.categoryID,
        requestType: widget.requestType,
        brandID: widget.brandID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarName: widget.categoryTitle),
      backgroundColor: AppColors.groceryWhite,
      body: Obx(
        () => controller.isLoading.value
            ? const CustomLoading(
                withOpacity: 0.0,
              )
            : Container(
                color: AppColors.groceryWhite,
                padding: REdgeInsets.all(12),
                child: ListView(
                  children: [
                    ProductFilterGrid(
                      controller: controller,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

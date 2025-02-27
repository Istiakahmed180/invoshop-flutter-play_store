import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:invoshop/common/controller/currency_controller.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/screens/home/model/products_model.dart' as model;
import 'package:invoshop/screens/pos/controller/pos_controller.dart';
import 'package:invoshop/screens/pos/view/sub_sections/brand_modal.dart';
import 'package:invoshop/screens/purchase/view/create_purchase_return/sub_sections/return_purchase_bills.dart';

class CreatePurchaseReturn extends StatefulWidget {
  const CreatePurchaseReturn({super.key});

  @override
  State<CreatePurchaseReturn> createState() => _CreatePurchaseReturnState();
}

class _CreatePurchaseReturnState extends State<CreatePurchaseReturn> {
  final PosController posController = Get.put(PosController());
  final CurrencyController currencyController = Get.put(CurrencyController());

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  Future<void> loadData() async {
    posController.isLoading.value = true;
    await posController.getCategories();
    await posController.getBrands();
    await posController.getProducts();
    posController.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(appBarName: "Create Purchase Return"),
        body: Obx(() {
          if (posController.isLoading.value) {
            return const CustomLoading(withOpacity: 0.0);
          }
          return _buildBody();
        }),
        floatingActionButton: Obx(
          () => posController.selectedItems.isNotEmpty
              ? FloatingActionButton.extended(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  onPressed: () {
                    Get.to(ReturnPurchaseBill());
                  },
                  label: Text(
                    "Go Billing",
                    style: TextStyle(
                        color: AppColors.groceryWhite, fontSize: 12.sp),
                  ),
                  backgroundColor: AppColors.groceryPrimary,
                )
              : const SizedBox(),
        ));
  }

  Widget _buildBody() {
    return Column(
      children: [
        SizedBox(height: 12.h),
        _buildSearchField(),
        SizedBox(height: 10.h),
        _buildButtonRow(),
        SizedBox(height: 10.h),
        _buildSectionTitle("Select Purchase Items"),
        SizedBox(height: 10.h),
        _buildProductGrid(),
        SizedBox(height: 12.h),
      ],
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: TextFormField(
        onChanged: (String? value) {
          posController.searchParameter.value = value ?? "";
        },
        decoration: const InputDecoration(
          hintText: "Search Products",
          suffixIcon: Icon(
            Icons.search_outlined,
            color: AppColors.groceryRatingGray,
          ),
        ),
      ),
    );
  }

  Widget _buildButtonRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomElevatedButton(
            buttonName: "Category",
            onPressed: _openCategoryDropdown,
            buttonColor: AppColors.groceryPrimary,
          ),
          CustomElevatedButton(
            buttonName: "Brand",
            onPressed: () => BrandModal.show(context, posController),
            buttonColor: AppColors.secondaryColor,
          ),
          CustomElevatedButton(
            buttonName: "Featured",
            onPressed: () => posController.getFeaturedProducts(),
            buttonColor: AppColors.groceryWarning,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14.sp,
      ),
    );
  }

  Widget _buildProductGrid() {
    return Obx(
      () => Expanded(
        child: posController.isProductsLoading.value
            ? const CustomLoading(
                withOpacity: 0.0,
              )
            : posController.filteredProducts.isEmpty
                ? Center(
                    child: Text(
                      'No products available',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.groceryPrimary.withOpacity(0.5),
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: posController.filteredProducts.length,
                      itemBuilder: (context, index) {
                        final model.ProductsData product =
                            posController.filteredProducts[index];
                        final bool isSelected =
                            posController.selectedItems.contains(product);
                        return _buildProductItem(
                            product: product, isSelected: isSelected);
                      },
                    ),
                  ),
      ),
    );
  }

  Widget _buildProductItem({
    required model.ProductsData product,
    required bool isSelected,
  }) {
    return Obx(() => InkWell(
          highlightColor: AppColors.groceryPrimary.withOpacity(0.1),
          splashColor: AppColors.groceryPrimary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.r),
          onTap: () {
            if (posController.selectedItems.contains(product)) {
              posController.selectedItems.remove(product);
            } else {
              posController.selectedItems.add(product);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: posController.selectedItems.contains(product)
                    ? AppColors.groceryPrimary
                    : AppColors.groceryRatingGray.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: FutureBuilder<String>(
                    future: _getValidImageUrl(product),
                    builder: (context, snapshot) {
                      if (snapshot.hasError ||
                          !snapshot.hasData ||
                          snapshot.data!.isEmpty) {
                        return _buildErrorImage();
                      }

                      return CachedNetworkImage(
                        width: MediaQuery.of(context).size.width * 0.2,
                        imageUrl: snapshot.data!,
                        placeholder: (context, url) =>
                            Image.asset("assets/gif/loading.gif"),
                        errorWidget: (context, url, error) =>
                            _buildErrorImage(),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: REdgeInsets.all(6),
                  child: Column(
                    children: [
                      Text(
                        product.title ?? 'Untitled Product',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "${currencyController.currencySymbol}${product.price ?? '0.00'}",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.groceryPrimary.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<String> _getValidImageUrl(model.ProductsData product) async {
    if (product.image?.path == null || product.image!.path!.isEmpty) {
      return '';
    }
    try {
      final url = await ApiPath.getImageUrl(product.image!.path!);
      if (url.isEmpty || !Uri.parse(url).hasAuthority) {
        return '';
      }
      return url;
    } catch (e) {
      return '';
    }
  }

  Widget _buildErrorImage() {
    return Container(
      height: 62.h,
      decoration: BoxDecoration(
        color: AppColors.groceryRatingGray.withAlpha(25),
      ),
      child: const Icon(
        Icons.broken_image,
        color: AppColors.groceryRatingGray,
      ),
    );
  }

  void _openCategoryDropdown() {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(20.0, 225.0, 100.0, 0),
      elevation: 0,
      popUpAnimationStyle: AnimationStyle(
        reverseDuration: const Duration(milliseconds: 500),
        duration: const Duration(milliseconds: 500),
      ),
      color: AppColors.groceryWhite,
      items: posController.categoriesList.map((item) {
        return PopupMenuItem(
          value: item.title,
          child: Text(item.title!),
        );
      }).toList(),
    ).then((value) async {
      if (value != null) {
        posController.categoryId.value = posController.categoriesList
                .firstWhere((item) => item.title == value)
                .id ??
            0;
        await posController.getCategoryIdByProducts();
      }
    });
  }
}

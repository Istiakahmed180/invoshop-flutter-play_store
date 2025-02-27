import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:invoshop/common/controller/bottom_navigation_controller.dart';
import 'package:invoshop/common/controller/currency_controller.dart';
import 'package:invoshop/common/controller/wish_cart_list_controller.dart';
import 'package:invoshop/common/custom_appbar/custom_appbar.dart';
import 'package:invoshop/common/widgets/custom_common_title.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/common/widgets/section_title.dart';
import 'package:invoshop/config/routes/routes.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/constants/user_role.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/screens/home/model/products_model.dart' as model;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailsScreen extends StatefulWidget {
  final model.ProductsData product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  ProductDetailsScreenState createState() => ProductDetailsScreenState();
}

class ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final BottomNavigationController bottomNavigationController =
      Get.put(BottomNavigationController());
  final WishListAndCartListController wishListAndCartListController =
      Get.put(WishListAndCartListController());
  final CurrencyController currencyController = Get.put(CurrencyController());
  String selectedImagePath = '';
  Map<String, dynamic>? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userData = prefs.getString("user");
    if (userData != null && userData.isNotEmpty) {
      setState(() {
        user = jsonDecode(userData);
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.groceryWhite,
      appBar: const CustomAppBar(appBarName: "Product Details"),
      body: isLoading
          ? const CustomLoading(
              withOpacity: 0.0,
            )
          : Container(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildImageGallery(product: widget.product),
                    const SizedBox(height: 8),
                    buildProductDetails(product: widget.product),
                    const SizedBox(height: 8),
                    const Divider(
                      height: 2,
                      color: AppColors.groceryBorder,
                    ),
                    const SizedBox(height: 8),
                    buildAdditionalDetails(product: widget.product),
                    const SizedBox(height: 8),
                    const Divider(
                      height: 2,
                      color: AppColors.groceryBorder,
                    ),
                    const SizedBox(height: 8),
                    buildDescription(product: widget.product),
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildImageGallery({required model.ProductsData product}) {
    return Column(
      children: [
        FutureBuilder<String>(
          future: product.image != null && product.image!.path != null
              ? ApiPath.getImageUrl(product.image!.path!)
              : null,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            }
            final imageUrl = snapshot.data ?? '';
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl:
                    selectedImagePath.isEmpty ? imageUrl : selectedImagePath,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    color: Colors.grey[200],
                  ),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Icon(
                    Icons.broken_image,
                    size: 50,
                    color: AppColors.groceryBorder,
                  ),
                ),
                fit: BoxFit.fill,
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              if (product.images != null)
                ...product.images!.map((productImg) {
                  return FutureBuilder<String>(
                    future: productImg.path != null
                        ? ApiPath.getImageUrl(productImg.path!)
                        : null,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 60,
                            height: 60,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      }
                      final thumbnailUrl = snapshot.data ?? '';
                      return InkWell(
                        onTap: () {
                          if (thumbnailUrl.isNotEmpty) {
                            setState(() {
                              selectedImagePath = thumbnailUrl;
                            });
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: selectedImagePath == thumbnailUrl
                                  ? AppColors.groceryPrimary
                                  : Colors.transparent,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: thumbnailUrl,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  color: Colors.grey[200],
                                ),
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: Icon(
                                  Icons.broken_image,
                                  size: 30,
                                  color: AppColors.groceryBorder,
                                ),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildProductDetails({required model.ProductsData product}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(
                    title: product.title ?? "N/A",
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.groceryPrimary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "${widget.product.availableStock} Items",
                          style: TextStyle(
                            color: AppColors.groceryPrimary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.groceryTextTwo.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "SKU: ${widget.product.productCode}",
                          style: TextStyle(
                            color: AppColors.groceryTextTwo,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Wishlist Button
            IconButton(
              onPressed: () {
                wishListAndCartListController.toggleWishlistItem(
                  product,
                );
              },
              icon: Icon(
                Icons.favorite_border,
                color: AppColors.groceryPrimary,
              ),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.groceryPrimary.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Row(
                children: [
                  ...List.generate(5, (index) {
                    double rating = double.tryParse(widget
                                .product.productReviewsAvgRating
                                ?.toString() ??
                            "0.0") ??
                        0.0;

                    if (index < rating.floor()) {
                      return const Icon(
                        Icons.star,
                        color: AppColors.groceryRating,
                        size: 18,
                      );
                    } else if (index < rating && index >= rating.floor()) {
                      return const Icon(
                        Icons.star_half,
                        color: AppColors.groceryRating,
                        size: 18,
                      );
                    } else {
                      return const Icon(
                        Icons.star_border,
                        color: AppColors.groceryRating,
                        size: 18,
                      );
                    }
                  }),
                  const SizedBox(width: 8),
                  Text(
                    double.tryParse(widget.product.productReviewsAvgRating
                                    ?.toString() ??
                                "0.0")
                            ?.toStringAsFixed(1) ??
                        "0.0",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "(${widget.product.productReviewsCount ?? 0} reviews)",
                    style: TextStyle(
                      color: AppColors.groceryTextTwo,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Visibility(
            visible: widget.product.colorVariant!.isNotEmpty,
            child: SizedBox(height: 10.h)),
        Visibility(
          visible: widget.product.colorVariant!.isNotEmpty,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Color",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 5.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...widget.product.colorVariant!.map((item) {
                      return Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.groceryBorder),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Text(
                            item.name!,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.groceryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
        Visibility(
            visible: widget.product.sizeVariant!.isNotEmpty,
            child: SizedBox(height: 10.h)),
        Visibility(
          visible: widget.product.sizeVariant!.isNotEmpty,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Size",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 5.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...widget.product.sizeVariant!.map((item) {
                      return Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Container(
                          width: 35.w,
                          height: 35.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.groceryBorder),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              item.name!,
                              style: TextStyle(
                                color: AppColors.groceryText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
        Visibility(
            visible: widget.product.categories!.isNotEmpty,
            child: SizedBox(height: 10.h)),
        Visibility(
          visible: widget.product.categories!.isNotEmpty,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Categories",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 5.h),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.product.categories!
                    .map((item) => Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.groceryPrimary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            item.title!,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.groceryPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: TextStyle(
                      color: AppColors.groceryTextTwo,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        '${currencyController.currencySymbol}${double.tryParse(product.salePrice!)! == 0 && double.tryParse(product.salePrice!)! > double.tryParse(product.price!)! ? product.salePrice! : product.price!}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.groceryPrimary,
                          fontSize: 20,
                        ),
                      ),
                      if (double.tryParse(product.salePrice!)! > 0 &&
                          double.tryParse(product.salePrice!)! <
                              double.tryParse(product.price!)!)
                        Row(
                          children: [
                            SizedBox(width: 8.w),
                            Text(
                              '${currencyController.currencySymbol}${product.price!}',
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: AppColors.groceryTextTwo,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "${(100 - (double.parse(product.salePrice!) / double.parse(product.price!) * 100)).round()}% OFF",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
              Visibility(
                visible: user!["user_role"] == UserRole.customer ||
                    user!["user_role"] == UserRole.vendor,
                child: ElevatedButton(
                  onPressed: () {
                    wishListAndCartListController.addToCart(product);
                    Get.toNamed(BaseRoute.cart);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.groceryPrimary,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        color: AppColors.groceryWhite,
                        size: 20,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Add to Cart',
                        style: TextStyle(
                          color: AppColors.groceryWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildAdditionalDetails({required model.ProductsData product}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomTitleText(title: 'Additional Details'),
        const SizedBox(height: 8),
        buildDetailRow('Availability:',
            product.availableStock! <= 0 ? 'Out of Stock' : 'In Stock'),
        buildDetailRow('Brand:', product.brand?.title ?? "N/A"),
        buildDetailRow('Category:', product.categories?[0].title ?? "N/A"),
        buildDetailRow(
            'Size/Weight:',
            product.sizeVariant != null && product.sizeVariant!.isNotEmpty
                ? product.sizeVariant![0].name ?? "N/A"
                : "N/A"),
        buildDetailRow('SKU:', "N/A"),
        buildDetailRow('Ingredients:', "N/A"),
      ],
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.groceryTextTwo,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.groceryTextTwo,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDescription({required model.ProductsData product}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomTitleText(title: 'Description'),
        const SizedBox(height: 8),
        product.description != null && product.description!.isNotEmpty
            ? HtmlWidget(
                product.description!,
                textStyle: TextStyle(
                  fontSize: 14,
                  color: AppColors.groceryTitle,
                ),
              )
            : Text(
                "N/A",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.groceryTitle,
                ),
              ),
      ],
    );
  }

  Widget buildThumbnail(String imagePath, String selectedImagePath) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selectedImagePath == imagePath
                ? AppColors.groceryPrimary
                : AppColors.groceryBorder,
            width: 2.0,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: CachedNetworkImage(
          imageUrl: imagePath,
          height: 60,
          width: 60,
          fit: BoxFit.cover,
          placeholder: (context, url) => Image.asset("assets/gif/loading.gif"),
          errorWidget: (context, url, error) => const Icon(
            Icons.broken_image,
            size: 50,
            color: AppColors.groceryBorder,
          ),
        ),
      ),
    );
  }
}

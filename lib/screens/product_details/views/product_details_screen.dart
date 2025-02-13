import 'dart:convert';

import 'package:ai_store/common/controller/bottom_navigation_controller.dart';
import 'package:ai_store/common/controller/wish_cart_list_controller.dart';
import 'package:ai_store/common/custom_appbar/custom_appbar.dart';
import 'package:ai_store/common/widgets/custom_common_title.dart';
import 'package:ai_store/common/widgets/custom_outline_button.dart';
import 'package:ai_store/common/widgets/loading/custom_loading.dart';
import 'package:ai_store/common/widgets/section_title.dart';
import 'package:ai_store/config/routes/routes.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/constants/user_role.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/screens/home/model/products_model.dart' as model;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          : SafeArea(
              child: Container(
                color: AppColors.groceryWhite,
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
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
              return Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset("assets/gif/loading.gif"),
              );
            }

            final imageUrl = snapshot.data ?? '';
            return Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl:
                    selectedImagePath.isEmpty ? imageUrl : selectedImagePath,
                placeholder: (context, url) =>
                    Image.asset("assets/gif/loading.gif"),
                errorWidget: (context, url, error) => const Icon(
                  Icons.broken_image,
                  size: 50,
                  color: AppColors.groceryBorder,
                ),
                fit: BoxFit.cover,
              ),
            );
          },
        ),
        const SizedBox(height: 8),
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
                        return const SizedBox(
                          width: 60,
                          height: 60,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final thumbnailUrl = snapshot.data ?? '';
                      return GestureDetector(
                        onTap: () {
                          if (thumbnailUrl.isNotEmpty) {
                            setState(() {
                              selectedImagePath = thumbnailUrl;
                            });
                          }
                        },
                        child: buildThumbnail(thumbnailUrl, selectedImagePath),
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
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth < 380
        ? 90.0
        : screenWidth >= 380 && screenWidth <= 400
            ? 100.0
            : 110.0;

    double fontSize = screenWidth < 400 ? 14 : 16;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: product.title ?? "N/A"),
        Row(
          children: [
            ...List.generate(5, (index) {
              if (index < 4.5.floor()) {
                return const Icon(
                  Icons.star,
                  color: AppColors.groceryRating,
                  size: 16,
                );
              } else if (index < 4.5 && index + 1 > 4.5) {
                return const Icon(
                  Icons.star_half,
                  color: AppColors.groceryRating,
                  size: 16,
                );
              } else {
                return const Icon(
                  Icons.star_border,
                  color: AppColors.groceryRatingGray,
                  size: 16,
                );
              }
            }),
            const SizedBox(width: 2),
            const Text(
              "4.5",
              style: TextStyle(color: AppColors.groceryTextTwo),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  '\$${double.tryParse(product.salePrice!)! == 0 && double.tryParse(product.salePrice!)! > double.tryParse(product.price!)! ? product.salePrice! : product.price!}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.groceryPrimary,
                  ),
                ),
                const SizedBox(width: 8),
                if (double.tryParse(product.salePrice!)! > 0)
                  Text(
                    '\$${product.price!}',
                    style: const TextStyle(
                      fontSize: 10,
                      decoration: TextDecoration.lineThrough,
                      color: AppColors.groceryTextTwo,
                    ),
                  ),
              ],
            ),
            Visibility(
              visible: user!["user_role"] == UserRole.customer,
              child: Row(
                children: [
                  SizedBox(
                    width: buttonWidth,
                    child: CustomButtonBorder(
                      title: 'Wishlist',
                      onPressed: () {
                        wishListAndCartListController.toggleWishlistItem(
                          product,
                        );
                      },
                      textStyle: TextStyle(
                          fontSize: fontSize, color: AppColors.groceryPrimary),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: buttonWidth,
                    child: ElevatedButton(
                      onPressed: () {
                        wishListAndCartListController.addToCart(product);
                        Get.toNamed(BaseRoute.cart);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.groceryPrimary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        'Buy Now',
                        style: TextStyle(
                          fontSize: fontSize,
                          color: AppColors.groceryWhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
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
        Text(
          product.description != null && product.description!.isNotEmpty
              ? product.description ?? "N/A"
              : "N/A",
          style: const TextStyle(
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

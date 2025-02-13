import 'dart:convert';

import 'package:ai_store/common/controller/wish_cart_list_controller.dart';
import 'package:ai_store/common/widgets/custom_common_title.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/constants/user_role.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/screens/home/model/products_model.dart';
import 'package:ai_store/screens/product_details/views/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCard extends StatefulWidget {
  final ProductsData product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final WishListAndCartListController wishListAndCartListController =
      Get.put(WishListAndCartListController());

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
    if (isLoading) {
      return const SizedBox();
    }

    return InkWell(
      onTap: () {
        Get.to(ProductDetailsScreen(product: widget.product));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.groceryBodyTwo,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.groceryBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 145,
                  color: AppColors.groceryBodyTwo,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: FutureBuilder<String>(
                      future: ApiPath.getImageUrl(widget.product.image!.path!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        }
                        if (snapshot.hasError) {
                          return const Icon(
                            Icons.broken_image,
                            size: 50,
                            color: AppColors.groceryBorder,
                          );
                        }
                        return Align(
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: FadeInImage.assetNetwork(
                              height: 130,
                              width: 170,
                              fit: BoxFit.contain,
                              placeholder: "assets/gif/loading.gif",
                              image: snapshot.data!,
                              imageErrorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                Icons.broken_image,
                                color: AppColors.groceryRatingGray,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                if ((double.tryParse(widget.product.discount!) ?? 0) > 0)
                  Positioned(
                    top: 8,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.grocerySecondary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '${double.tryParse(widget.product.discount!)}% Off',
                        style: const TextStyle(
                          color: AppColors.groceryWhite,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                Visibility(
                  visible: user!["user_role"] == UserRole.customer,
                  child: Positioned(
                    top: 8,
                    right: 12,
                    child: InkWell(
                      onTap: () {
                        wishListAndCartListController.toggleWishlistItem(
                          widget.product,
                        );
                      },
                      child: Obx(() {
                        bool isProductInWishlist = wishListAndCartListController
                            .wishlistProductList
                            .any((p) => p.id == widget.product.id);
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: SvgPicture.asset(
                            isProductInWishlist
                                ? 'assets/icons/fill-heart.svg'
                                : 'assets/icons/heart-icon.svg',
                            width: 18,
                            height: 18,
                            colorFilter: ColorFilter.mode(
                                isProductInWishlist
                                    ? AppColors.grocerySecondary
                                    : AppColors.groceryTitle,
                                BlendMode.srcIn),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: AppColors.groceryWhite,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8.r),
                      bottomRight: Radius.circular(8.r))),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ...List.generate(5, (index) {
                              if (index < 4.0.floor()) {
                                return const Icon(
                                  Icons.star,
                                  color: AppColors.groceryRating,
                                  size: 12,
                                );
                              } else if (index < 4.0 && index + 1 > 4.0) {
                                return const Icon(
                                  Icons.star_half,
                                  color: AppColors.groceryRating,
                                  size: 12,
                                );
                              } else {
                                return const Icon(
                                  Icons.star_border,
                                  color: AppColors.groceryRatingGray,
                                  size: 12,
                                );
                              }
                            }),
                            const SizedBox(width: 2),
                            const Text(
                              "(4.0)",
                              style: TextStyle(
                                  color: AppColors.groceryTextTwo,
                                  fontSize: 12),
                            )
                          ],
                        ),
                        Visibility(
                          visible: user!["user_role"] == UserRole.customer,
                          replacement: SizedBox(
                            height: 28.h,
                          ),
                          child: InkWell(
                            onTap: () {
                              wishListAndCartListController
                                  .addToCart(widget.product);
                            },
                            child: Obx(() {
                              bool isProductInCart =
                                  wishListAndCartListController.cartProductsList
                                      .any((p) => p.id == widget.product.id);
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                child: SvgPicture.asset(
                                  isProductInCart
                                      ? 'assets/icons/shopping_fill.svg'
                                      : 'assets/icons/trolly-two.svg',
                                  width: 18,
                                  height: 18,
                                  colorFilter: ColorFilter.mode(
                                      isProductInCart
                                          ? AppColors.grocerySecondary
                                          : AppColors.groceryTitle,
                                      BlendMode.srcIn),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    CustomTitleText(
                      title: widget.product.title!,
                    ),
                    const SizedBox(height: 9),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '\$${double.tryParse(widget.product.salePrice!)! == 0 && double.tryParse(widget.product.salePrice!)! > double.tryParse(widget.product.price!)! ? widget.product.salePrice! : widget.product.price!}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.groceryPrimary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (double.tryParse(widget.product.salePrice!)! > 0)
                              Text(
                                '\$${widget.product.price!}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  decoration: TextDecoration.lineThrough,
                                  color: AppColors.groceryTextTwo,
                                ),
                              ),
                          ],
                        ),
                        const Text(
                          "500Gm",
                          style: TextStyle(
                            color: AppColors.groceryTextTwo,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

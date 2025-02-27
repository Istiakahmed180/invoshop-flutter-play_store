import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:invoshop/common/controller/currency_controller.dart';
import 'package:invoshop/common/controller/wish_cart_list_controller.dart';
import 'package:invoshop/common/widgets/custom_common_title.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/constants/user_role.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/screens/home/model/products_model.dart';
import 'package:invoshop/screens/product_details/views/product_details_screen.dart';
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
  final CurrencyController currencyController = Get.put(CurrencyController());

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
        Get.to(() => ProductDetailsScreen(product: widget.product));
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
                    child: FutureBuilder(
                      future:
                          ApiPath.getImageUrl(widget.product.image?.path ?? ''),
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
                              fit: BoxFit.fill,
                              placeholder: "assets/gif/loading.gif",
                              image: snapshot.data ?? '',
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
                if ((double.tryParse(widget.product.discount ?? '0') ?? 0) > 0)
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
                        '${double.tryParse(widget.product.discount ?? '0')}% Off',
                        style: const TextStyle(
                          color: AppColors.groceryWhite,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                Visibility(
                  visible: user?["user_role"] == UserRole.customer ||
                      user?["user_role"] == UserRole.vendor,
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
                              BlendMode.srcIn,
                            ),
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
                    bottomRight: Radius.circular(8.r),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  // Full star
                                  return const Icon(
                                    Icons.star,
                                    color: AppColors.groceryRating,
                                    size: 15,
                                  );
                                } else if (index < rating &&
                                    index >= rating.floor()) {
                                  // Half star
                                  return const Icon(
                                    Icons.star_half,
                                    color: AppColors.groceryRating,
                                    size: 15,
                                  );
                                } else {
                                  // Empty star
                                  return const Icon(
                                    Icons.star_border,
                                    color: AppColors.groceryRating,
                                    size: 15,
                                  );
                                }
                              }),
                              const SizedBox(width: 2),
                              Text(
                                "(${widget.product.productReviewsCount ?? 0})",
                                style: TextStyle(
                                  color: AppColors.groceryTextTwo,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: user?["user_role"] == UserRole.customer ||
                                user?["user_role"] == UserRole.vendor,
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
                                    wishListAndCartListController
                                        .cartProductsList
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
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      CustomTitleText(
                        title: widget.product.title ?? '',
                      ),
                      const SizedBox(height: 9),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${currencyController.currencySymbol}${double.tryParse(widget.product.salePrice ?? '0') ?? 0}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.groceryPrimary,
                            ),
                          ),
                          Visibility(
                            visible:
                                double.parse(widget.product.weight!).toInt() !=
                                    0,
                            child: Text(
                              _formatWeight(widget.product.weight!),
                              style: TextStyle(
                                color: AppColors.groceryTextTwo,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatWeight(String weight) {
    try {
      double parsedWeight = double.parse(weight);
      if (parsedWeight < 1000) {
        return "${parsedWeight.toInt()}Gm";
      } else {
        return "${(parsedWeight / 1000).toStringAsFixed(2)}Kg";
      }
    } catch (e) {
      return "N/A";
    }
  }
}

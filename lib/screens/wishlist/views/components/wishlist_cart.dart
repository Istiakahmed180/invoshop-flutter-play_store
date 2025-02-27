import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:invoshop/common/controller/currency_controller.dart';
import 'package:invoshop/common/controller/wish_cart_list_controller.dart';
import 'package:invoshop/common/widgets/custom_elevated_button.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/constants/app_colors.dart';

class WishlistCartList extends StatefulWidget {
  const WishlistCartList({super.key});

  @override
  State<WishlistCartList> createState() => _WishlistCartListState();
}

class _WishlistCartListState extends State<WishlistCartList> {
  final WishListAndCartListController wishListAndCartListController =
      Get.put(WishListAndCartListController());
  final CurrencyController currencyController = Get.put(CurrencyController());

  @override
  void initState() {
    super.initState();
    wishListAndCartListController.fetchWishlistProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (wishListAndCartListController.isLoading.value) {
        return const CustomLoading(
          withOpacity: 0.0,
        );
      }

      if (wishListAndCartListController.wishlistProductList.isEmpty) {
        return Center(
          child: Text(
            'Your Wishlist is empty',
            style: TextStyle(fontSize: 16.sp, color: AppColors.groceryTextTwo),
          ),
        );
      }

      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount:
                  wishListAndCartListController.wishlistProductList.length,
              itemBuilder: (context, index) {
                final product =
                    wishListAndCartListController.wishlistProductList[index];
                final imageUrl = wishListAndCartListController
                        .getImageUrl(product.image?.path) ??
                    '';

                return Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 90.w,
                          height: 80.h,
                          decoration: BoxDecoration(
                            color: AppColors.groceryBodyTwo,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              placeholder: (context, url) =>
                                  Image.asset("assets/gif/loading.gif"),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.broken_image,
                                color: AppColors.groceryRatingGray,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.title ?? "N/A",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.groceryTitle),
                                        ),
                                        const Text(
                                          "500Gm",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.groceryTextTwo,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.close,
                                        size: 18.sp,
                                        color: AppColors.groceryText),
                                    onPressed: () {
                                      wishListAndCartListController
                                          .removeFromWishlist(product);
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${currencyController.currencySymbol}${product.price}',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.groceryPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      CustomElevatedButton(
                                        buttonName: "Add to Cart",
                                        buttonColor: AppColors.groceryPrimary,
                                        onPressed: () {
                                          wishListAndCartListController
                                              .addToCart(product);
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: AppColors.groceryBorder,
                      thickness: 1,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      );
    });
  }
}

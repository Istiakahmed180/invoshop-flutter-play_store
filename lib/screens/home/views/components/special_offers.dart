import 'dart:async';
import 'dart:convert';

import 'package:ai_store/common/controller/wish_cart_list_controller.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/constants/user_role.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/screens/home/model/products_model.dart' as model;
import 'package:ai_store/screens/product_details/views/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpecialOffersCard extends StatefulWidget {
  final model.ProductsData product;

  const SpecialOffersCard({super.key, required this.product});

  @override
  SpecialOffersCardState createState() => SpecialOffersCardState();
}

class SpecialOffersCardState extends State<SpecialOffersCard> {
  final WishListAndCartListController wishListAndCartListController =
      Get.put(WishListAndCartListController());
  Duration _timeLeft =
      const Duration(days: 2, hours: 3, minutes: 45, seconds: 30);
  Timer? _timer;
  late Future<String> _imageFuture;
  Map<String, dynamic>? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _imageFuture = ApiPath.getImageUrl(widget.product.image!.path!);
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

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft.inSeconds > 0) {
        setState(() {
          _timeLeft = _timeLeft - const Duration(seconds: 1);
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTimeLeft() {
    final days = _timeLeft.inDays;
    final hours = _timeLeft.inHours % 24;
    final minutes = _timeLeft.inMinutes % 60;
    final seconds = _timeLeft.inSeconds % 60;
    return "${days}D: ${hours}H: ${minutes}M: ${seconds}S";
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
          color: AppColors.groceryWhite,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.groceryBorder),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Positioned(
                  top: -1,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.groceryBodyTwo,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: const Text(
                      "Hurry",
                      style: TextStyle(
                        color: AppColors.groceryTitle,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 160,
                  width: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FutureBuilder<String>(
                        future: _imageFuture,
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
                          return FadeInImage.assetNetwork(
                            height: 100,
                            width: 100,
                            placeholder: "assets/gif/loading.gif",
                            image: snapshot.data!,
                            imageErrorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.broken_image,
                              color: AppColors.groceryRatingGray,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                if ((double.tryParse(widget.product.discount!) ?? 0) > 0)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/icons/offer-bg.png',
                          height: 45,
                          width: 45,
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Sale',
                                  style: TextStyle(
                                    color: AppColors.groceryWhite,
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  "${double.tryParse(widget.product.discount!)!.toInt()}%",
                                  style: const TextStyle(
                                    color: AppColors.groceryWhite,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
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
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 8),
                decoration: const BoxDecoration(
                  color: AppColors.groceryBodyTwo,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            widget.product.title!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.groceryTitle,
                            ),
                          ),
                          const SizedBox(height: 8.0),
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
                              if (double.tryParse(widget.product.salePrice!)! >
                                  0)
                                Text(
                                  '\$${widget.product.price}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    decoration: TextDecoration.lineThrough,
                                    color: AppColors.groceryTextTwo,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          const Row(
                            children: [
                              Text(
                                'Available: ',
                                style: TextStyle(
                                  color: AppColors.groceryTextTwo,
                                  fontSize: 12.0,
                                ),
                              ),
                              SizedBox(width: 2),
                              Text(
                                '2025 Products',
                                style: TextStyle(
                                  color: AppColors.groceryPrimary,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.grocerySecondary,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  _formatTimeLeft(),
                                  style: const TextStyle(
                                    color: AppColors.groceryWhite,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible:
                                    user!["user_role"] == UserRole.customer,
                                replacement: SizedBox(
                                  height: 22.h,
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
                                            .any((p) =>
                                                p.id == widget.product.id);
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

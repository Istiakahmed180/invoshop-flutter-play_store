import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:invoshop/common/controller/wish_cart_list_controller.dart';
import 'package:invoshop/config/routes/routes.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/constants/user_role.dart';
import 'package:invoshop/screens/products/controller/products_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsHeader extends StatefulWidget {
  final ProductsController productsController;
  final WishListAndCartListController wishListAndCartListController;

  const ProductsHeader(
      {super.key,
      required this.productsController,
      required this.wishListAndCartListController});

  @override
  State<ProductsHeader> createState() => _ProductsHeaderState();
}

class _ProductsHeaderState extends State<ProductsHeader> {
  Map<String, dynamic>? user;

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
  }

  @override
  Widget build(BuildContext context) {
    if (user == null || user!["user_role"] == null) {
      return const SizedBox();
    }

    return Column(
      children: [
        _buildHeaderRow(context),
        SizedBox(height: 15.w),
        _buildSearchBar(),
      ],
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogoWithDrawer(context),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildLogoWithDrawer(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30.r),
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: Image.asset(
        "assets/logos/logo_bg.png",
        width: MediaQuery.of(context).size.width * 0.3,
        height: 30,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Obx(
          () => Visibility(
            visible: user!["user_role"] == UserRole.customer ||
                user!["user_role"] == UserRole.vendor,
            child: _buildIconWithBadge(
              iconPath: 'assets/icons/heart-bold.svg',
              badgeCount:
                  widget.wishListAndCartListController.wishlistItemCount.value,
              onTap: () => Get.toNamed(BaseRoute.myWishlist),
            ),
          ),
        ),
        Obx(
          () => Visibility(
            visible: user!["user_role"] == UserRole.customer ||
                user!["user_role"] == UserRole.vendor,
            child: _buildIconWithBadge(
              iconPath: 'assets/icons/bag-icon.svg',
              badgeCount:
                  widget.wishListAndCartListController.cartItemCount.value,
              onTap: () => Get.toNamed(BaseRoute.cart),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIconWithBadge({
    required String iconPath,
    required int badgeCount,
    required VoidCallback onTap,
  }) {
    return IconButton(
      onPressed: onTap,
      icon: Badge(
        backgroundColor: AppColors.groceryPrimary,
        label: Text(
          '$badgeCount',
          style: const TextStyle(
            color: AppColors.groceryWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: SvgPicture.asset(
          iconPath,
          width: 22,
          height: 22,
          colorFilter:
              const ColorFilter.mode(AppColors.groceryTitle, BlendMode.srcIn),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.productsController.searchController,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.grocerySubTitle,
                size: 20,
              ),
              border: InputBorder.none,
              hintText: "Search Products",
              hintStyle: TextStyle(
                color: AppColors.grocerySubTitle,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            style: const TextStyle(
              color: AppColors.grocerySubTitle,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        OutlinedButton(
            onPressed: () {
              widget.productsController.searchProducts(
                  widget.productsController.searchController.text);
            },
            style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10.w),
                side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r))),
            child: const Text("Search",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.groceryPrimary,
                )))
      ],
    );
  }
}

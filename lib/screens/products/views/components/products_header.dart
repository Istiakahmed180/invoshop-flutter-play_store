import 'package:ai_store/common/controller/wish_cart_list_controller.dart';
import 'package:ai_store/config/routes/routes.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/screens/products/controller/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProductsHeader extends StatelessWidget {
  final ProductsController productsController;
  final WishListAndCartListController wishListAndCartListController;

  const ProductsHeader(
      {super.key,
      required this.productsController,
      required this.wishListAndCartListController});

  @override
  Widget build(BuildContext context) {
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
      child: Row(
        children: [
          Image.asset(
            "assets/logos/logo-splash.png",
            width: MediaQuery.of(context).size.width * 0.07,
          ),
          Text(
            "Invoshop",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Obx(
          () => _buildIconWithBadge(
            iconPath: 'assets/icons/heart-bold.svg',
            badgeCount: wishListAndCartListController.wishlistItemCount.value,
            onTap: () => Get.toNamed(BaseRoute.myWishlist),
          ),
        ),
        Obx(
          () => _buildIconWithBadge(
            iconPath: 'assets/icons/bag-icon.svg',
            badgeCount: wishListAndCartListController.cartItemCount.value,
            onTap: () => Get.toNamed(BaseRoute.cart),
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
            controller: productsController.searchController,
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
              productsController
                  .searchProducts(productsController.searchController.text);
            },
            style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10.w),
                side: BorderSide(color: Colors.grey.withOpacity(0.2)),
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

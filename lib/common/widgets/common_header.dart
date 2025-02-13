import 'dart:convert';

import 'package:ai_store/common/controller/bottom_navigation_controller.dart';
import 'package:ai_store/common/controller/wish_cart_list_controller.dart';
import 'package:ai_store/common/widgets/custom_common_title.dart';
import 'package:ai_store/common/widgets/loading/custom_loading.dart';
import 'package:ai_store/config/routes/routes.dart';
import 'package:ai_store/constants/app_colors.dart';
import 'package:ai_store/constants/user_role.dart';
import 'package:ai_store/network/api/api_path.dart';
import 'package:ai_store/screens/home/controller/search_controller.dart';
import 'package:ai_store/screens/home/model/products_model.dart' as model;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonHeader extends StatefulWidget {
  const CommonHeader({super.key});

  @override
  State<CommonHeader> createState() => _CommonHeaderState();
}

class _CommonHeaderState extends State<CommonHeader> {
  final BottomNavigationController controller =
      Get.put(BottomNavigationController());
  final SearchingController searchingController =
      Get.put(SearchingController());
  final WishListAndCartListController wishListAndCartListController =
      Get.put(WishListAndCartListController());
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
    return Column(
      children: [
        _buildHeaderRow(context),
      ],
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogo(context),
        _buildActionIcons(context),
      ],
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w),
      child: InkWell(
        borderRadius: BorderRadius.circular(30.r),
        onTap: () => Scaffold.of(context).openDrawer(),
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
      ),
    );
  }

  Widget _buildActionIcons(BuildContext context) {
    if (user == null || user!["user_role"] == null) {
      return const SizedBox();
    }

    return Row(
      children: [
        Visibility(
          visible: user!["user_role"] == UserRole.customer,
          child: Obx(
            () => _buildIconWithBadge(
              iconPath: 'assets/icons/heart-bold.svg',
              badgeCount: wishListAndCartListController.wishlistItemCount.value,
              onTap: () => Get.toNamed(BaseRoute.myWishlist),
            ),
          ),
        ),
        Visibility(
          visible: user!["user_role"] == UserRole.customer,
          child: Obx(
            () => _buildIconWithBadge(
              iconPath: 'assets/icons/bag-icon.svg',
              badgeCount: wishListAndCartListController.cartItemCount.value,
              onTap: () => Get.toNamed(BaseRoute.cart),
            ),
          ),
        ),
        IconButton(
          onPressed: () => _openSearchModal(context),
          icon: SvgPicture.asset(
            'assets/icons/search-icon.svg',
            width: 22,
            height: 22,
            colorFilter:
                const ColorFilter.mode(AppColors.groceryTitle, BlendMode.srcIn),
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

  void _openSearchModal(BuildContext context) {
    searchingController.getAllProducts();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return _buildSearchModal(context, setModalState);
          },
        );
      },
    );
  }

  Widget _buildSearchModal(BuildContext context, StateSetter setModalState) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: AppColors.groceryBody,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: <Widget>[
          _buildSearchBar(),
          Divider(
            indent: 12.w,
            endIndent: 12.w,
            color: AppColors.groceryRatingGray.withOpacity(0.4),
          ),
          _buildSearchResults(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 12.h),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchingController.searchController,
              decoration: InputDecoration(
                fillColor: AppColors.groceryBody,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.r),
                  borderSide: BorderSide(
                      color: AppColors.groceryRatingGray.withOpacity(0.4),
                      width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.r),
                  borderSide: BorderSide(
                      color: AppColors.groceryRatingGray.withOpacity(0.4),
                      width: 1),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.r),
                  borderSide: BorderSide(
                      color: AppColors.groceryRatingGray.withOpacity(0.4),
                      width: 1),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.grocerySubTitle,
                  size: 20,
                ),
                hintText: "Search Products",
                hintStyle: const TextStyle(
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
                searchingController
                    .searchProducts(searchingController.searchController.text);
              },
              style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10.w),
                  side: BorderSide(
                      color: AppColors.groceryRatingGray.withOpacity(0.4)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r))),
              child: const Text("Search",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.groceryPrimary,
                  )))
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return Obx(
      () => searchingController.isLoading.value
          ? const Expanded(
              child: CustomLoading(
                withOpacity: 0.0,
              ),
            )
          : Expanded(
              child: searchingController.filteredProductList.isNotEmpty
                  ? ListView.builder(
                      itemCount: searchingController.filteredProductList.length,
                      itemBuilder: (context, index) {
                        return _buildSearchResultItem(
                            searchingController.filteredProductList[index]);
                      },
                    )
                  : Center(
                      child: Text(
                        'No Product Available',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grocerySubTitle,
                        ),
                      ),
                    ),
            ),
    );
  }

  Widget _buildSearchResultItem(model.ProductsData product) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: ListTile(
        leading: Container(
          width: 60.w,
          height: 50.h,
          decoration: BoxDecoration(
              color: AppColors.groceryBodyTwo,
              borderRadius: BorderRadius.circular(6.r)),
          child: FutureBuilder(
            future: ApiPath.getImageUrl(product.image!.path!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
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
                width: 50,
                fit: BoxFit.cover,
                placeholder: "assets/gif/loading.gif",
                image: snapshot.data!,
                imageErrorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image,
                  color: AppColors.groceryRatingGray,
                ),
              );
            },
          ),
        ),
        title: CustomTitleText(title: product.title!),
        subtitle: Text(
          '\$${product.price}',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.groceryPrimary,
          ),
        ),
      ),
    );
  }
}

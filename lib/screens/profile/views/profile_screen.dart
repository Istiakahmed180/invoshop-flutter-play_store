import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:invoshop/common/widgets/alert_dialog/custom_alert_dialog.dart';
import 'package:invoshop/common/widgets/custom_common_title.dart';
import 'package:invoshop/common/widgets/loading/custom_loading.dart';
import 'package:invoshop/config/routes/routes.dart';
import 'package:invoshop/constants/app_colors.dart';
import 'package:invoshop/constants/user_role.dart';
import 'package:invoshop/network/api/api_path.dart';
import 'package:invoshop/screens/authentication/sign_in/controller/sign_in_controller.dart';
import 'package:invoshop/screens/profile/views/sub_sections/profile_edit/profile_edit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final SignInController signInController = Get.put(SignInController());
  bool isLoading = false;
  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    isLoading = true;
    setState(() {});
    try {
      await Future.delayed(const Duration(seconds: 1));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userData = prefs.getString("user");
      if (userData != null && userData.isNotEmpty) {
        setState(() {
          user = jsonDecode(userData);
        });
      }
    } finally {
      isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CustomLoading(
            withOpacity: 0.0,
          )
        : Column(
            children: [
              Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: AppColors.groceryBodyTwo,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        SizedBox(height: 25.h),
                        _buildHeader(),
                        SizedBox(height: 16.h),
                        _buildProfileInfo(),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              _buildMenuItems(context, signInController),
            ],
          );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTitleText(
          title: "Profile",
          titleFontSize: 18.sp,
        ),
        InkWell(
          onTap: () {
            Get.to(EditUserProfile(
              name: user?["user_full_name"] ?? "",
              userName: user?["user_name"] ?? "",
              email: user?["user_email"] ?? "",
              phone: user?["user_phone"] ?? "",
              image: user?["user_image"] ?? "",
            ));
          },
          child: SvgPicture.asset(
            "assets/icons/profile/edit.svg",
            width: 16.w,
            colorFilter: const ColorFilter.mode(
                AppColors.groceryPrimary, BlendMode.srcIn),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfo() {
    return Row(
      children: [
        FutureBuilder(
          future: ApiPath.getImageUrl(user?["user_image"] ?? ""),
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
            if (snapshot.hasData) {
              return CircleAvatar(
                backgroundColor: AppColors.groceryBorder.withOpacity(0.5),
                radius: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.r),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    imageUrl: snapshot.data ?? "",
                    placeholder: (context, url) =>
                        Image.asset("assets/gif/loading.gif"),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.broken_image,
                      color: AppColors.groceryRatingGray,
                    ),
                  ),
                ),
              );
            }

            return const Icon(
              Icons.broken_image,
              size: 50,
              color: AppColors.groceryBorder,
            );
          },
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitleText(title: user?["user_full_name"] ?? "N/A"),
            Text(
              user?["user_email"] ?? "N/A",
              style: TextStyle(
                color: AppColors.grocerySubTitle,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuItems(
      BuildContext context, SignInController signInController) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: user!["user_role"] == UserRole.customer ||
                  user!["user_role"] == UserRole.vendor ||
                  user!["user_role"] == UserRole.admin ||
                  user!["user_role"] == UserRole.superAdmin,
              child: _buildMenuItem(
                  "Orders history", "assets/icons/profile/orders_history.svg",
                  () {
                user?["user_role"] == UserRole.vendor ||
                        user?["user_role"] == UserRole.admin ||
                        user?["user_role"] == UserRole.superAdmin
                    ? Get.toNamed(BaseRoute.orders)
                    : Get.toNamed(BaseRoute.customerOrders);
              }),
            ),
            Visibility(
              visible: user!["user_role"] == UserRole.customer ||
                  user!["user_role"] == UserRole.vendor,
              child: _buildMenuItem(
                  "Wishlist", "assets/icons/profile/wishlist.svg", () {
                Get.toNamed(BaseRoute.myWishlist);
              }),
            ),
            Visibility(
              visible: user!["user_role"] == UserRole.customer ||
                  user!["user_role"] == UserRole.vendor,
              child: _buildMenuItem(
                  "My Cart", "assets/icons/profile/add-to-cart.svg", () {
                Get.toNamed(BaseRoute.cart);
              }),
            ),
            Visibility(
              visible: user!["user_role"] == UserRole.customer,
              child: _buildMenuItem(
                  "Reviews", "assets/icons/profile/review.svg", () {
                Get.toNamed(BaseRoute.reviews);
              }),
            ),
            Visibility(
              visible: user!["user_role"] == UserRole.admin ||
                  user!["user_role"] == UserRole.superAdmin,
              child: _buildMenuItem(
                  "My coupons", "assets/icons/profile/coupon.svg", () {
                Get.toNamed(BaseRoute.myCoupon);
              }),
            ),
            Visibility(
              visible: user!["user_role"] == UserRole.customer ||
                  user!["user_role"] == UserRole.admin ||
                  user!["user_role"] == UserRole.superAdmin,
              child: _buildMenuItem(
                  "Transaction", "assets/icons/profile/transaction.svg", () {
                Get.toNamed(BaseRoute.transactions);
              }),
            ),
            _buildMenuItem("Sign out", "assets/icons/drawer/sign_out.svg", () {
              _showLogoutConfirmation(context, signInController);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, String svgIcon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  svgIcon,
                  width: 20.w,
                  colorFilter: const ColorFilter.mode(
                      AppColors.grocerySubTitle, BlendMode.srcIn),
                ),
                SizedBox(width: 10.w),
                title == "Sign out"
                    ? Text(
                        title,
                        style: TextStyle(
                          color: AppColors.grocerySubTitle,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : Text(
                        title,
                        style: TextStyle(
                          color: AppColors.grocerySubTitle,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ],
            ),
            if (title != "Sign out")
              Icon(Icons.arrow_forward_ios_sharp,
                  size: 14.sp, color: AppColors.grocerySubTitle),
          ],
        ),
      ),
    );
  }

  Future<void> _showLogoutConfirmation(
      BuildContext context, SignInController signInController) async {
    return showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        title: "Confirm Sign Out",
        subTitle: "Are you sure you want to sign out?",
        okButtonName: "Sign out",
        pressedOk: () {
          Get.back();
          signInController.signOut();
        },
        noButtonName: "Cancel",
        pressedNo: () => Get.back(),
      ),
    );
  }
}
